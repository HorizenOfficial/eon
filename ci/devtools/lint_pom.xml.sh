#!/bin/bash

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../..";
mapfile -t pom_xml_files < <(find "${base_dir}" -name 'pom.xml')

for location in "${pom_xml_files[@]}"; do
  CONTENT="$(xmllint --format --encode UTF-8 "${location}")"
  echo "${CONTENT}" > "${location}"
done

if [ -f ci/mvn_settings.xml ]; then
  SETTINGS_CONTENT="$(xmllint --format --encode UTF-8 ci/mvn_settings.xml)"
  echo "${SETTINGS_CONTENT}" > ci/mvn_settings.xml
fi