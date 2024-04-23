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

##### Mondo test 
- In Mondo, this SPARQL query checks for duplicate exact synonyms between terms but excludes any abbreviations.
- For example, "ALPS" is an abbreviation for MONDO:0017979 autoimmune lymphoproliferative syndrome and 
- Implemented as [qc-duplicate-exact-synonym-no-abbrev.sparql](https://mondo.readthedocs.io/en/latest/editors-guide/quality-control-tests/#qc-duplicate-exact-synonym-no-abbrevsparql) in Mondo. 

??? QC duplicate exact synonym no abbreviation query

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

