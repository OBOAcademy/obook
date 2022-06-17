# Make term requests to existing ontologies

## Prerequisites
- Sign up for a free [GitHub](https://github.com/join) account

## Preparation
- None

## What is delivered as part of the course

**Description:** [Make term requests to existing ontologies](#request)

## Tutorials
- None

## Additional materials and resources
- [How select and request terms from ontologies](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) - Blog post by Chris Mungall
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)
- [OntoTips](https://douroucouli.wordpress.com/category/tutorials/) - A guide by Chris Mungall covering various aspects of ontology engineering.

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)

<a name="request"></a> 
## 7. Making term requests to existing ontologies

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
- [https://github.com/monarch-initiative/mondo/issues/2541](https://github.com/monarch-initiative/mondo/issues/2541)
- [https://github.com/monarch-initiative/mondo/issues/1719](https://github.com/monarch-initiative/mondo/issues/1719)
Note: while this ticket generally follows best practices, one thing that can be improved is defining the synonym scope. Generally, when the synonym scope is not explicity mentioned, it is assumed it is an _exact synonym_.
- [https://github.com/monarch-initiative/mondo/issues/1188](https://github.com/monarch-initiative/mondo/issues/1188)
- [https://github.com/monarch-initiative/mondo/issues/2945](https://github.com/monarch-initiative/mondo/issues/2945)

#### Tickets that did not follow best practices:
- [https://github.com/monarch-initiative/mondo/issues/1837](https://github.com/monarch-initiative/mondo/issues/1837)
- [https://github.com/monarch-initiative/mondo/issues/276](https://github.com/monarch-initiative/mondo/issues/276)

### Submitting other issues to Mondo

- Users may want to request other types of changes to Mondo (or any other ontology) beyond just adding a new term.
- The Mondo curation team created many [issue templates](https://github.com/monarch-initiative/mondo/issues/new/choose) for users, for specific types of requests.
- If none of the issue templates fit your issue, you can scroll to the bottom and click [Open a blank issue](https://github.com/monarch-initiative/mondo/issues/new) 
