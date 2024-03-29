#!/bin/bash
# shellcheck disable=SC2046
set -euo pipefail

command -v docker &> /dev/null && have_docker="true" || have_docker="false"
# absolute path to project from relative location of this script
workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
# defaults if not provided via env
TESTS_DOCKER_ORG="${TESTS_DOCKER_ORG:-zencash}"
TESTS_IMAGE_NAME="${TESTS_IMAGE_NAME:-sc-ci-base}"
TESTS_IMAGE_TAG="${TESTS_IMAGE_TAG:-focal_jdk-11_latest}"
IS_A_RELEASE="${IS_A_RELEASE:-false}"
image="${TESTS_DOCKER_ORG}/${TESTS_IMAGE_NAME}:${TESTS_IMAGE_TAG}"


# Run tests
if [ -n "${TESTS:-}" ]; then
  if [ "$have_docker" = "true" ]; then
    if [ -n "${DOCKER_USERNAME:-}" ] && [ -n "${DOCKER_PASSWORD:-}" ]; then
      echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    fi
    docker run --rm -t -v "$workdir":/build -w /build \
      --entrypoint /build/ci/docker/entrypoint.sh \
      -v "${HOME}"/key.asc:/key.asc \
      -e IS_A_RELEASE \
      -e TESTS \
      -e LOCAL_USER_ID="$(id -u)" \
      -e LOCAL_GRP_ID="$(id -g)"\
      "${image}" ci/run_tests.sh
  else
    cd "${workdir:-.}" && ci/run_tests.sh
  fi
fi

# Building docker image if tests are successful
if [ "${IS_A_RELEASE}" = "true" ]; then
  ci/docker.sh
fi