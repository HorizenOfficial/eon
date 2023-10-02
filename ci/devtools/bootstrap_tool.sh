#!/bin/bash

set -eEuo pipefail

docker_org="${DOCKER_ORG:-zencash}"
docker_image="${DOCKER_IMAGE:-evmapp-bootstraptool}"
docker_tag="${DOCKER_TAG:-latest}"

if [ "$#" -eq 0 ] || { [ "${1}" != "forger" ] && [ "${1}" != "signer" ]; } || { [ "$#" -ge 2 ] && ! [[ "${2}" =~ ^[0-9]+$ ]]; }; then
  echo
  cat << EOF
Usage:
        From command line: ./bootstrap_tool.sh <command> <arg>
Supported commands:
        forger
        signer
Supported args:
        seed_size: Optional. Numeric. Default value 64.
Examples:
        ./bootstrap_tool.sh forger 128
        ./bootstrap_tool.sh signer
        export DOCKER_TAG=0.1.0 && ./bootstrap_tool.sh signer (default tag used is 'latest' but it can be selected via env variable)
Outputs:
        forger:
                {
                  "seed": "string",
                  "generatekey": {
                    "secret": "string",
                    "publicKey": "string"
                  },
                  "generateVrfKey": {
                    "vrfSecret": "string",
                    "vrfPublicKey": "string"
                  },
                  "generateAccountKey": {
                    "accountSecret": "string",
                    "accountProposition": "string"
                  }
                }
        signer:
                {
                  "master": {
                    "seed": "string",
                    "generateCertificateSignerKey": {
                      "signerSecret": "string",
                      "signerPublicKey": "string"
                    }
                  },
                  "signer": {
                    "seed": "string",
                    "generateCertificateSignerKey": {
                      "signerSecret": "string",
                      "signerPublicKey": "string"
                    }
                  }
                }
EOF
  echo
  exit 1
fi

seed_size=64
if [ "$#" -eq 2 ]; then
  seed_size="${2}"
fi

# Always pull latest image
docker pull "${docker_org}/${docker_image}:${docker_tag}" > /dev/null

if [ "${1}" = "forger" ]; then
  seed_raw=$(docker run --rm "${docker_org}/${docker_image}:${docker_tag}" pwgen -1s "${seed_size}" 1)
  seed="${seed_raw:0:${seed_size}}"
  response="\"seed\":\"${seed}\""
  outputs=("${response}")
  commands=("generatekey" "generateVrfKey" "generateAccountKey")
  for command in "${commands[@]}"; do
    output=$(docker run --rm "${docker_org}/${docker_image}:${docker_tag}" "$command" "{\"seed\":\"${seed}\"}" | grep -v "Starting EON bootstrapping tool")
    response_output="\"${command}\": $output"
    outputs+=("${response_output}")
  done
  json=$(printf "%s,\n" "${outputs[@]}" | sed '$ s/,$//')
  echo "{$json}"
elif [ "${1}" = "signer" ]; then
  outputs=()
  seeds=("master" "signer")
  for seed_var in "${seeds[@]}"; do
    seed_raw=$(docker run --rm "${docker_org}/${docker_image}:${docker_tag}" pwgen -1s "${seed_size}" 1)
    seed="${seed_raw:0:${seed_size}}"
    output=$(docker run --rm "${docker_org}/${docker_image}:${docker_tag}" generateCertificateSignerKey "{\"seed\":\"${seed}\"}" | grep -v "Starting EON bootstrapping tool")
    response_output="\"${seed_var}\": { \"seed\": \"${seed}\", \"generateCertificateSignerKey\": $output }"
    outputs+=("${response_output}")
  done
  json=$(printf "%s,\n" "${outputs[@]}" | sed '$ s/,$//')
  echo "{$json}"
fi

