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

### Database cross references

Whenever possible, database cross-references (dbxrefs) for synonyms should be provided, to indicate the publication that used the synonym. References to PubMed IDs should be in the format PMID:XXXXXXX (no space). See example below. However, dbxrefs for synonyms are not mandatory in most ontologies.

<img width="428" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/171829f2-f057-4445-8ca8-02d2aeae9ce3">
