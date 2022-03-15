# Reference templates for SPARQL queries 

This document contains template SPARQL queries that can be adapted. 
Comments are added in-code with `#` above each step to explain them so that queries can be spliced together

## Checks/Report generation

### Definition lacks xref 
adaptable for lacking particular annotation

```SPARQL
# adding prefixes used
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>

SELECT ?entity ?property ?value WHERE 
{
  # selects only definition
  ?entity def: ?value .
  
  # selecting annotation on definition
  ?def_anno a owl:Axiom ;
  owl:annotatedSource ?entity ;
  owl:annotatedProperty def: ;
  owl:annotatedTarget ?value .
  
  # filters out definitions which do not have a dbxref annotiton
  FILTER NOT EXISTS {
    ?def_anno oio:hasDbXref ?x .
  }
  
  # removes triples where entity is blank
  FILTER (!isBlank(?entity))
  # selects entities that are native to ontology (in this case MONDO)
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  # assigning def: as the property variable
  BIND(def: as ?property)
}
# arrange report by entity variable
ORDER BY ?entity
```

### Checks wether definitions contain underscore characters 
adaptable for checking if there is particular character in annotation

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>

# selecting only unique instances of the three variables 
SELECT DISTINCT ?entity ?property ?value WHERE 
{
  # the variable property has to be IAO:0000115 
  VALUES ?property {
    IAO:0000115
  }
  # defining the order of variables in the triple 
  ?entity ?property ?value .
  # filtering out triples where the variable value has _ in it
  FILTER( regex(STR(?value), "_"))
  # removes triples where entity is blank
  FILTER (!isBlank(?entity))
}
# arrange report by entity variable
ORDER BY ?entity
```

### Only allowing a fix set of annotation properties 

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix RO: <http://purl.obolibrary.org/obo/RO_>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix skos: <http://www.w3.org/2004/02/skos/core#>
prefix dce: <http://purl.org/dc/elements/1.1/>
prefix dc: <http://purl.org/dc/terms/>

# selecting only unique instances of the three variables 
SELECT DISTINCT ?term ?property ?value WHERE 
{
  # order of the variables in the triple
	?term ?property ?value .
    # the variable property is an annotation property
  	?property a owl:AnnotationProperty .
  # selects entities that are native to ontology (in this case MONDO)
	FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
    # removes triples where the variable value is blank
  	FILTER(!isBlank(?value))
  # listing the allowed annotation properties
  FILTER (?property NOT IN (dce:creator, dce:date, IAO:0000115, IAO:0000231, IAO:0100001, mondo:excluded_subClassOf, mondo:excluded_from_qc_check, mondo:excluded_synonym, mondo:pathogenesis, mondo:related, mondo:confidence, dc:conformsTo, mondo:should_conform_to, oboInOwl:consider, oboInOwl:created_by, oboInOwl:creation_date, oboInOwl:hasAlternativeId, oboInOwl:hasBroadSynonym, oboInOwl:hasDbXref, oboInOwl:hasExactSynonym, oboInOwl:hasNarrowSynonym, oboInOwl:hasRelatedSynonym, oboInOwl:id, oboInOwl:inSubset, owl:deprecated, rdfs:comment, rdfs:isDefinedBy, rdfs:label, rdfs:seeAlso, RO:0002161, skos:broadMatch, skos:closeMatch, skos:exactMatch, skos:narrowMatch))
}
```

## Removing Triples

### Removes all RO terms
adaptable for removing all terms of a particular namespace

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# removing triples
DELETE {
  ?s ?p ?o
}
WHERE 
{ 
  {
    # the variable p must be a rdfs:label
    VALUES ?p {
      rdfs:label
    }
  # the variable s is an object property
  ?s a owl:ObjectProperty ;
  # the other variables can be anything else (note the above value restriction of p)
  ?p ?o
    # filter out triples where ?s starts with "http://purl.obolibrary.org/obo/RO_" 
    FILTER (isIRI(?s) && STRSTARTS(str(?s), "http://purl.obolibrary.org/obo/RO_"))
  }
}
```

## Replacing 

### Replace oio:source with oio:hasDbXref in synonyms annotations
adaptable for replacing annotations properties on particular axioms

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

# delete triples where the relation is oboInOwl:source
DELETE {
    ?ax oboInOwl:source ?source .
}
# insert triples where the variables ax and source defined above are used, but using oboInOwl:hasDbXref instead
INSERT {
    ?ax oboInOwl:hasDbXref ?source .
}
WHERE 
{
  # restricting to triples where the property variable is in this list
  VALUES ?property { oboInOwl:hasExactSynonym oboInOwl:hasNarrowSynonym  oboInOwl:hasBroadSynonym oboInOwl:hasCloseSynonym oboInOwl:hasRelatedSynonym } .
  # order of the variables in the triple
  ?entity ?property ?value .
  # structure on which the variable ax and source applies 
  ?ax rdf:type owl:Axiom ;
    owl:annotatedSource ?entity ;
    owl:annotatedTarget ?value ;
    owl:annotatedProperty ?property ;
    oboInOwl:source ?source .
  # filtering out triples where entity is an IRI
  FILTER (isIRI(?entity))
}