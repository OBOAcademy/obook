# Overview

## Lessons

### [Using Ontologies and Ontology Terms](lesson/ontology_term_use.md)

- Target [roles](getting_started.md#oboroles): Database Curators 
- skills
    - know what ontologies are good for
    - find good ontologies: ontology repositories, OBO
    - find good terms: ontology browsers
    - assess for use: license, quality
    - map local terms to ontology terms
    - identify missing terms
    - use IRIs, prefixes, CURIEs, labels
    - use Protege?

### [Contributing to OBO ontologies 1: Protege and Github](lesson/contributing_to_obo_ontologies.md)

- Target [roles](getting_started.md#oboroles): Database Curators, Ontology Curator, Ontology Engineer/Developer
- Builds on:
    - [Ontology Term Use](lesson/ontology_term_use.md)
- Skills:
    - use GitHub: issues, Pull Requests
    - understand basic Open Source etiquette
      - reading READMEs
    - understand basics of ontology development workflows
    - understand ontology design patterns
    - use templates: ROBOT, DOS-DP
    - basics of OWL

### [Ontology Fundamentals](lesson/ontology_fundamentals.md)

- Target [roles](getting_started.md#oboroles): Ontology Curators, Ontology Engineer/Developer
- Builds on:
    - [Ontology Term Use](lesson/ontology_term_use.md)
- Skills:
    - RDF
    - RDFS
    - OWL
    - Reasoners
    - basic SPARQL
    - Turtle, JSON-LD

### Linked Data Analysis

- Target [roles](getting_started.md#oboroles): Ontology Curators, (Semantic) Software Engineer
- Builds on:
    - [Ontology Fundamentals](lesson/ontology_fundamentals.md)
- Skills:
    - Advanced SPARQL
    - Term enrichment
    - Semantic similarity
    - Named Entity Recognition
    - more...

### Ontology Development

- Builds on:
    - [Ontology Fundamentals](lesson/ontology_fundamentals.md)
    - [Contributing to OBO ontologies](lesson/contributing_to_obo_ontologies.md)
- Skills:
    - Manage GitHub
    - Manage ontology imports
    - Use ROBOT extract: MIREOT, SLME
    - Use ROBOT report
    - Pruning trees

### Semantic Databases

- Builds on: 
    - Ontology Development
- skills
    - advanced term mapping
    - ontology terms in SQL
    - terminology table JOINs, constraints
    - convert tables to triples
    - triplestores
    - knowledge graphs

### [Automating Ontology Development Workflows](lesson/automating_ontology_workflows.md)

- Builds on: 
    - Ontology Development
    - Ontology Pipelines
- Skills:
    - Unix shell
    - `make`
    - Advanced git, GitHub
    - ROBOT
    - ODK

### [Developing an OBO Reference Ontology](lesson/developing_an_obo_ontology.md)

- Builds on:
    - Ontology Development Automation
- Skills:
    - Detailed knowledge of OBO principles and best practises
    - Use OBO Dashboard
    - Use OBO Registry
    - Use PURL system

## Tutorials

- [ROBOT Tutorial 1: Convert, Extract and Template](tutorial/robot_tutorial_1.md)
- [ROBOT Tutorial 2: Annotate, Merge, Reason and Diff](tutorial/robot_tutorial_2.md)
- [Introduction to GitHub](tutorial/github_fundamentals.md)
- [Intro to managing and tracking issues in GitHub](tutorial/github_issues.md)

## How-to guides

- [Install Elk 0.5 in Protege](howto/installing_elk_in_protege.md)
- [Getting set up with Docker and the Ontology Development Kit](howto/odk_setup.md)
