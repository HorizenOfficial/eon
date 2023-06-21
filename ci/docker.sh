#!/bin/bash
set -eEuo pipefail

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
docker_image_name="${DOCKER_IMAGE_NAME:-evmapp}"
docker_hub_org='horizenlabs'
pom_version="${ROOT_POM_VERSION:-}"

DOCKER_USERNAME="${DOCKER_USERNAME:-}"
DOCKER_PASSWORD="${DOCKER_PASSWORD:-}"


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
  echo "" && echo "=== Building Docker Image: ${docker_image_name}:${docker_tag} ===" && echo ""

  docker build -f "${workdir}"/dockerfiles/evmapp/Dockerfile -t "${docker_image_name}:${docker_tag}" \
    --build-arg ARG_SC_COMMITTISH="${arg_sc_committish}" \
    --build-arg ARG_SC_VERSION="${arg_sc_version}" \
    .

  # Publishing to DockerHub
  echo "" && echo "=== Publishing Docker image(s) on Docker Hub===" && echo ""
  if [ -z "${DOCKER_USERNAME}" ] || [ -z "${DOCKER_PASSWORD}" ]; then
    echo "Warning: DOCKER_USERNAME and/or DOCKER_USERNAME is(are) empty. Docker image is NOT going to be published on DockerHub !!!"
  else
    echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
    docker tag "${docker_image_name}:${docker_tag}" "index.docker.io/${docker_hub_org}/${docker_image_name}:${docker_tag}"
    docker push "index.docker.io/${docker_hub_org}/${docker_image_name}:${docker_tag}"
  fi
else
  echo "" && echo "=== The build did NOT satisfy RELEASE build requirements. Docker image is not being created ===" && echo ""
fi


######
# The END
######
echo "" && echo "=== Done ===" && echo ""

exit 0