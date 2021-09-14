# How to start with the lessons

Before you start with the lessons of this course, keep the following in mind:

1. The materials in this course are all intended to be used for self-study. We sometimes offer [flipped-classroom](https://en.wikipedia.org/wiki/Flipped_classroom) sessions for new members on our teams - this means that we expect them to work through the entire course themselves and then come to use with questions and requests for clarifications.
2. There is no need to reinvent the wheel: there are a lot of great materials out there already. Providing references to these these external resources is an essential part of the course - some lessons primarily comprise external tutorials, blog articles and more - please make sure you take advantage of them.
3. Some of the materials developed by us are a bit rough around the edges, and we need your help to fix and improve them. To that end, we appreciate anything from [suggestions for improvement](#issues) to [pull requests](#pulls).
4. Depending on your specific role and interest, you can choose which lessons are relevant to you. There is no specific order, but if you want to start somewhere, we recommend [Contributing to OBO ontologies: Protege and Github](lesson/contributing_to_obo_ontologies.md) and/or [Using Ontologies and Ontology Terms](lesson/ontology_term_use.md)

<a name="oboroles"></a> 
## The different roles of OBO Semantic Engineering

There are a wide variety of entry points into the OBO world, for example:

### *Database Curator*: You are

- using ontologies for annotating datasets, experiments and publications
- requesting new terms from ontologies
- Suggest corrections to existing ontologies, such as wrong or missing synonyms, typos and definitions

### *Ontology Curator*: You are 
- developing and maintaining ontologies
- adding terms to ontologies
- performing changes to ontologies, like adding or correcting synonyms
- responsible for ontology releases

### *Ontology Engineer/Developer*: You are
- developing design patterns for ontologies, specifying the logical structure of terms
- responsible for ensuring the specification and consistent application of metadata in your ontologies (which annotation properties to use, minimal metadata standards)
- defining quality control checks

### *Ontology Pipeline Specialist*: You are
- developing ontology pipelines with `make` and `ROBOT`
- building the release and quality control architecture that *Engineers* and *Curators* need to do their work.
- building infrastructure for application ontologies, implementing dynamic imports modules, transformations of and mappings to other ontologies.

### *Semantic ETL Engineer*: You are

- Building ingests from public life science resources such as Bgee, Panther, UniProt and many more
- You use ontologies to glue together data from different sources
- You use ontologies to augment your the information in your data sources through inference

### *(Semantic) Software Engineer*: You are

- using ontologies to generate value to end-user applications (user interfaces, semantic facetted search)
- building widgets that exploit the logical and graph structure of ontologies, for example phenotypic profile matching
- building ontology term browsers such as [OLS](https://www.ebi.ac.uk/ols/index).

Of course, many of you will occupy more than one of the above "hats" or roles. While they all require specialised training, many shared skill requirements exist. This course is being developed to:

- Provide basic training for OBO Semantic Engineers of any of the above flavours
- Provide an entry point for people new to the field, for example as part of onboarding activities for projects working with ontologies
- Capture some of the typical pitfalls and how-to's guides to address common problems across the OBO-sphere
