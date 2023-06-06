#!/bin/bash

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../..";
pom_xml_locations=("${base_dir}" "${base_dir}/bootstraptool" "${base_dir}/node")

for location in "${pom_xml_locations[@]}"; do
  CONTENT="$(xmllint --format --encode UTF-8 "${location}"/pom.xml)"
  echo "${CONTENT}" > "${location}/pom.xml"
done