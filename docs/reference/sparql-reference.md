# Reference templates for SPARQL queries

This document contains template SPARQL queries that can be adapted.
Comments are added in-code with `#` above each step to explain them so that queries can be spliced together

## Checks/Report generation

### All terms native to ontology

note: we assume that all native terms here have the same namespace - that of the ontology

```SPARQL
# select unique instances of the variable
SELECT DISTINCT ?term
WHERE {
  # selecting where the variable term is either used as a subject or object
  { ?s1 ?p1 ?term . }
  UNION
  { ?term ?p2 ?o2 . }
  # filtering out only terms that have the MONDO namespace (assumed to be native terms)
  FILTER(isIRI(?term) && (STRSTARTS(str(?term), "http://purl.obolibrary.org/obo/MONDO_")))
}
```

### Report of terms with labels containing certain strings in ubergraph

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix BFO: <http://purl.obolibrary.org/obo/BFO_>

# selecting only unique instances of the three variables
SELECT DISTINCT ?entity ?label WHERE
{
  # the variable label is a rdfs:label
  VALUES ?property {
    rdfs:label
  }
  
  # only look for uberon terms. note: this is only used in ubergraph, use filter for local ontology instead.
  ?entity rdfs:isDefinedBy <http://purl.obolibrary.org/obo/uberon.owl> .
    
  # defining the order of variables in the triple
  ?entity ?property ?label .
  # entity must be material
  ?entity rdfs:subClassOf BFO:0000040
  # filtering out triples where the variable label has sulcus or incisure, or fissure in it
  FILTER(contains(STR(?label), "sulcus")||contains(STR(?label), "incisure")||contains(STR(?label), "fissure"))

}
# arrange report by entity variable
ORDER BY ?entity
```

### Report of labels and definitions of terms with certain namespace

```SPARQL
prefix label: <http://www.w3.org/2000/01/rdf-schema#label>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix definition: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>

# select a report with 3 variables
SELECT DISTINCT ?term ?label ?def

# defining the properties to be used
	WHERE {
		VALUES ?defproperty {
 		definition:
		}
		VALUES ?labelproperty {
 		label:
		}

# defining the order of the triples
      ?term ?defproperty ?def .
      ?term ?labelproperty ?label .
      
# selects entities that are in a certain namespace
  FILTER(isIRI(?term) && (STRSTARTS(str(?term), "http://purl.obolibrary.org/obo/CP_")))
}

# arrange report by term variable
ORDER BY ?term
```


### Definition lacks xref

adaptable for lacking particular annotation

```SPARQL
# adding prefixes used
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix definition: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>

SELECT ?entity ?property ?value WHERE
{
  # the variable property has to be defintion (IAO:0000115)
  VALUES ?property {
    definition:
  }
  # defining the order of variables in the triple
  ?entity ?property ?value .

  # selecting annotation on definition
  ?def_anno a owl:Axiom ;
  owl:annotatedSource ?entity ;
  owl:annotatedProperty definition: ;
  owl:annotatedTarget ?value .

  # filters out definitions which do not have a dbxref annotiton
  FILTER NOT EXISTS {
    ?def_anno oboInOwl:hasDbXref ?x .
  }

  # removes triples where entity is blank
  FILTER (!isBlank(?entity))
  # selects entities that are native to ontology (in this case MONDO)
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))

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
prefix definition: <http://purl.obolibrary.org/obo/IAO_0000115>

