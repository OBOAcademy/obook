# Reference templates for SPARQL queries 

This document contains template SPARQL queries that can be adapted. 
Comments are added in-code with `#` above each step to explain them so that queries can be spliced together

## Checks/Report generation

#### Definition lacks xref 
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

#### Checks wether definitions contain underscore characters 
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

## Removing Triples

#### Removes all RO terms
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