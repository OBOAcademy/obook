## Common Synonym Types

### Related materials

- [Overview of synonym properties](../reference/synonyms-obo.md)
- [Lesson on synonyms](../lessons/synonyms.md)

In contrast to [synonym properties](../reference/synonyms-obo.md), which encode the semantic precision of a specific synonym such as "exact" or "broad, _synonym types_ encode the purpose of the synonym. In the following, we will describe some basic synonym types and give examples of their usage.

!!! info "Definition synonym type"

    A synonym type represents the function of a specific synonym, such as "acronym", "layperson", or "language translation".

### Typical synonym types

Synonyms can also be classified by types. The default is no type. The synonym types vary in each ontology, but some commonly used synonym types include:

- [abbreviation](http://purl.obolibrary.org/obo/OMO_0003000) - to indicate the synonym is an abbreviation. **Note** the scope for an acronym should be determined on a case-by-case basis. Not all acronyms are necessarily exact.
- [ambiguous](http://purl.obolibrary.org/obo/OMO_0003001) - to indicate the synonym is open to more than one interpretation; may have a double meaning
- [dubious synonym](http://purl.obolibrary.org/obo/OMO_0003002) - to indicate the synonym may be suspect
- [layperson term](http://purl.obolibrary.org/obo/OMO_0003003) - to indicate the synonym is common language (used by the Human Phenotype Ontology)
- [plural form](http://purl.obolibrary.org/obo/OMO_0003004) - indicating the form of the term that means more than one
- [UK spelling](http://purl.obolibrary.org/obo/OMO_0003005) - the english language spelling that is used in the United Kingdom (UK) but not in the United States (US)

Additional standardized synonym types can be found in the [OBO Metadata Ontology](https://obofoundry.org/ontology/omo)
as sub-properties of `oboInOwl:SynonymType`.

### Acronyms

!!! info

    An word formed from the initial letter or letters of each of the successive parts or major parts of a compound term (https://www.merriam-webster.com/dictionary/acronym).


