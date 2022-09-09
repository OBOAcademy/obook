# Make term requests to existing ontologies

## Prerequisites

You need to have a GitHub account to make term requests. Sign up for a free [GitHub](https://github.com/join) account.

## Background

### Recommended reading

This guide on [_How to select and request terms from ontologies_](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) by Chris Mungall provides some helpful background and tips for making term requests.

### Why make a new term request?

Onologies are under constant development and are continuously expanded and iterated upon. You may discover that a term you need is not available in your preferred ontology. In this case, please make a new term request to the ontology.

### Making term requests to existing ontologies

In the following text below, we describe best practices for making a term request to an ontology. In general, requests for new terms are make on the ontology GitHub issue tracker. For example, this is the GitHub issue tracker for the [Uberon Anatomy onology](https://github.com/obophenotype/uberon/issues).

**Note**: These are suggestions and not strict rules. We appreciate your contributions to extending and improving ontologies. Following best guidelines is appreciated by the curators and developers, and assists them in addressing your issue more quickly. However, we understand if you are not always able to follow these best practices. Please add as much information as possible, and if there are any questions, the ontology developer may follow up with you for further clarification.

## Making a new term request

1. Go to the ontology issue tracker in GitHub
1. Select New issue
1. Pick appropriate template (if applicable)
1. If there is a template, fill in the information that is requested on the template below each header.
1. General information that should be included in a new term request:
   1. **Preferred label**: Your preferred name or label for the new term. Note- new term request should not match existing terms or synonyms.
   1. **Parent**: The parent or superclass for that term. Remember that ontologies use subsumption reasoning, meaning that a subclass/child will inherit all the properties of the parent. In most ontologies, terms can have multiple classification, means terms can be classified under more than one parent.
      **_Note_**: You can use a ontology search enginge like [OLS](https://www.ebi.ac.uk/ols/index) to double check your class does not already exist and to search for parent terms in your respective ontology.
   1. **Definition**: Please write a concise definition of your term (see this [guide on writing good ontology definitions](https://douroucouli.wordpress.com/2019/07/08/ontotip-write-simple-concise-clear-operational-textual-definitions/)).
   1. **Definition database cross-reference(s)**: Indicate the source or database cross-reference(s) or source for the definition, such as a PubMed ID (PMID) or reference to a website.
   1. **Synonym(s)**: an alternative term that has the same or closely related meaning for your new term. Please indicate the **synonym scope** (see more details below).
   1. **Synonym database cross-reference(s)**: Provide a database cross-reference or source for the synonym, if applicable.
   1. Your **[ORCID](https://orcid.org/)** or the URL for your working group, if applicable. If you do not have an ORCID, you can sign up for one for free [here](https://orcid.org/).
      **_Note_**: You can link your ORCID in your GitHub profile.
   1. **Comments**: You can add any additional comments at the end. Please indicate if the comment should be included as a 'comment' annotation on the ontology term.
1. Click Submit New Issue
1. An ontology curator will review your issue and follow up with you if more information is needed.

#### Synonym scopes:

- **Exact** - an exact match
- **Narrow** - more specific term
- **Broad** - more general term
- **Related** - a word of phrase has been used synonymously with the primary term name in the literature, but the usage is not strictly correct

### Formatting:

1. For most ontologies, the preferred term labels should be lowercase (unless it is a proper name or abbreviation)
1. Write the request below the prompts on the template so the Markdown formatting displays properly
1. Synonyms should be lowercase (with exceptions above)
1. Definition source - if from PubMed, please use the format PMID:XXXXXX (no space)
1. Include the ID and label for the parent term

### Submitting other issues

- Users may want to request other types of changes to an ontology such as Mondo beyond just adding a new term.
- Other types of requests may include changes to the classification, typos, bugs, etc.
- Some ontologies have other templates available on their issue tracker. Select the appropriate template. If there is not an appropriate template available, scroll to the bottom and select 'open a blank issue'.

## Contributors

- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
