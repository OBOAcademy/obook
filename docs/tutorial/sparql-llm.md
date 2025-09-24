# Generating SPARQL queries using Large Language Models (LLMs)

This tutorial will teach you how to create SPARQL queries by prompting a large language model (LLM) via a chat interface. You may use whichever system you prefer, such as [ChatGPT](https://chatgpt.com/), [Gemini](https://gemini.google.com/), [Claude](https://www.anthropic.com/claude-code), etc. The prompts in this tutorial have been tested with ChatGPT 4o and Gemini 2.5 Pro.


## Preparation

The resulting SPARQL queries can be tested using https://yasgui.triply.cc/# (endpoint https://ubergraph.apps.renci.org/sparql) or using the [ROBOT query](https://robot.obolibrary.org/query) functionality. You are responsible for obtaining access to yasgui and/or installing ROBOT.


## Learning Objectives

- Explain what SPARQL is and describe the types queries, e.g. SELECT, INSERT, DELETE, that can be used with ontologies.
- Identify and provide key prompt setup information to guide LLMs toward generating accurate SPARQL queries in chat interfaces.
- Create effective natural language prompts for large language models (via chat interfaces) to generate valid SPARQL queries.
- Design advanced prompts that incorporate ontology-specific features—such as axiom reification, source provenance, and IRI or synonym constraints—to guide LLMs in producing accurate and semantically rich queries.
- Interpret and debug the SPARQL queries produced by LLMs — recognizing things like CURIEs vs IRIs, missing filters, or extraneous results.
- Run queries e.g., on Ubergraph or similar endpoints, considering things like performance, excessive results, and correctness.
- Evaluate prompt‑engineering best practices to get consistent query outputs.


## SPARQL Refresher
### What is SPARQL?

- SPARQL (pronounced 'sparkle') is a language to query ontologies
- A query can consist of:
    - Triple patterns (subject-predicate-object), e.g. an entity is an OWL class 
      ```
      ?entity a owl:Class .
      ```
    - Conjunctions (multiple triple patterns that must match in order to return a result), e.g. Find all entities that are subclasses of MONDO:0000001 'disease' AND have a label. Both conditions must be true for the same entity.
      ```
      ?entity rdfs:subClassOf* MONDO:0000001 .
      ?entity rdfs:label ?label .
      ```
    - Disjunctions (match either one triple pattern OR another), e.g. Find the label whether it's defined with either `rdfs:label` or `skos:prefLabel`
      ```
      { ?entity rdfs:label ?label . }
      UNION
      { ? entity skos:prefLabel ?label . }
      ```
    - Optional patterns (include extra information when available), e.g. Find all subclasses of MONDO:0000001 'disease'. If a label exists, include it, but don’t exclude entities without a label.
      ```
      ?class rdfs:subClassOf* obo:MONDO_0000001 .
      OPTIONAL { ?class rdfs:label ?label }
      ```
- SPARQL can be used to query class hierarchies, annotation properties, e.g. labels, definitions, database cross reference, and logical class definitions
- For more details, review Basic SPARQL for OBO Engineers <a href="https://oboacademy.github.io/obook/tutorial/sparql/" target="_blank">https://oboacademy.github.io/obook/tutorial/sparql/</a>


### SPARQL Query Operations

- SPARQL operators
    - SELECT - retrieve specific data from an ontology, e.g. terms, labels, database cross references, hierarchy relationships, etc.
    - INSERT - add information into the ontology
    - DELETE - remove information from the ontology
- SPARQL modifiers
    - ORDER BY - sorts results
    - LIMIT - max rows
    - OFFSET - skip rows
    - DISTINCT - remove duplicate query results
    - GROUP BY and HAVING - aggregate data
- FILTER - restrict results based on expressions
    - Examples: Filter out obsolete terms, Filter to keep only terms with MONDO identifier


### SPARQL Query Structure
![Basic SPARQL Query](../images/tutorials/sparql-llm/basic_sparql_query-no-title.png)

- Prefix declarations: Declares namespace abbreviations to shorten URIs (e.g., owl:, rdfs:)

- Select clause: Specifies the variables to be returned: `?entity` and `?label`

- Where clause:	Defines the pattern of RDF triples to match.
    - The triple pattern `?entity a owl:Class` means match entities that are OWL classes.
    - The triple pattern `?entity rdfs:label ?label` means match entities that have a `rdfs:label`.

- Filters
    - `FILTER (STRSTARTS(STR(?entity), "http://purl.obolibrary.org/obo/MONDO_"))`: Limits results to MONDO classes
    - `FILTER NOT EXISTS { ?entity owl:deprecated true }`: Excludes obsolete classes
    - `LIMIT 10`: Return at most 10 results 


### Tools to run SPARQL queries

- ROBOT 
    - A command line tool for working with OBO ontologies and has a query command <a href="https://robot.obolibrary.org/query" target="_blank">https://robot.obolibrary.org/query</a>
- RENCI Ubergraph endpoint
    - Web based interface to query OBO ontologies <a href="https://yasgui.triply.cc/#" target="_blank">https://yasgui.triply.cc/#</a>


### SPARQL Use Cases

- Create a custom report
    - How many disease classes are in Mondo? 
    - How many Mondo classes have a gene association?
    - See Mondo stats for more statistics <a href="https://mondo.monarchinitiative.org/#stats" target="_blank">https://mondo.monarchinitiative.org/#stats</a>
- Ontology QC and modeling validation
    - Do all synonyms contain a database cross reference?
- Insert and update an ontology
    - Many Mondo pipelines use SPARQL update queries, e.g. OMIM gene pipeline, to add content into the ontology


## What are Large Language Models
- Large Language Models (LLMs) are AI systems trained on massive text corpora to understand and generate human language
- Understand and generate text and code
    - Examples: ChatGPT, Claude, Gemini
- Interact using natural language prompts, not programming


### What Can LLMs Do?

LLMs can interpret and generate:

- Text summaries, explanations, and rewrite content
- Data transformations and format conversions
- Generate code


### Why Large Language Models (LLMs) matter for querying ontologies

<table style="border: none; border-collapse: collapse; margin-top: 0; padding-top: 0;">
  <tr>
    <td style="border: none; vertical-align: top; width: 50%; padding: 0; font-size: .8rem;">
      <strong>Problems:</strong>
      <ul>
        <li>Natural language is intuitive, but not machine-readable</li>
        <li>Ontology queries (SPARQL) are precise, but hard to write and take time to learn</li>
      </ul>
    </td>
    <td style="border: none; vertical-align: top; width: 50%; padding: 0 0 0 1.5rem; font-size: .8rem;">
      <strong>LLMs can:</strong>
      <ul>
        <li>Translate natural language questions into SPARQL queries</li>
        <li>Lower the barrier of entry to writing SPARQL queries and extracting ontology information</li>
      </ul>
    </td>
  </tr>
</table>


## Prompting LLMs via Chat Interfaces for SPARQL Queries

- Be specific and state the question cleary
    - Not great: “Find all diseases.”
    - Better: “List all subclasses of MONDO:0700096 ‘human disease’ in MONDO, including the class labels and definitions.”
- Include example data in the prompt
    - Share prefixes or example IRIs/CURIEs
    - Use the real IRI/CURIE or name of a property 
    - Provide an OBO stanza or for more complicated queries the OWL class representation
- State what properties to return 
    - Select the CURIE, label, and definition
- State modifiers and constraints
    - Limit to 10 results, sort by label
    - Filter out obsolete terms
- Share an example query to extend
    - Use base query and ask LLM to extend 
- Ask for explanations 
    - Prompt for query and also ask for a step-wise explanation of the query
- Review query, test, and iterate
    - Test the query in your tool of interest
    - If query fails or returns incorrect information, share the error message and ask for a fix or clarify what’s missing
    - Some SPARQL constructs are not valid for ROBOT and the query needs to be modified
    - If the LLM starts returning circular options ask it to reset to clear the current conversation context


### Prompt Setup for Chat-Based LLMs

- Information to include at the start of your chat session to guide the LLM throughout your prompts 
- This information will be remembered by the model throughout the chat session (limited by model, chat length, and chat settings)
    - ChatGPT - session memory is enabled by default
    - Gemini -  iterative conversation history
    - Claude - selective session memory
- The information should be clear and specific to guide the LLM toward the desired output
- For best results, it is a good practice to set a persona, provide examples, and structure the information clearly

<details>
<summary>Prompt Setup</summary>
```
Role: Act as an ontology engineer with expert knowledge of SPARQL and MONDO.

Environment: Queries will be run in YASGUI against MONDO (OWL) and should also run via ROBOT.

Namespace scope: By default, restrict results to MONDO classes:
    FILTER STRSTARTS(STR(?class), "http://purl.obolibrary.org/obo/MONDO_")

Reasoning: Assume no entailment; use explicit patterns and property paths (e.g., rdfs:subClassOf*).

Obsoletes: Exclude classes with owl:deprecated true.

Labels: Use `rdfs:label`.

Prefixes: Include only the PREFIX declarations actually used in the query (no extras).
  These are the main prefixes we will need: 
    Core RDF/OWL
      rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      owl: <http://www.w3.org/2002/07/owl#>
      xsd: <http://www.w3.org/2001/XMLSchema#>
    MONDO
      MONDO: <http://purl.obolibrary.org/obo/MONDO_>
    Common OBO namespaces
      RO: <http://purl.obolibrary.org/obo/RO_>
      IAO: <http://purl.obolibrary.org/obo/IAO_>
      oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

Axiom-annotated data (synonyms, database cross references (also known as xrefs), provenance):
  When querying properties that are commonly axiom-annotated (e.g., oboInOwl:hasExactSynonym),
    1) Assert the base triple:
       ?class oboInOwl:hasExactSynonym ?syn .
    2) Tie the reified axiom back to that exact triple:
       ?axiom a owl:Axiom ;
              owl:annotatedSource ?class ;
              owl:annotatedProperty oboInOwl:hasExactSynonym ;
              owl:annotatedTarget ?syn .
    3) Add any desired axiom annotations (e.g., oboInOwl:hasDbXref ?xref).

Output rules:
  * Return paste-ready SPARQL in a single code block.
  * Use DISTINCT when appropriate (e.g., in COUNTs).
  * If a list of results is requested, include the `?label` and convert the IRI to a CURIE

Request format: 
  * I will provide prompts in plain English.
  * Respond only with the SPARQL query (and a one-line explanation if needed).

Defaults (unless I override in the prompt): 
  * Consider all descendants (rdfs:subClassOf*), not just direct children.
  * Filter out obsoletes as above.
  * Keep results sorted using ORDER BY unless I request otherwise.

```
</details>


## Example LLM prompts 
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

