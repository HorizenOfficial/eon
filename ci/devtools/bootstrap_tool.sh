#!/bin/bash

set -eEuo pipefail

if [ "$#" -eq 0 ] || { [ "${1}" != "forger" ] && [ "${1}" != "signer" ]; } || { [ "$#" -ge 2 ] && ! [[ "${2}" =~ ^[0-9]+$ ]]; }; then
  echo
  printf "Usage:\n\tFrom command line: ./bootstrap_tool.sh <command> <arg>\nSupported commands:\n\tforger\n\tsigner\nSupported args:\n\tseed_size: Optional arg. Numeric, default value 64\n\tdocker_tag: Optional. Version of bootstrap docker image. Default value latest\nExamples:\n\t./bootstrap_tool.sh forger 128\n\t./bootstrap_tool.sh signer\nOutputs:\n\tforger:\n\t\t* seed\n\t\t* generatekey\n\t\t* generateVrfKey\n\t\t* generateAccountKey\n\tsigner:\n\t\t* seed_master\n\t\t* generateCertificateSignerKey master\n\t\t* seed_signer\n\t\t* generateCertificateSignerKey signer\n"
  echo
  exit 1
fi

seed_size=64
if [ "$#" -eq 2 ]; then
  seed_size="${2}"
fi

docker_tag=latest
if [ "$#" -eq 3 ]; then
  docker_tag="${3}"
fi

if [ "${1}" = "forger" ]; then
  echo
  echo "Creating forger seed and keys..."
  seed_raw=$(docker run --rm horizenlabs/sctool:"${docker_tag}" pwgen -1s "${seed_size}" 1)
  seed="${seed_raw:0:${seed_size}}"
  echo "{\"seed\":\"${seed}\"}"
  commands=("generatekey" "generateVrfKey" "generateAccountKey")
  for command in "${commands[@]}"; do
    echo
    echo "$command"
    docker run --rm -it horizenlabs/sctool:"${docker_tag}" "$command" "{\"seed\":\"${seed}\"}"
  done
  echo
elif [ "${1}" = "signer" ]; then
  echo
  echo "Creating signer seeds and keys..."
  seeds=("master" "signer")
  for seed_var in "${seeds[@]}"; do
    echo
    echo "Creating ${seed_var} seed and key..."
    seed_raw=$(docker run --rm horizenlabs/sctool:"${docker_tag}" pwgen -1s "${seed_size}" 1)
    seed="${seed_raw:0:${seed_size}}"
    echo "{\"seed_${seed_var}\": \"${seed}\"}"
    docker run --rm -it horizenlabs/sctool:"${docker_tag}" generateCertificateSignerKey "{\"seed\":\"${seed}\"}"
  done
  echo
fi

