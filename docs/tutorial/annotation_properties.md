# Contributing to ontologies: annotation properties

Editors: Sabrina Toro (@sabrinatoro), Nicolas Matentzoglu (@matentzn)
Examples with images can be found [here](https://docs.google.com/presentation/d/1AIB7WNNkhQKzKnViJHZoNNjxZZ2Y90LuE2QqeTG1ra4/edit?usp=sharing).

## What are annotation properties? 
An entity such as an individual, a class, or a property can have annotations. **Annotation property defines the type of annotation and is used to link the entity to a value**, which in turn can be anything from a literal (a string, number, date etc) to another entity.

Example: everything **in bold** is an annotation property
http://purl.obolibrary.org/obo/MONDO_0004975 
– **rdfs:label** – ‘Alzheimer disease’     
– **has_exact_synonym** – Alzheimer dementia 
– **database_cross_reference** - NCITC2866

## Annotation Properties facts
- **Annotation properties have their own IDs**
Examples: 
  - rdfs:label : http://www.w3.org/2000/01/rdf-schema#label
  - has_exact_synonym : http://www.geneontology.org/formats/oboInOwl#hasExactSynonym
  - database_cross_reference : http://www.geneontology.org/formats/oboInOwl#hasDbXref

- **Annotation properties can have their own annotations** 
Examples: http://purl.obolibrary.org/obo/IAO_0000232
  - rdfs:label : 'curator note'
  - definition : 'An administrative note of use for a curator but of no use for a user'
  - ...

- **Annotation properties can include hierarchical structure**
Example: 'synonym_type_property' (http://www.geneontology.org/formats/oboInOwl#SynonymTypeProperty)


- **Annotation properties are used with specific type of annotations**
  - Literal: (one can see [type: xsd:string] in the annotation)
    - String 
      e.g. 'definition' (http://purl.obolibrary.org/obo/IAO_0000115)
    - boolean 
      e.g. 'owl.deprecated' (http://www.w3.org/2002/07/owl#deprecated)
  - Entity IRI - another annotation property: 
      e.g. 'has curation status' (http://purl.obolibrary.org/obo/IAO_0000114)
  - IRI editor :
      e.g. 'seeAlso' (http://www.w3.org/2000/01/rdf-schema#seeAlso)
  - A Property value 
      e.g. 'has_synonym_type' (http://www.geneontology.org/formats/oboInOwl#hasSynonymType)
      e.g. 'in_subset' (http://purl.obolibrary.org/obo/IAO_0000112)
  
note: the type of annotation required for an annotation property can be defined by adding a Range + "select datatype" in the Annotation Property's Description
  e.g. : 'scheduled for obsoletion on or after' (http://purl.obolibrary.org/obo/IAO_0006012)
  
## Annotation Property is NOT:
- **Object properties** (blue in protege)
  - connect pairs of individuals 
  - represent relationship between classes
  - E.g.: Object Property: 'has part' (http://purl.obolibrary.org/obo/BFO_0000051)
  - Object Properties have the following property characteristics: Inverse, Symmetric, Asymmetric, Reflexive, Irreflexive, Functional, Inverse Functional, and Transitive.

- **Data Properties** (green in protege)
  - connect individuals with literals
  - represent relation between a class and literal
  - also called “attributes”
  - E.g.: Data Property: 'hasName', 'hasPrice', 'hasCalories', 'hasSugarContent',...


## Creating new Annotation Properties

Note: before creating a new annotation property, it is always a good idea to check for an existing annotation property first. For example: OBO Metadata Ontology (https://www.ebi.ac.uk/ols/ontologies/omo), which could be imported

Detailed explanations for adding a new annotation property can be found [here](https://mondo.readthedocs.io/en/latest/editors-guide/new-annotation-property/)



