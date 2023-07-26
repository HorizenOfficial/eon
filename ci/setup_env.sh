#!/bin/bash
set -eo pipefail

IS_A_RELEASE="false"
IS_A_GH_PRERELEASE="false"
PROD_RELEASE="false"

ROOT_POM_VERSION="$(xpath -q -e '/project/version/text()' pom.xml)"
node_pom_version="$(xpath -q -e '/project/version/text()' ./node/pom.xml)"
bootstraptool_pom_version="$(xpath -q -e '/project/version/text()' ./bootstraptool/pom.xml)"
export ROOT_POM_VERSION

if [ -z "${TRAVIS_TAG}" ]; then
  echo "TRAVIS_TAG:                     No TAG"
else
  echo "TRAVIS_TAG:                     ${TRAVIS_TAG}"
fi
echo "Root pom.xml version:           ${ROOT_POM_VERSION}"
echo "EON node pom.xml version:       ${node_pom_version}"
echo "Bootstrap tool pom.xml version: ${bootstraptool_pom_version}"


# Functions
function import_gpg_keys() {
  # shellcheck disable=SC2207
  declare -r my_arr=( $(echo "${@}" | tr " " "\n") )

  if [ "${#my_arr[@]}" -eq 0 ]; then
    echo "Warning: there are ZERO gpg keys to import. Please check if *MAINTAINERS_KEYS variable(s) are set correctly. The build is not going to be released ..."
    export IS_A_RELEASE="false"
  else
    # shellcheck disable=SC2145
    printf "%s\n" "Tagged build, fetching keys:" "${@}" ""
    for key in "${my_arr[@]}"; do
      gpg -v --batch --keyserver hkps://keys.openpgp.org --recv-keys "${key}" ||
      gpg -v --batch --keyserver hkp://keyserver.ubuntu.com --recv-keys "${key}" ||
      gpg -v --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "${key}" ||
      gpg -v --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "${key}" ||
      { echo -e "Warning: ${key} can not be found on GPG key servers. Please upload it to at least one of the following GPG key servers:\nhttps://keys.openpgp.org/\nhttps://keyserver.ubuntu.com/\nhttps://pgp.mit.edu/"; export IS_A_RELEASE="false"; }
    done
  fi
}

function check_signed_tag() {
  local tag="${1}"

  # Checking if git tag signed by the maintainers
  if git verify-tag -v "${tag}"; then
    echo "${tag} is a valid signed tag"
    export IS_A_RELEASE="true"
  else
    echo "" && echo "=== Warning: GIT's tag = ${tag} signature is NOT valid. The build is not going to be released ... ===" && echo ""
  fi
}

function  check_versions_match () {
  local versions_to_check=("$@")

  if [ "${#versions_to_check[@]}" -eq 1 ]; then
    echo "Warning: ${FUNCNAME[0]} requires more than one version to be able to compare with.  The build is not going to be released ..."
    export IS_A_RELEASE="false" && return
  fi

  for (( i=0; i<((${#versions_to_check[@]}-1)); i++ )); do
    [ "${versions_to_check[$i]}" != "${versions_to_check[(($i+1))]}" ] &&
    { echo -e "Warning: one or more module(s) versions do NOT match. The build is not going to be released ... !!!\nThe versions are ${versions_to_check[*]}"; export IS_A_RELEASE="false" && break; }
  done

  export IS_A_RELEASE="true"
}

# Checking if it a release build
if [ -n "${TRAVIS_TAG}" ]; then
  echo "The current production release branch is: ${PROD_RELEASE_BRANCH}"
  echo "The current development release branch is: ${DEV_RELEASE_BRANCH}"

  # checking if PROD_MAINTAINERS_KEYS and DEV_MAINTAINERS_KEYS are set
  if [[ -z "${PROD_MAINTAINERS_KEYS}" || -z "${DEV_MAINTAINERS_KEYS}" ]]; then
    echo "Warning: PROD_MAINTAINERS_KEYS and/or DEV_MAINTAINERS_KEYS variables are not set. Make sure to set it up for PROD|DEV release build !!!"
  fi
  all_maintainers_keys=$(echo "${PROD_MAINTAINERS_KEYS} ${DEV_MAINTAINERS_KEYS}" | xargs -n1 | sort -u | xargs)

  # Prod vs development release
  if ( git branch -r --contains "${TRAVIS_TAG}" | grep -xqE ". origin\/${PROD_RELEASE_BRANCH}$" ); then
    import_gpg_keys "${PROD_MAINTAINERS_KEYS}"
    check_signed_tag "${TRAVIS_TAG}"
    check_versions_match "${ROOT_POM_VERSION}" "${node_pom_version}" "${bootstraptool_pom_version}"

    if ! [[ "${ROOT_POM_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-RC[0-9]+)?$ ]]; then
      echo "Warning: package(s) version is in the wrong format for PRODUCTION} release. Expecting: d.d.d(-RC[0-9]+)?. The build is not going to be released !!!"
      export IS_A_RELEASE="false"
    fi

    # Checking Github tag format
    if ! [[ "${TRAVIS_TAG}" == "${ROOT_POM_VERSION}" ]]; then
      echo "" && echo "=== Warning: GIT tag format differs from the pom file version. ===" && echo ""
      echo -e "Github tag name: ${TRAVIS_TAG}\nPom file version: ${ROOT_POM_VERSION}.\nThe build is not going to be released !!!"
      export IS_A_RELEASE="false"
    fi

    if [ "${IS_A_RELEASE}" = "true" ]; then
      echo "" && echo "=== Production release ===" && echo ""

      export PROD_RELEASE="true"
      export IS_A_GH_PRERELEASE="false"
    fi
  elif ( git branch -r --contains "${TRAVIS_TAG}" | grep -xqE ". origin\/${DEV_RELEASE_BRANCH}$" ); then
    import_gpg_keys "${all_maintainers_keys}"
    check_signed_tag "${TRAVIS_TAG}"
    check_versions_match "${ROOT_POM_VERSION}" "${node_pom_version}" "${bootstraptool_pom_version}"

    if ! [[ "${ROOT_POM_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-RC[0-9]+)?(-SNAPSHOT){1}$ ]]; then
      echo "Warning: package(s) version is in the wrong format for DEVELOPMENT release. Expecting: d.d.d(-RC[0-9]+)?(-SNAPSHOT){1}. The build is not going to be released !!!"
      export IS_A_RELEASE="false"
    fi

    # Checking Github tag format
    if ! [[ "${TRAVIS_TAG}" =~ "${ROOT_POM_VERSION}"[0-9]*$ ]]; then
      echo "" && echo "=== Warning: GIT tag format differs from the pom file version. ===" && echo ""
      echo -e "Github tag name: ${TRAVIS_TAG}\nPom file version: ${ROOT_POM_VERSION}.\nThe build is not going to be released !!!"
      export IS_A_RELEASE="false"
    fi

    if [ "${IS_A_RELEASE}" = "true" ]; then
      echo "" && echo "=== Development release ===" && echo ""

      export PROD_RELEASE="false"
      export IS_A_GH_PRERELEASE="true"
    fi
  fi
fi

# Final check for release vs non-release build
if [ "${IS_A_RELEASE}" = "false" ]; then
  echo "" && echo "=== NOT a release build ===" && echo ""

  export IS_A_RELEASE="false"
fi

set +eo pipefail
