# Generating SPARQL queries using LLMs

This tutorial will teach you how to create SPARQL queries by prompting a large language model (LLM). You may use whichever system you prefer, such as [ChatGPT](https://chatgpt.com/), [Gemini](https://gemini.google.com/), [Claude](https://www.anthropic.com/claude-code), etc. You are responsible for obtaining access to one of these tools prior to the session.


## Preparation
This tutorial uses LLMs, such as [ChatGPT](https://chatgpt.com/), [Gemini](https://gemini.google.com/), [Claude](https://www.anthropic.com/claude-code), etc. You are responsible for obtaining access and any to one of these tools prior to the session.

The resulting SPARQL queries can be tested using https://yasgui.triply.cc/# (endpoint https://ubergraph.apps.renci.org/sparql) or using [ROBOT query](https://robot.obolibrary.org/query). You are responsible for obtaining access to yasgui and/or installing ROBOT. 


## Prompting Best Practices
- Be specific and state the question cleary
	- Include examples in the prompt
	- Include prefixes and term IRIs/CURIEs in the prompt
	- Use the real name of a property, 'has material basis in germline mutation in' vs. gene association
	- Provide an OBO stanza or for more complicated queries the OWL class representation
- State what properties to return 
	- Select the CURIE, label, and definition
- State modifiers and constraints
 	- Limit to 10 results, sort by label
 	- Filter out obsolete terms
- Share an example query to extend
	- Use a base query and ask LLM to extend the query
- Ask for explanations of the query
	- Prompt for the query and also ask for a step-wise explanation of the query
- Review query, test, and iterate
	- Test the query in your tool of interest
	- If the query fails or returns incorrect information, share the error message and ask for a fix or clarify what’s missing
	- Some SPARQL constructs are not valid for ROBOT and the query needs to be modified
	- If the LLM starts returning circular options ask it to reset to clear the current conversation context


## Pitfalls and Limitations
- LLM hallucinations
	- queries might look plausible but be wrong or inefficient or not work with certain tools
- Schema/ontology drift
	- LLMs trained on old data may not match the current ontology
- Validate the query
	- Test the query using the tools mentioned earlier
- Provide feedback to the LLM
	- That did not work, e.g. try again using the correct prefix for MONDO


## Tutorial
### Example - Get a count of all subclasses of disease excluding obsolete terms
- Prompt:
Write a SPARQL query that counts the number of OWL classes in the MONDO ontology that are subclasses of MONDO:0000001 (disease) and do not include obsolete classes, which are marked as deprecated using `owl:deprecated true`.

- Prompt Breakdown:
Type of query - count
Target class - all subclasses of MONDO:0000001 (disease)
Filter - exclude deprecated terms
Ontology - MONDO


<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

# Get a count of all subclasses of disease excluding obsolete terms

SELECT (COUNT(DISTINCT ?cls) AS ?count)
WHERE {
  ?cls rdfs:subClassOf+ obo:MONDO_0000001 .
  ?cls a owl:Class .
  FILTER NOT EXISTS { ?cls owl:deprecated true }
}

```
</details>


### Example - Get a count of all MONDO classes with an exact synonym from Orphanet
- Prompt:
Write a SPARQL query that counts the number of non-obsolete OWL classes in the Mondo ontology that have an exact synonym with a database cross reference to Orphanet

- Prompt Breakdown:
Type of query - count
Target class - all non-obsolete Mondo classes
Synonym constraint - class must have oboInOwl:hasExactSynonym
Axiom constraint - the synonym must be annotated with an Xref and the value must start with "Orphanet:"
Filter - exclude deprecated classes
Ontology - MONDO

<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Get a count of all Mondo classes with an exact synonym from Orphanet

SELECT (COUNT(DISTINCT ?class) AS ?count)
WHERE {
  ?class a owl:Class .
  FILTER STRSTARTS(STR(?class), "http://purl.obolibrary.org/obo/MONDO_")
  FILTER NOT EXISTS { ?class owl:deprecated true }

  ?class oboInOwl:hasExactSynonym ?syn .

  ?axiom
    a owl:Axiom ;
    owl:annotatedSource ?class ;
    owl:annotatedProperty oboInOwl:hasExactSynonym ;
    owl:annotatedTarget ?syn ;
    oboInOwl:hasDbXref ?xref .

  FILTER STRSTARTS(STR(?xref), "Orphanet:")
}

```
</details>


### Example - Get a count of all exact synonyms with an Orphanet xref
- Prompt:
Write a SPARQL query that counts the number of exact synonyms in the Mondo ontology that have a database cross reference to Orphanet

- Prompt Breakdown:
Type of query - count all synonyms
Target class - all Mondo classes
Synonym constraint - class must have oboInOwl:hasExactSynonym
Axiom constraint - the synonym must be annotated with an Xref and the value must start with "Orphanet:"
Filter - exclude deprecated classes
Ontology - MONDO

<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Count all exact synonyms with an xref to Orphanet

SELECT (COUNT(DISTINCT ?syn) AS ?count)
WHERE {
  ?class a owl:Class .
  FILTER STRSTARTS(STR(?class), "http://purl.obolibrary.org/obo/MONDO_")
  FILTER NOT EXISTS { ?class owl:deprecated true }

  ?class oboInOwl:hasExactSynonym ?syn .

  ?axiom a owl:Axiom ;
         owl:annotatedSource ?class ;
         owl:annotatedProperty oboInOwl:hasExactSynonym ;
         owl:annotatedTarget ?syn ;
         oboInOwl:hasDbXref ?xref .

  FILTER STRSTARTS(STR(?xref), "Orphanet:")
}

```

</details>


### Example - Get all Mondo classes that have a gene association and it’s provenance
- Prompt:
Write a SPARQL query to get all Mondo classes that have a gene association, e.g. RO:0004003 'has material basis in germline mutation in', and also return the source provenance for the gene association. Include the Mondo CURIE, Mondo label, gene identifier, and source provenance in the result.

- Prompt Breakdown:
Type of query - select MONDO CURIE, label, gene identifier, source provenance
Target class - any Mondo class that has a gene association
Axiom constraint - the class must have a gene association (RO:0004003 'has material basis in germline mutation in')
Ontology - MONDO

<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?mondo_curie ?label ?gene ?source WHERE {
  ?mondo_class rdfs:subClassOf ?restriction .
  
  ?restriction a owl:Restriction ;
               owl:onProperty obo:RO_0004003 ;
               owl:someValuesFrom ?gene .

  ?mondo_class rdfs:label ?label .

  ?axiom a owl:Axiom ;
         owl:annotatedSource ?mondo_class ;
         owl:annotatedProperty rdfs:subClassOf ;
         owl:annotatedTarget ?restriction ;
         oboInOwl:source ?source .

  BIND(REPLACE(STR(?mondo_class), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?mondo_curie)
}
ORDER BY ?label

```

</details>


### Example - Get all Mondo classes that have a gene association and it’s provenance (with aggregation)
- Prompt:
Given the query above to get all Mondo classes that have a gene association, how can we collapse the multiple rows due to multiple sources for a gene association?

- Prompt Breakdown:
Here we are extending the query from a previous query prompt. If you are using a tool like ChatGPT or Gemini it will have memory of the earlier query.


<details>
<summary>View SPARQL query</summary>

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT ?mondo_curie ?mondo_label ?gene (GROUP_CONCAT(DISTINCT ?source; separator=", ") AS ?sources)
WHERE {
  ?mondo_class rdfs:subClassOf ?restriction .
  ?restriction a owl:Restriction ;
               owl:onProperty obo:RO_0004003 ;
               owl:someValuesFrom ?gene .

  ?mondo_class rdfs:label ?mondo_label .

  OPTIONAL {
    ?axiom a owl:Axiom ;
           owl:annotatedSource ?mondo_class ;
           owl:annotatedProperty rdfs:subClassOf ;
           owl:annotatedTarget ?restriction ;
           (oboInOwl:source | oboInOwl:hasDbXref) ?source .
  }

  BIND(REPLACE(STR(?mondo_class), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?mondo_curie)
}
GROUP BY ?mondo_curie ?mondo_label ?gene
ORDER BY ?mondo_curie

```

</details>



### Example - Get all Mondo classes that have more than one gene association
- Prompt:
Write a SPARQL query to get all Mondo classes that have more than one gene association, e.g. RO:0004003 'has material basis in germline mutation in', and the source provenance. Include the Mondo CURIE, Mondo label, gene identifier, and source provenance in the result.

- Prompt Breakdown:
Type of query - select MONDO CURIE, label, gene identifier, OMIM CURIE with HAVING
Target class - any Mondo class that has more than one gene association
Axiom constraint - the class must have a gene association (RO:0004003 'has material basis in germline mutation in')
Filter - Must use RO:0004003 and have more than one someValuesFrom gene
Ontology - MONDO


<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT ?mondo_curie ?label ?gene (GROUP_CONCAT(DISTINCT ?omim_source; separator="|") AS ?sources)
WHERE {
  {
    SELECT ?mondo_class
    WHERE {
      ?mondo_class rdfs:subClassOf ?restriction .
      ?restriction a owl:Restriction ;
                   owl:onProperty obo:RO_0004003 ;
                   owl:someValuesFrom ?gene .
    }
    GROUP BY ?mondo_class
    HAVING (COUNT(DISTINCT ?gene) > 1)
  }

  ?mondo_class rdfs:label ?label ;
               rdfs:subClassOf ?restriction .

  ?restriction a owl:Restriction ;
               owl:onProperty obo:RO_0004003 ;
               owl:someValuesFrom ?gene .

  OPTIONAL {
    ?axiom a owl:Axiom ;
           owl:annotatedSource ?mondo_class ;
           owl:annotatedProperty rdfs:subClassOf ;
           owl:annotatedTarget ?restriction ;
           oboInOwl:source ?omim_source .

    FILTER(STRSTARTS(STR(?omim_source), "OMIM:"))
  }

  BIND(REPLACE(STR(?mondo_class), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?mondo_curie)
}
GROUP BY ?mondo_curie ?label ?gene
ORDER BY ?mondo_curie ?gene

```

</details>



### Example - Confirm that obsolete terms have a label that starts with “obsolete” do not have any subClassOf relationships
- Prompt:
Write a SPARQL query that checks for two quality control rules about obsolete Mondo classes: All classes marked with owl:deprecated true must have an rdfs:label that starts with the string "obsolete ". Obsolete classes must not have any logical axioms, such as rdfs:subClassOf. For each violation, the query should return the class IRI, its label, and a description of which rule was violated. 

- Prompt Breakdown:
Type of query - select
Target class - any owl:Class
Filter - include only deprecated classes
Rules - Class label must start with “obsolete” and logical axioms can not be on an obsolete class
Ontology - MONDO

NOTE: This query times out on yasgui so let's break this down into two queries, one to find any obsolete class that does not have a label that starts with 'obsolete ' and and another query to find obsolete classes with logical axioms.


<details>
<summary>View SPARQL query - Check that obsolete classes have a label that starts with 'obsolete '</summary>

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# Find obsolete classes where the label does not start with 'obsolete '

SELECT ?cls ?clsLabel ?rule WHERE {
  ?cls owl:deprecated "true"^^xsd:boolean ;
       rdfs:label ?clsLabel .
  FILTER STRSTARTS(STR(?cls), "http://purl.obolibrary.org/obo/MONDO_")
  FILTER (!STRSTARTS(STR(?clsLabel), "obsolete "))
  BIND("Label must start with 'obsolete '" AS ?rule)
}
ORDER BY ?cls


```

</details>

</br>

<details>
<summary>View SPARQL query - Check that obsolete classes do not have logical axioms</summary>

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# Check if any obsolete classes have a subClassOf axiom

SELECT ?cls ?clsLabel ?parent WHERE {
  ?cls a owl:Class ;
       owl:deprecated "true"^^xsd:boolean ;
       rdfs:label ?clsLabel ;
       rdfs:subClassOf ?parent .

  FILTER STRSTARTS(STR(?cls), "http://purl.obolibrary.org/obo/MONDO_")
  FILTER (?parent != owl:Thing)
  FILTER (?parent != ?cls)
}
ORDER BY ?cls

```

</details>




### Example - Find all classes where the definition does not have any provenance
- Prompt:
Write a SPARQL query that retrieves all Mondo classes and their definitions where the definition does not have a xref. Return the class CURIE, class label, and the definition.

- Prompt Breakdown:
Type of query - select CURIE, label, definition
Target class - any owl:Class
Filter - include only classes where the definition does not have an xref
Ontology - MONDO


<details>
<summary>View SPARQL query</summary>

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# QC - Get all classes where the definition is missing provenance

SELECT DISTINCT ?mondo_curie ?label ?definition WHERE {
  ?class a owl:Class ;
         obo:IAO_0000115 ?definition ;
         rdfs:label ?label .

  FILTER(STRSTARTS(STR(?class), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER NOT EXISTS { ?class owl:deprecated true }

  FILTER NOT EXISTS {
    ?axiom a owl:Axiom ;
           owl:annotatedSource ?class ;
           owl:annotatedProperty obo:IAO_0000115 ;
           owl:annotatedTarget ?definition ;
           oboInOwl:hasDbXref ?xref .
  }
  BIND(REPLACE(STR(?class), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?mondo_curie)
}

```

</details>


