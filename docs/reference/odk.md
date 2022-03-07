# Ontology Development Kit (ODK) Reference

The ODK is essentially two things:

1. A toolbox. All frequently used tools for managing the ontology life cycle are bundled together into a Docker image: ROBOT, owltools, fastobo-validator, dosdp-tools, riot and many, many more.
2. A system, you could have say "methodology" for managing the ontology life cycle from continious integration and quality control to imports and release management.

## The Toolbox

The ODK bundles a lot of tools together, such as ROBOT, owltools, fastobo-validator and dosdp-tools. To get a better idea, its best to simply read the Dockerfile specifications of the ODK image:

- [ODK Lite Image](https://github.com/INCATools/ontology-development-kit/blob/master/docker/odklite/Dockerfile). This contains the most essentials tools related to ODK development. Most of the day to day activities of ontology developers with ROBOT are well covered by [odklite](https://hub.docker.com/r/obolibrary/odklite).
- [ODK Full Image](https://github.com/INCATools/ontology-development-kit/blob/master/Dockerfile). Extends the ODK Lite image with a further round of powerful tools. It contains for example Apache Jena, the OBO Dashboard, the Konclude reasoner and a large array of command line tools.


## The system for ontology life cycle management


One of the tools in the toolbox, the "seed my repo" function, allows us to generate a complete GitHub repository with everything needed to manage an OBO ontology according to OBO best practices. The two central components are

1. A Makefile that encodes the rules by which ontology release files should be derived from the source of truth (the edit file).
2. A support for CI such as GitHub actions or Travis for running continuous integration checks.