# selecting only unique instances of the three variables
SELECT DISTINCT ?entity ?property ?value WHERE
{
  # the variable property has to be definition (IAO:0000115)
  VALUES ?property {
    definition:
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
prefix dcterms: <http://purl.org/dc/terms/>

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
  FILTER (?property NOT IN (dce:creator, dce:date, IAO:0000115, IAO:0000231, IAO:0100001, mondo:excluded_subClassOf, mondo:excluded_from_qc_check, mondo:excluded_synonym, mondo:pathogenesis, mondo:related, mondo:confidence, dcterms:conformsTo, mondo:should_conform_to, oboInOwl:consider, oboInOwl:created_by, oboInOwl:creation_date, oboInOwl:hasAlternativeId, oboInOwl:hasBroadSynonym, oboInOwl:hasDbXref, oboInOwl:hasExactSynonym, oboInOwl:hasNarrowSynonym, oboInOwl:hasRelatedSynonym, oboInOwl:id, oboInOwl:inSubset, owl:deprecated, rdfs:comment, rdfs:isDefinedBy, rdfs:label, rdfs:seeAlso, RO:0002161, skos:broadMatch, skos:closeMatch, skos:exactMatch, skos:narrowMatch))
}
```

### Checking for misused replaced_by

adaptable for checking that a property is used in a certain way

```SPARQL

# adding prefixes used
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX replacedBy: <http://purl.obolibrary.org/obo/IAO_0100001>

# selecting only unique instances of the three variables
SELECT DISTINCT ?entity ?property ?value WHERE {
 # the variable property is IAO_0100001 (item replaced by)
 VALUES ?property { replacedBy: }

 # order of the variables in the triple
 ?entity ?property ?value .
 # removing entities that have either owl:deprecated true or oboInOwl:ObsoleteClass (these entities are the only ones that should have replaced_by)
 FILTER NOT EXISTS { ?entity owl:deprecated true }
 FILTER (?entity != oboInOwl:ObsoleteClass)
}
# arrange report by entity variable
ORDER BY ?entity
```

## Count

### Count class by prefixes

```SPARQL
# this query counts the number of classes you have with each prefix (eg number of MONDO terms, CL terms, etc.)

# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix obo: <http://purl.obolibrary.org/obo/>

# selecting 2 variables, prefix and numberOfClasses, where number of classes is a count of distinct cls
SELECT ?prefix (COUNT(DISTINCT ?cls) AS ?numberOfClasses) WHERE
{
  # the variable cls is a class
  ?cls a owl:Class .
  # removes any cases where the variable cls is blank
  FILTER (!isBlank(?cls))
  # Binds the variable prefix as the prefix of the class (eg. MONDO, CL, etc.). classes that do not have obo purls will come out as blank in the report.
  BIND( STRBEFORE(STRAFTER(str(?cls),"http://purl.obolibrary.org/obo/"), "_") AS ?prefix)
}
# grouping the count by prefix
GROUP BY ?prefix
```

### Counting subclasses in a namespace

```SPARQL
# this query counts the number of classes that are subclass of CL:0000003 (native cell) that are in the pcl namespace

# adding prefixes used
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX CL: <http://purl.obolibrary.org/obo/CL_>
PREFIX PCL: <http://purl.obolibrary.org/obo/PCL_>

# count the number of unique term
SELECT (COUNT (DISTINCT ?term) as ?pclcells)
WHERE {
    # the variable term is a class
  	?term a owl:Class .
    # the variable term has to be a subclass of CL:0000003, including those that are subclassof by property path
  	?term rdfs:subClassOf* CL:0000003
  # only count the term if it is in the pcl namespace
  FILTER(isIRI(?term) && (STRSTARTS(str(?term), "http://purl.obolibrary.org/obo/PCL_")))
}
```

## Removing

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

### Deleting axiom annotations by prefix

```SPARQL
# adding prefixes used
prefix owl: <http://www.w3.org/2002/07/owl#>

# delete triples
DELETE {
  ?anno ?property ?value .
}
WHERE {
  # the variable property is either synonym_type: or source:
  VALUES ?property { synonym_type: source: }
  # structure of variable value and variable anno
  ?anno a owl:Axiom ;
         owl:annotatedSource ?s ;
         owl:annotatedProperty ?p ;
         owl:annotatedTarget ?o ;
         ?property ?value .
  # filter out the variable value which start with "ICD10EXP:"
  FILTER(STRSTARTS(STR(?value),"ICD10EXP:"))
}
```

## Replacing

### Replace oboInOwl:source with oboInOwl:hasDbXref in synonyms annotations

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
```
