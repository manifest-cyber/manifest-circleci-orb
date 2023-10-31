# Manifest Cyber Orb

<!---
[![CircleCI Build Status](https://circleci.com/gh/<organization>/<project-name>.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/<organization>/<project-name>) [![CircleCI Orb Version](https://badges.circleci.com/orbs/<namespace>/<orb-name>.svg)](https://circleci.com/orbs/registry/orb/<namespace>/<orb-name>) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/<organization>/<project-name>/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

--->

This orb is used to send an SBOM to your Manifest Cyber account.

---

## How to use this orb

1. Add the orb to your project.
2. Generate an API Key in your Manifest Cyber account. This is done from the "Organizations" page, which you can reach by clicking on your account.
3. Save that API key in CircleCI as an environment variable. The name of the environment variable is `MANIFEST_API_KEY`.

4. (optional) Call `sbom/install` to install an SBOM generator into your CI.
5. Call `sbom/generate` to generate SBOMs.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/manifest/sbom) - The official registry page of this orb for all versions, executors, commands, and jobs described.

[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.

## Usage Example

```yaml
usage:
  version: 2.1
  orbs:
    sbom: manifest/sbom@0.1.0

  jobs:
    build:
      docker:
        - image: cimg/node:lts
      steps:
        - checkout
        - run: npm ci
        - run: npm run build:bom
        - sbom/install:
            version: v0.10.0
            generator: cdxgen
            generator_version: v0.92.0
        - sbom/generate:
            generator: cdxgen
            source: .
            output: bom.json
            format: cyclonedx-json
            source_name: node
            source_version: 14.17.0
            args: --spec-version 1.4
```
