#!/bin/bash
set -eEuo pipefail

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
evmapp_docker_image_name="${EVMAPP_DOCKER_IMAGE_NAME:-evmapp}"
bootstraptool_docker_image_name="${BOOTSTRAPTOOL_DOCKER_IMAGE_NAME:-evmapp-bootstraptool}"
docker_hub_org='zencash'
pom_version="${ROOT_POM_VERSION:-}"

DOCKER_USERNAME="${DOCKER_USERNAME:-}"
DOCKER_PASSWORD="${DOCKER_PASSWORD:-}"
IS_A_RELEASE="${IS_A_RELEASE:-false}"
PROD_RELEASE="${PROD_RELEASE:-false}"
TRAVIS_TAG="${TRAVIS_TAG:-}"


# Functions
function fn_die() {
  echo -e "$1" >&2
  exit "${2:-1}"
}

# Building only dev or prod releases
docker_tag=""
if [ "${IS_A_RELEASE}" = "true" ]; then
  docker_tag="${TRAVIS_TAG}"

  arg_sc_committish="${ARG_SC_COMMITTISH:-${TRAVIS_TAG}}"
  arg_sc_version="${ARG_SC_VERSION:-${pom_version}}"

  if [ -z "${arg_sc_committish}" ] || [ -z "${arg_sc_version}" ]; then
    fn_die "Error: ARG_SC_VERSION and/or ARG_SC_COMMITTISH variables are empty for release build. Docker image will not be built.  Exiting ..."
  fi
fi

# Building docker image
if [ -n "${docker_tag}" ]; then
  echo "" && echo "=== Building Docker Image: ${evmapp_docker_image_name}:${docker_tag} ===" && echo ""

  docker build -f "${workdir}"/dockerfiles/evmapp/Dockerfile -t "${evmapp_docker_image_name}:${docker_tag}" \
    --build-arg ARG_SC_COMMITTISH="${arg_sc_committish}" \
    --build-arg ARG_SC_VERSION="${arg_sc_version}" \
    .

  docker build -f "${workdir}"/dockerfiles/bootstraptool/Dockerfile -t "${bootstraptool_docker_image_name}:${docker_tag}" \
    --build-arg ARG_SC_COMMITTISH="${arg_sc_committish}" \
    --build-arg ARG_SC_VERSION="${arg_sc_version}" \
    .

  # Publishing to DockerHub
  echo "" && echo "=== Publishing Docker image(s) on Docker Hub ===" && echo ""
  if [ -z "${DOCKER_USERNAME}" ] || [ -z "${DOCKER_PASSWORD}" ]; then
    echo "Warning: DOCKER_USERNAME and/or DOCKER_PASSWORD variable(s) is(are) empty. Docker image(s) is(are) NOT going to be published on DockerHub !!!"
  else
    echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
    docker_images=("${evmapp_docker_image_name}" "${bootstraptool_docker_image_name}")

    # Docker image(s) tags for PROD vs DEV release
    if [ "${PROD_RELEASE}" = "true" ]; then
      tags=("${docker_tag}" "latest")
    else
      tags=("${docker_tag}" "dev")
    fi

    for docker_image in "${docker_images[@]}"; do
      for tag in "${tags[@]}"; do
        echo "" && echo "Publishing docker image: ${docker_image}:${tag}"
        docker tag "${docker_image}:${docker_tag}" "index.docker.io/${docker_hub_org}/${docker_image}:${tag}"
        docker push "index.docker.io/${docker_hub_org}/${docker_image}:${tag}"
      done
    done
  fi
else
  echo "" && echo "=== The build did NOT satisfy RELEASE build requirements. Docker image(s) was(were) NOT created/published ===" && echo ""
fi


######
# The END
######
echo "" && echo "=== Done ===" && echo ""

exit 0
