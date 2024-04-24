## Synonym validation

### Basic validation

#### The same synonym cannot be an exact synonym of two distinct concepts

- Implemented in the form of the [duplicate_exact_synonym](https://robot.obolibrary.org/report_queries/duplicate_exact_synonym) check implemented in ROBOT report.
- The most fundamental of all synonym checks: if the synonym is _exact_, the assumption is that no two terms can have the same synonym.

!!! warning

    Some exact synonyms are not globally unique. For example, the acronym "ASD" is an exact synonym of the concept representing "Atrial septal defect" and "Autism Spectrum Disorder".

#### The same synonym cannot be duplicated with a different scope 

- An entity has duplicate synonyms with different properties (e.g. the same broad and related synonym). This causes ambiguity.
- Implemented in the form of [Duplicate Scoped Synonyms](https://robot.obolibrary.org/report_queries/duplicate_scoped_synonym) check in the ROBOT report.

#### The same synonym cannot be an exact synonym and a label at the same time

- Implemented in the form of the [duplicate_label_synonym](https://robot.obolibrary.org/report_queries/duplicate_label_synonym) check implemented in ROBOT report.
- This check has a long history of controversy and confusion. In general, we cannot expect this assumption to hold in all cases for various reasons:
    - For historical reasons, many ontologies avoid attaching synonym metadata and provenance to the primary label of a class. For example, the Mondo ontology captures the preferred labels of various major nomenclature organisations. Instead of capturing which organisations prefer the label on the primary label, they are captured as "exact syonyms", even though the two often co-incide.
    - It is often considered more convenient to be able to expect _all_ exact synonyms to be available via `oboInOwl:hasExactSynonym`, and not requiring downstream users to _know_ that exact synonyms are scattered across multiple properties (such as `rdfs:label`).
    - No matter whether you agree or disagree with the above, as a ontology _user_ you should not assume
 
#### Synonym types must be a child of Synonym Type Property

- A synonym type is used in an annotation, but is not properly declared as a child of oboInOwl:SynonymTypeProperty. This can cause problems with conversions to OBO format.
- For example, if you add your own synonym type, like abbreviation, it has to be child of oboInOwl:SynonymTypeProperty
- Implemented in the form of [Missing Synonym Type Declaration](https://robot.obolibrary.org/report_queries/missing_synonymtype_declaration) in the ROBOT report.

### Advanced validation

##### Duplicate exact synonym check that excludes abbreviations
- In Mondo, this SPARQL query checks for duplicate exact synonyms between terms but excludes any abbreviations.
- For example, "SMS" is an abbreviation for MONDO:0008491 stiff-person syndrome and MONDO:0008434 Smith-Magenis syndrome and this is acceptable.
- Implemented as [qc-duplicate-exact-synonym-no-abbrev.sparql](https://mondo.readthedocs.io/en/latest/editors-guide/quality-control-tests/#qc-duplicate-exact-synonym-no-abbrevsparql) in Mondo. 

??? Query

    ```
    PREFIX obo: <http://purl.obolibrary.org/obo/>
    PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
    PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    
    SELECT DISTINCT ?entity ?property ?value WHERE {
      VALUES ?property1 {
        obo:IAO_0000118
        oboInOwl:hasExactSynonym
        rdfs:label
      }
      VALUES ?property2 {
        obo:IAO_0000118
        oboInOwl:hasExactSynonym
        rdfs:label
      }
      ?entity1 ?property1 ?value.
      ?entity2 ?property2 ?value .
    
      FILTER NOT EXISTS {
        ?axiom owl:annotatedSource ?entity1 ;
             owl:annotatedProperty ?property1 ;
             owl:annotatedTarget ?value ;
             oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#ABBREVIATION> .
      }
    
      FILTER NOT EXISTS {
        ?axiom owl:annotatedSource ?entity2 ;
             owl:annotatedProperty ?property2 ;
             owl:annotatedTarget ?value ;
             oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#ABBREVIATION> .
      }
    
      FILTER NOT EXISTS { ?entity owl:deprecated true }
      FILTER NOT EXISTS { ?entity2 owl:deprecated true }
      FILTER (?entity1 != ?entity2)
      FILTER (!isBlank(?entity1))
      FILTER (!isBlank(?entity2))
      BIND(CONCAT(CONCAT(REPLACE(str(?entity1),"http://purl.obolibrary.org/obo/MONDO_","MONDO:"),"-"), REPLACE(str(?entity2),"http://purl.obolibrary.org/obo/MONDO_","MONDO:")) as ?entity)
      BIND(CONCAT(CONCAT(REPLACE(REPLACE(str(?property1),"http://www.w3.org/2000/01/rdf-schema#","rdfs:"),"http://www.geneontology.org/formats/oboInOwl#","oboInOwl:"),"-"), REPLACE(REPLACE(str(?property1),"http://www.w3.org/2000/01/rdf-schema#","rdfs:"),"http://www.geneontology.org/formats/oboInOwl#","oboInOwl:")) as ?property)
    }
    ORDER BY DESC(UCASE(str(?value)))
    ```

##### Duplicate OMIM synonyms as exact and related in Mondo
- In Mondo, this SPARQL query checks for duplicate synonyms between OMIM terms that are both exact and related.
- This is a very specific use case to Mondo, as OMIM synonyms were initially brought in as related synonyms.
- Implemented as [qc-related-exact-synonym-omim.sparql](https://mondo.readthedocs.io/en/latest/editors-guide/quality-control-tests/#qc-related-exact-synonym-omimsparql) in Mondo. 

??? Query

    ```    
    prefix owl: <http://www.w3.org/2002/07/owl#>
    prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
    prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    
    SELECT DISTINCT ?entity ?property ?value WHERE {
      { 
        ?entity oboInOwl:hasRelatedSynonym ?related ;
          rdfs:label ?entity_label ;
          oboInOwl:hasExactSynonym ?exact ;
          a owl:Class .
          [
             a owl:Axiom ;
               owl:annotatedSource ?entity ;
               owl:annotatedProperty oboInOwl:hasExactSynonym ;
               owl:annotatedTarget ?exact ;
               oboInOwl:hasDbXref ?xref1 
          ] .
          [
             a owl:Axiom ;
               owl:annotatedSource ?entity ;
               owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
               owl:annotatedTarget ?related ;
               oboInOwl:hasDbXref ?xref2 
          ] .
    
        FILTER (str(?related)=str(?exact))
        FILTER (regex(str(?xref1), "OMIM^"))
        FILTER (regex(str(?xref2), "OMIM^"))
        FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
        BIND(oboInOwl:hasExactSynonym as ?property)
      }
    }
    
    ORDER BY ?entity
    ```
##### Exact Synonyms/Non-exact Mappings
- In Mondo, this SPARQL query checks for an exact synonym and a database cross-reference (dbxref) that is not exact. If the dbxef is equivalent to the Mondo term, the synonyms from that term should be added as exact synonyms. 
- This is a very specific use case to Mondo, as dbxrefs in Mondo have equivalence mappings (in the form of MONDO:equivalentTo). The issue here was, in a merger, DOID:5603 was added as an equivalent dbxref, but the synonyms 'T-cell acute lymphoblastic leukemia' and 'precursor T lymphoblastic leukemia' were related synonyms. They were changed to exact and the QC check passed.
- Implemented as [qc-exact-synonyms-non-exact-mappings.sparql](https://mondo.readthedocs.io/en/latest/editors-guide/quality-control-tests/#qc-exact-synonyms-non-exact-mappingssparql) in Mondo.
- See [Pull Request here](https://github.com/monarch-initiative/mondo/pull/7472) where the QC check failed.

    <img width="1039" alt="image" src="https://github.com/OBOAcademy/obook/assets/6722114/815b12ba-30b8-4c99-9e96-72781ab4ef40">

??? Query

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>

SELECT DISTINCT ?entity ?label ?xref ?synonym ?code
WHERE {

  VALUES ?code {
    "MONDO:relatedTo"^^xsd:string
    "MONDO:mondoIsNarrowerThanSource"^^xsd:string
    "MONDO:directSiblingOf"^^xsd:string
    "MONDO:mondoIsBroaderThanSource"^^xsd:string
  }

  ?entity rdfs:subClassOf* MONDO:0000001 .
  ?entity rdfs:label ?label .

  ?entity oboInOwl:hasDbXref ?xref .
    [ 
      owl:annotatedSource ?entity ;
      owl:annotatedProperty oboInOwl:hasDbXref ;
      owl:annotatedTarget ?xref ;
      oboInOwl:source ?code 
    ] .

  ?entity oboInOwl:hasExactSynonym ?synonym .
    [ 
      owl:annotatedSource ?entity ;
      owl:annotatedProperty oboInOwl:hasExactSynonym ;
      owl:annotatedTarget ?synonym ;
      oboInOwl:hasDbXref ?xref 
    ] .

}
```
