# Manifest Cyber Orb

<!---
[![CircleCI Build Status](https://circleci.com/gh/<organization>/<project-name>.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/<organization>/<project-name>) [![CircleCI Orb Version](https://badges.circleci.com/orbs/<namespace>/<orb-name>.svg)](https://circleci.com/orbs/registry/orb/<namespace>/<orb-name>) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/<organization>/<project-name>/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

--->

This Orb is used to generate an SBOM and optionally publish to your Manifest account. This Orb uses the Manifest CLI, which wraps various SBOM generators, supports multiple formats, and provides a common interface for generating SBOMs. The Manifest CLI performs further cleanup on generated SBOMs (such as healing relationships & componentIds, asset names & versions, etc), and can also optionally publish your SBOM directly into your Manifest tenant.

You do not need to be a Manifest customer to use our Orb for generating SBOMs, but publishing to Manifest requires an active account. Learn more about Manifest at [manifestcyber.com](https://manifestcyber.com).

> Note: There is an older Manifest Orb, `sbom-transmitter`, which is considered deprecated. It is still available for use (for now), but we recommend using this Orb instead.

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
```
