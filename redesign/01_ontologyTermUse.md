# Ontology Term Use

## Prerequisites
- None

## Preparation
- None

## What is delivered as part of the course

**Description:** Using ontology terms for annotations and structuring data.

### Learning objectives
1. [Explain why ontologies are useful](#explain)
2. [Find good ontologies: ontology repositories, OBO](#find)
3. [Find terms using ontology browsers](#repo)
4. [Assess ontologies for use: license, quality](#assess)
5. [Map local terminology to ontology terms](#map)
6. [Identify missing terms](#missing)
7. [Make term requests to existing ontologies](#request)
8. [Understand the differences between IRIs, CURIEs, and labels](#iri)

## Tutorials
- None

## Additional materials and resources
- [How select and request terms from ontologies](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) - Blog post by Chris Mungall
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)

<a name="explain"></a> 
## 1. Explain why ontologies are useful

Ontologies provide a logical classification of information in a particular domain or subject area. Ontologies can be used for data annotations, for structuring disparate data types, classifying information, for inferencing and reasoning across data and computational analyses.

<a name="find"></a> 
## 2. Find good ontologies

<a name="repo"></a> 
## 3. Ontology repositories

### OBO Foundry

The [OBO Foundry](http://obofoundry.org/) is a community of ontology developers that are committed to developing a library of ontologies that are open, interoperable ontologies, logically well-formed and scientifically accurate. OBO Foundry participants follow and contribute to the development of an evolving set of [principles](http://obofoundry.org/principles/fp-000-summary.html) including open use, collaborative development, non-overlapping and strictly-scoped content, and common syntax and relations, based on ontology models that work well, such as the [Gene Ontology (GO)](http://geneontology.org/).

The OBO Foundry is overseen by an [Operations Committee](http://obofoundry.org/docs/OperationsCommittee.html) with Editorial, Technical and Outreach working groups.

### Find terms using ontology browsers
Various ontology browsers are available, we recommend using one of the ontology browsers listed below.

- Find terms:
  - [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index)
  - [BioPortal](https://bioportal.bioontology.org/)
  - [Ontobee](http://www.ontobee.org/)

<a name="assess"></a> 
## 4. Assess ontologies for use: license, quality

Some considerations for determining which ontologies to use include the license and quality of the ontology.

### License

Licenses define how an ontology can legally be used or reused. One requirement for OBO Foundry Ontologies is that they are open, meaning that the ontologies are openly and freely available for use with acknowledgement and without alteration. OBO ontologies are required to be released under a Creative Commons [CC-BY license version 3.0 or later](https://creativecommons.org/licenses/by/3.0/), OR released into the public domain under [CC0](https://creativecommons.org/publicdomain/zero/1.0/). The licsense should be clearly stated in the ontology file.

### Quality

Some criteria that can be applied to determine the quality of an ontology include:

- **Is there an ontology tracker to report issues?** All open ontologies should have some form of an issue tracker to report bugs, make new term requests or request other changes to the ontology. Many ontologies use GitHub to track their issues. 
- **Is it currently active?** Are there a large number of open tickets on the ontology tracker that have not been commented on or otherwise addressed? Are the tickets very old, have been sitting for years?
- **Commmunity involvement** On the issue tracker, is there evidence of community involvement, such as issues and comments from outside community members?
- **Scientifically sound** Does the ontology accurately represent the domain in a scientifically sound way?


<a name="map"></a> 
## 5. Map local terminology to ontology terms

<a name="missing"></a> 
## 6. Identify missing terms

<a name="request"></a> 
## 7. Make term requests to existing ontologies

### Making a new term request to Mondo

1. Go to Mondo [GitHub tracker](https://github.com/monarch-initiative/mondo/issues): Select New issue
1. Pick appropriate template
1. Fill in the information that is requested on the template below each header
1. Please include:
	1. A definition in the proper format
	1. Sources/cross references for synonyms
	1. Your ORCID or the URL for your ClinGen working group
	1. Add any additional comments at the end
1. Nicole will automatically be tagged
1. Please email Nicole or comment on the ticket (Nicole will be emailed) if you have any additional questions or need the ticket is high priority

See [video](https://drive.google.com/file/d/14g9y1nmCmRTkPB1fa6y_jIW3lHyFV4-g/view?resourcekey)

### Best practices guidelines

**Note**: We appreciate your contributions to extending and improving Mondo. Following best guidelines is appreciated by the curators and developers, and assists them in addressing your issue more quickly. However, we understand if you are not always able to follow these best practices.

### General Recommendations:
1. New term requests should not match existing terms or synonyms
1. Write a concise definition in the definition field. More info about writing definitions is [here](https://douroucouli.wordpress.com/2019/07/08/ontotip-write-simple-concise-clear-operational-textual-definitions/)
1. Synonyms - please provide a synonym scope and source/cross-reference
1. Check OMIM for children classes (specific to new gene-related terms)

#### Synonym scopes:
- Exact - an exact match
- Narrow - more specific term
- Broad - more general term
- Related - a word of phrase has been used synonymously with the primary term name in the literature, but the usage is not strictly correct 

### Formatting:
1. Preferred term labels should be lowercase (unless it is a proper name or abbreviation)
1. Write the request below the prompts on the template so the Markdown formatting displays properly
1. Synonyms should be lowercase (with exceptions above)
1. Definition source - if from PubMed, please use the format PMID:XXXXXX (no space)
1. Include the Mondo ID and label for the parent term
1. List the children terms with Mondo ID and label in a bulleted list

### Examples

### Tickets that followed best practices:
- https://github.com/monarch-initiative/mondo/issues/2541
- https://github.com/monarch-initiative/mondo/issues/1719
Note: while this ticket generally follows best practices, one thing that can be improved is defining the synonym scope. Generally, when the synonym scope is not explicity mentioned, it is assumed it is an _exact synonym_.
- https://github.com/monarch-initiative/mondo/issues/1188
- https://github.com/monarch-initiative/mondo/issues/2945

#### Tickets that did not follow best practices:
- https://github.com/monarch-initiative/mondo/issues/1837
- https://github.com/monarch-initiative/mondo/issues/276

### Submitting other issues to Mondo

- Users may want to request other types of changes to Mondo (or any other ontology) beyond just adding a new term.
- The Mondo curation team created many [issue templates](https://github.com/monarch-initiative/mondo/issues/new/choose) for users, for specific types of requests.
- If none of the issue templates fit your issue, you can scroll to the bottom and click [Open a blank issue](https://github.com/monarch-initiative/mondo/issues/new)

<a name="iri"></a> 
## 8. Understand the differences between IRIs, CURIEs, and labels