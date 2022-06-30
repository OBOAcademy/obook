# Make term requests to existing ontologies

## Prerequisites
You need to have a GitHub account to make term requests. Sign up for a free [GitHub](https://github.com/join) account.

## Making term requests to existing ontologies

In the following we explain how to make a term request to an ontology.

### Best practices guidelines

**Note**: We appreciate your contributions to extending and improving ontologies. Following best guidelines is appreciated by the curators and developers, and assists them in addressing your issue more quickly. However, we understand if you are not always able to follow these best practices.

### Making a new term request

1. Go to the ontology issue tracker in GitHub 
1. Select New issue
1. Pick appropriate template (if applicable)
1. If there is a template, fill in the information that is requested on the template below each header. 
1. General information that should be included in a new term request:
	1. The label for the new term. Note- new term requests should not match existing terms or synonyms.
	1. Parent class. You can use a ontology search enginge like [OLS](https://www.ebi.ac.uk/ols/index) to search for parent terms in your respective ontology.
	1. A concise definition (see this [guide on writing good ontology definitions](https://douroucouli.wordpress.com/2019/07/08/ontotip-write-simple-concise-clear-operational-textual-definitions/))
	1. Indicate the source or database cross-reference(s) for the definition
	1. Synonyms - please provide a synonym scope and source or database cross-reference (see Synonym scopes below)
	1. Your ORCID or the URL for your group
	1. Add any additional comments at the end
1. Click Submit New Issue
1. An ontology curator will review your issue and follow up with you if more information is needed.

#### Synonym scopes:
- Exact - an exact match
- Narrow - more specific term
- Broad - more general term
- Related - a word of phrase has been used synonymously with the primary term name in the literature, but the usage is not strictly correct 

### Formatting:
1. For most ontologies, the preferred term labels should be lowercase (unless it is a proper name or abbreviation)
1. Write the request below the prompts on the template so the Markdown formatting displays properly
1. Synonyms should be lowercase (with exceptions above)
1. Definition source - if from PubMed, please use the format PMID:XXXXXX (no space)
1. Include the ID and label for the parent term

### Submitting other issues

- Users may want to request other types of changes to an ontology such as Mondo beyond just adding a new term.
- Other types of requests may include changes to the classification, typos, bugs, etc.

## Additional materials and resources
- [How select and request terms from ontologies](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) - Blog post by Chris Mungall
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)
- [OntoTips](https://douroucouli.wordpress.com/category/tutorials/) - A guide by Chris Mungall covering various aspects of ontology engineering.

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)