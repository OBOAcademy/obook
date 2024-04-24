## Synonym Types

In contrast to [synonym properties](../reference/synonyms-obo.md), which encode the semantic precision of a specific synonym such as "exact" or "broad, _synonym types_ encode the purpose of the synonym. In the following, we will describe some basic synonym types and give examples of their usage.

!!! info "Definition synonym type"

    A synonym type represents the function of a specific synonym, such as "acronym", "layperson", or "language translation".

### Acronyms

!!! info

    An word formed from the initial letter or letters of each of the successive parts or major parts of a compound term (https://www.merriam-webster.com/dictionary/acronym).


### Common Synonym Types

Synonyms can also be classified by types. The default is no type. The synonym types vary in each ontology, but some commonly used synonym types include:

Synonym type | Description | Example
-- | -- | -- 
[abbreviation](http://purl.obolibrary.org/obo/OMO_0003000) | to indicate the synonym is an abbreviation. **Note** the scope for an acronym should be determined on a case-by-case basis. Not all acronyms are necessarily exact. | MONDO:0000190 ventricular fibrillation synonym: VF |
[dubious synonym](http://purl.obolibrary.org/obo/OMO_0003002) | to indicate the synonym may be suspect | MONDO:0024309 neuropathy, hereditary sensory and autonomic, type 2A, synonym: Morvan disease|
[layperson term](http://purl.obolibrary.org/obo/OMO_0003003) | to indicate the synonym is a common language (used by the Human Phenotype Ontology) | HP:0001028 Hemangioma, synonym: Strawberry mark |
[plural form](http://purl.obolibrary.org/obo/OMO_0003004) | indicating the form of the term that means more than one | HP:0010819 Atonic seizure, synonym: Atonic seizures|
[UK spelling](http://purl.obolibrary.org/obo/OMO_0003005) | the english language spelling that is used in the United Kingdom (UK) but not in the United States (US) | MONDO:0005059 leukemia, synonym: leukaemia (disease)|
[ambiguous](http://purl.obolibrary.org/obo/OMO_0003001) | to indicate the synonym is open to more than one interpretation; may have a double meaning | MONDO:0019781 astrocytoma (excluding glioblastoma) synonym: "astrocytoma" (see associated [GitHub ticket](https://github.com/NCI-Thesaurus/thesaurus-obo-edition/issues/23) |

Additional standardized synonym types can be found in the [OBO Metadata Ontology](https://obofoundry.org/ontology/omo)
as sub-properties of [oboInOwl:SynonymType](https://www.ebi.ac.uk/ols4/ontologies/omo/properties/http%253A%252F%252Fwww.geneontology.org%252Fformats%252FoboInOwl%2523SynonymTypeProperty).

### Additional (interesting) Synonym Type Examples from Mondo

Synonym type | Description | Example
-- | -- | -- 
'A synonym that is historic and discouraged' (DEPRECATED) | Mondo marks synonyms with DEPRECATED that are historic and no longer appropriate to use, e.g. all occurrences of “mental retardation” should be “intellectual disability”. They try to avoid including things in this list: https://en.wikipedia.org/wiki/List_of_medical_eponyms_with_Nazi_associations but if it’s established (e.g. Wegener granulomatosis), it may be included as a synonym and mark DEPRECATED | MONDO:0007113 Angelman syndrome, synonym: happy puppet syndrome
'Synonym to be removed from public release but maintained in edit version as record of external usage' (EXCLUDE) | Some synonyms are annotated with EXCLUDE, e.g. “NOS” (not otherwise specified) synonyms. It is useful to have these in the edit version, but these are filtered on release. | MONDO:0007667 subependymoma, synonym: subependymal astrocytoma NOS
ClinGen label (CLINGEN_LABEL) | Added to gene-based names/synonyms (or other labels) that were requested by an external user, ClinGen, and other terms that are the preferred terms for ClinGen.| MONDO:0010015 anterior segment dysgenesis 7, synonym: PXDN-related ocular dysgenesis

## How to add Synonym Types in Protege v5.6.1

1. Click on the annotation button next to the synonym
<img width="855" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/5332a6c7-379c-4558-843c-e3f0f7ee7432">

2. Click the annotation button in the box
<img width="529" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/3772fd60-0522-4d51-831d-35de371e89ee">

3. Select **Entity IRI** and start searching for the synonym type in the search box, then select the annotation you wish to add. Click OK on each box.
<img width="741" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/929d993c-ae10-4b8a-9be7-12b7210a1c24">

4. You will see your annotation on your synonym.
<img width="862" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/1b7e5da2-5a39-4795-b605-82c13d131c83">




