# Manifest Cyber Orb

<!---
[![CircleCI Build Status](https://circleci.com/gh/<organization>/<project-name>.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/<organization>/<project-name>) [![CircleCI Orb Version](https://badges.circleci.com/orbs/<namespace>/<orb-name>.svg)](https://circleci.com/orbs/registry/orb/<namespace>/<orb-name>) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/<organization>/<project-name>/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

--->

This orb is used to generate an SBOM and publish to your Manifest account. Multiple SBOM generators and formats are supported. This Orb uses the Manifest CLI, which wraps various SBOM generators, supports multiple formats, and provides a common interface for generating SBOMs. The Manifest CLI performs further cleanup on generated SBOMs (such as healing relationships & componentIds, asset names & versions, etc), and can also optionally publish your SBOM directly into your Manifest tenant.

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

### Generate & Transmit with [CycloneDX/cdxgen](https://github.com/CycloneDX/cdxgen)
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
        # Example: Run your normal CI and build steps here
        # Note: A more complete `build` generally results in a better SBOM
        - checkout
        - run: npm ci # This is here as an example
        - run: npm run build # This is here as an example
        # Once your build is complete, install Manifest & dependencies:
        - sbom/install:
            version: v0.10.0 # Version of Manifest CLI to install
            generator: cdxgen  # syft, cdxgen, etc.
            # generator_version: v1.2.3 # Install a specific version of the generator (default: latest)
        - sbom/generate:
            generator: cdxgen # Should match the installed generator
            source: .
            output: bom.json # Output filename
            format: cyclonedx-json # Desired output format. Must be supported by selected generator
            source_name: your_app_name
            source_version: 1.2.3
```

### Generate & Transmit with [Anchore/Syft](https://github.com/anchore/syft)
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
        # Example: Run your normal CI and build steps here
        # Note: A more complete `build` generally results in a better SBOM
        - checkout
        - run: npm ci # This is here as an example
        - run: npm run build # This is here as an example
        # Once your build is complete, install Manifest & dependencies:
        - sbom/install:
            version: v0.10.0 # Version of Manifest CLI to install
            generator: syft  # syft, cdxgen, etc.
            generator_version: v0.9.2 # Syft requires an explicit version be set.
        - sbom/generate:
            generator: syft # Should match the installed generator
            source: .
            output: bom.json # Output filename
            format: spdx-json # Output format. Supported formats: https://github.com/anchore/syft#output-formats
            source_name: your_app_name
            source_version: 1.2.3
```
