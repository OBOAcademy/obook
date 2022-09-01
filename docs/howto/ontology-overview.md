# How to prepare OBO Academy ontology overview 

## Overview
This 'how to' guide provides a template for an Ontology Overview for your ontology. Please create a markdown file using this template and share it in your ontology repository, either as part of your ReadMe file or as a separate document in your documentation. The Ontology Overview should include the following three sections:
1. Scope
2. Curation and governance workflows
3. How the ontology is used in practice

### Scope
- Describe the domain and scope of ontology. 
    - For example, the Mondo ontology covers concepts in the area of diseases across species and integrates disease terminologies from several underlying sources.
- Include a figure of upper level terms (critical: give a list of all the high level terms that the ontology covers (1-2 levels). Eg Mondo: disease or disorder, disease susceptibility, disease characteristic). 

<img width="212" alt="image" src="https://user-images.githubusercontent.com/6722114/187983205-758a5453-98ba-42cc-8fce-f7f81b37e8f5.png">

- Include a figure with exemplary term (using OBO graph)  

### Curation and governance workflows
Emphasize the ontology level curation, ie how to add terms
Goverance: How do people request terms
Contribute terms directly (ie ROBOT templates, etc)
How do we add terms
ROBOT
DOSDP
Manual additions via Protege
No need for details about QC, ODK unless it is related to curation (ie pipeline that automatically generates mappings, include that)


### How the ontology used in practice
include 1-3 actual use cases. Want concrete examples
eg this group uses the ontology to annotate this data for this purpose
Eg this group uses the ontology to compute phenotypic similarity for prediction of related diseases
Eg clingen is mapping their data to Mondo in order to populate a search index to allow for searching of variants implicated in rare diseases
Use the ontology for NER as a dictionary as a synonym source	
