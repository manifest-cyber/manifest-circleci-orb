#!/bin/bash

labels=$(circleci env subst "${MANIFEST_LABELS}")
generator=$(circleci env subst "${MANIFEST_GENERATOR}")
name=$(circleci env subst "${MANIFEST_SOURCE_NAME}")
version=$(circleci env subst "${MANIFEST_SOURCE_VERSION}")
format=$(circleci env subst "${MANIFEST_FORMAT}")
sources=$(circleci env subst "${MANIFEST_SOURCE}")
publish=$(circleci env subst "${MANIFEST_PUBLISH}")
attest=$(circleci env subst "${MANIFEST_ATTEST}")
attest_key=$(circleci env subst "${MANIFEST_ATTEST_PRIVATE_KEY}")
hierarchical=$(circleci env subst "${MANIFEST_HIERARCHICAL_MERGE}")

# since we pass "flags", we need to handle this differently
ptargs="${MANIFEST_ARGS}"

sources=${sources//,/}

# This is required for publishing
MANFEST_API_KEY=${MANFEST_API_KEY:$(circleci env subst "${MANIFEST_PUBLISH_API_KEY}")}

if [[ -z "${ptargs}" ]]; then
    manifest sbom --source="CircleCI" --attest="${attest}" --key="${attest_key}" --hierarchical="${hierarchical}" --label="${labels}" --generator="${generator}" --name="${name}" --version="${version}" --output "${format}" --publish="${publish}" "${sources}"
else
    manifest sbom --source="CircleCI" --attest="${attest}" --key="${attest_key}" --hierarchical="${hierarchical}" --label="${labels}" --generator="${generator}" --name="${name}" --version="${version}" --output "${format}" --publish="${publish}" "${sources}" -- "${ptargs}"
fi
