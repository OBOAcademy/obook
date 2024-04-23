# Synonyms in OBO

A synonym indicates an alternative name for a term. Terms can have multiple synonyms of any type. For example, the Mondo term MONDO:0005992 cancer, has many exact synonyms and a related synonym:

<img width="653" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/3120bf59-1802-4209-b896-8039c96a7b28">


### The scope of a synonym may fall into one of four categories:

<img width="638" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/c61ca5df-37cb-424c-86c5-504a02665d6e">


#### Exact

The definition of the synonym is exactly the same as primary term definition. This is used when the same class can have more than one name.

For example, hereditary Wilms' tumor has the exact synonoym familial Wilms' tumor.

Additionally, translations into other languages are listed as exact synonyms. For example, the Plant Ontology list both Spanish and Japanese translations as exact synonyms; e.g. anther wall has exact synonym ‘pared de la antera’ (Spanish) and ‘葯壁 ‘(Japanese).

#### Narrow

The definition of the synonym is the same as the primary definition, but has additional qualifiers.

For example, pod is a narrow synonym of fruit.

**Note** - when adding a narrow synonym, please first consider whether a new subclass should be added instead of a narrow synonym. If there is any uncertainty, start a discussion on the GitHub issue tracker.

#### Broad

The primary definition accurately describes the synonym, but the definition of the synonym may encompass other structures as well. In some cases where a broad synonym is given, it will be a broad synonym for more than one ontology term.

For example, Cyst of eyelid has the broad synonym Lesion of the eyelid.

**Note** - when adding a broad synonym, please first consider whether a new superclass should be added instead of a broad synonym. If there is any uncertainty, start a discussion on the GitHub issue tracker.

#### Related

This scope is applied when a word of phrase has been used synonymously with the primary term name in the literature, but the usage is not strictly correct. That is, the synonym in fact has a slightly different meaning than the primary term name. Since users may not be aware that the synonym was being used incorrectly when searching for a term, related synonyms are included.

For example, Autistic behavior has the related synonym Autism spectrum disorder.

### Synonym types

Synonyms can also be classified by types. The default is no type. The synonym types vary in each ontology, but some commonly used synonym types include:

Synonym type | Description | Example
-- | -- | -- |
[abbreviation](http://purl.obolibrary.org/obo/OMO_0003000) | to indicate the synonym is an abbreviation. **Note** the scope for an acronym should be determined on a case-by-case basis. Not all acronyms are necessarily exact. | MONDO:0000190 ventricular fibrillation synonym: VF |
[dubious synonym](http://purl.obolibrary.org/obo/OMO_0003002) | to indicate the synonym may be suspect | MONDO:0024309 neuropathy, hereditary sensory and autonomic, type 2A, synonym: Morvan disease|
[layperson term](http://purl.obolibrary.org/obo/OMO_0003003) | to indicate the synonym is a common language (used by the Human Phenotype Ontology) | HP:0001028 Hemangioma, synonym: Strawberry mark |
[plural form](http://purl.obolibrary.org/obo/OMO_0003004) | indicating the form of the term that means more than one | HP:0010819 Atonic seizure, synonym: Atonic seizures|
[UK spelling](http://purl.obolibrary.org/obo/OMO_0003005) | the english language spelling that is used in the United Kingdom (UK) but not in the United States (US) | MONDO:0005059 leukemia, synonym: leukaemia (disease)|
[ambiguous](http://purl.obolibrary.org/obo/OMO_0003001) | to indicate the synonym is open to more than one interpretation; may have a double meaning | MONDO:0019781 astrocytoma (excluding glioblastoma) synonym: "astrocytoma" (see associated [GitHub ticket](https://github.com/NCI-Thesaurus/thesaurus-obo-edition/issues/23) |

Additional standardized synonym types can be found in the [OBO Metadata Ontology](https://obofoundry.org/ontology/omo)
as sub-properties of [oboInOwl:SynonymType](https://www.ebi.ac.uk/ols4/ontologies/omo/properties/http%253A%252F%252Fwww.geneontology.org%252Fformats%252FoboInOwl%2523SynonymTypeProperty).

#### Additional (interesting) Synonym Type Examples from Mondo

- 'A synonym that is historic and discouraged' (DEPRECATED)
- 'Synonym to be removed from public release but maintained in edit version as record of external usage' (EXCLUDE)
- ClinGen label (CLINGEN_LABEL)

### Database cross references

Whenever possible, database cross-references (dbxrefs) for synonyms should be provided, to indicate the publication that used the synonym. References to PubMed IDs should be in the format PMID:XXXXXXX (no space). However, dbxrefs for synonyms are not mandatory in most ontologies.
