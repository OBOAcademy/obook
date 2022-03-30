# Getting started with the training

Here are some points to keep in mind whilst working through the lessons and other semantic engineering training materials.

1. The course materials are designed for self-study. [Flipped-classroom](https://en.wikipedia.org/wiki/Flipped_classroom) sessions are offered on occassion and are generally intended to onboard new contributors. The expectation is that new recruits will work through the course themselves and come to  sessions with questions and requests for clarifications.
2. There are a lot of great materials out there already. Some lessons primarily comprise external tutorials, blog articles and more. Reviewing these external resources is an essential part of the course.
3. These training materials are constantly evolving and your help with improving them would be greatly appreciated. Please feel free to submit [suggestions for improvement](#issues) and/or [pull requests](#pulls).
4. Depending on your specific role and interest, some lessons may be more or less relevant for your use case. There is no specific order, but if you are new to OBO ontologies, here are some recommended starting points:
- [Contributing to OBO ontologies: Protégé and Github](lesson/contributing-to-obo-ontologies.md)
- [Using Ontologies and Ontology Terms](lesson/ontology-term-use.md)

<a name="oboroles"></a> 
## The different roles of OBO Semantic Engineering

Some learning pathways are geared towards specific roles within the OBO Semantic Engineering space. Below are some of the typical roles and their typical tasks.

### *Database Curator*:
- uses ontologies for annotating datasets, experiments and publications
- requests new terms to be added to ontologies
- suggests corrections to existing ontologies, e.g., incorrect synonyms, missing definitions, typos, modelling inconsistencies

### *Ontology Curator*:
- develops and maintains ontologies
- adds terms to ontologies
- edits ontologies, such as adding synonyms and correcting typos
- publishes ontology releases

### *Ontology Engineer/Developer*:
- develops design patterns for ontologies, specifies the logical structure of terms
- ensures the specification and consistent application of metadata in ontologies, e.g., defining minimal metadata standards and which annotation properties to use
- defining quality control checks

### *Ontology Pipeline Specialist*:
- develops ontology pipelines with `make` and `ROBOT` commands
- builds the release and quality control architecture that *Engineers* and *Curators* need to do their work
- builds infrastructure for application ontologies, implements dynamic imports modules, facilitates transformations of and mappings to other ontologies

### *Semantic ETL Engineer*:
- builds incoming pipelines from public life science resources such as Bgee, Panther, UniProt and many others
- leverages ontologies to glue together data from different sources
- leverages inferences derived from ontologies to augment information in proprietary data sources

### *(Semantic) Software Engineer*:
- uses ontologies to generate value to end-user applications, e.g., user interfaces, semantic facetted search
- builds widgets that exploit the logical and graph structure of ontologies, e.g., phenotypic profile matching
- builds ontology term browsers such as [OLS](https://www.ebi.ac.uk/ols/index)

Of course, many of you will not be confined to only one of the above roles. While they all require specialised training, many shared skill requirements exist. The OBO Semantic Engineering course is intended to:

- Provide basic training for OBO Semantic Engineers performing any of the tasks mentioned above
- Provide an entry point for users new to the field, e.g., as part of onboarding activities for projects working with ontologies
- Capture some of the typical pitfalls and provide guides to address common problems across the OBO-sphere
