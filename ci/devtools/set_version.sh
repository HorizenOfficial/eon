#!/bin/bash
# shellcheck disable=SC2154

set -Eeo pipefail

# Get the directory of the currently executing script and its parent dir
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
base_dir="$( dirname "${current_dir%/*}" )"

TESTS_DOCKER_ORG="${TESTS_DOCKER_ORG:-zencash}"
TESTS_IMAGE_NAME="${TESTS_IMAGE_NAME:-sc-ci-base}"
TESTS_IMAGE_TAG="${TESTS_IMAGE_TAG:-focal_jdk-11_latest}"
image="${TESTS_DOCKER_ORG}/${TESTS_IMAGE_NAME}:${TESTS_IMAGE_TAG}"

have_docker="false"
command -v docker &> /dev/null && have_docker="true"

# Functions
define(){ IFS=$'\n' read -r -d '' "${1}" || true; }

# Script content
define execute << SCRIPT
#!/bin/bash

set -euo pipefail

# Get the directory of the currently executing script and base directory
current_dir=\$(pwd)
if [ "\${current_dir}" == '/build' ]; then
  base_dir='/build'
else
  base_dir="$base_dir"
fi

# Super POM xml file location
super_pom_xml_location="\${base_dir}"

# Functions
function fn_die() {
  echo -e "\${1}" >&2
  exit "\${2:-1}"
}

function usage() {
  cat << BLOCK
  Usage: Provide OLD and NEW versions as the 1st and 2nd arguments respectively.
         It has to match the following format:
         DIGIT.DIGIT.DIGIT or DIGIT.DIGIT.DIGIT-SNAPSHOT

         For example:
         ./set_version.sh 5.5.5 5.5.5-SNAPSHOT
         ./set_version.sh 5.5.5-SNAPSHOT 5.5.5
BLOCK
  fn_die "Exiting ..."
}

# Checking for exact amount of arguments as the first step
if [[ $# -eq 2 ]]; then
    version_old="${1}"
    version_new="${2}"
else
    usage
fi

# Checking the format of the versions
if ! [[ "\${version_old}" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-SNAPSHOT)?$ ]]; then
  usage
fi

if ! [[ "\${version_new}" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-SNAPSHOT)?$ ]]; then
  usage
fi

# Checking if maven is installed
if ! command -v mvn >/dev/null; then
  echo "" && echo "=== Maven needs to be installed!!! ===" && echo ""
  fn_die "Refer to the official Apache Maven Project: https://maven.apache.org/install.html\nExiting ..."
fi

# Changing version numbers under all pom.xml file(s) using Super POM xml file
cd "\${super_pom_xml_location}"
current_pom_version="\$(mvn help:evaluate -q -Dexpression=project.version -DforceStdout 2>/dev/null)"
if [ "\${version_old}" != "\${current_pom_version}" ]; then
  fn_die "Fix it! The OLD version does not match with CURRENT version set under Super POM xml file\nCurrent version is: \${current_pom_version}. \nExiting ..."
fi

echo "" && echo "=== Modifying all pom.xml file(s) through Super POM xml file ===" && echo ""
mvn versions:set -DprocessAllModules=true -DoldVersion="\${version_old}" -DnewVersion="\${version_new}"


echo "" && echo "=== DONE ===" && echo ""
echo -e "OLD version: \${version_old}\nNEW version: \${version_new}"

exit 0
SCRIPT

## If docker is installed running the script inside a container. Otherwise running inside local bash shell
cmd='bash'
if [ "$have_docker" = "true" ]; then
  echo "" && echo "=== Docker is installed. Running the script inside docker container ===" && echo ""
  cmd="docker run --rm -i -v ${base_dir}:/build -w /build ${image} ${cmd}"
fi

${cmd} <<< "${execute}"

