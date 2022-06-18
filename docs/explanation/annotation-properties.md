# Contributing to ontologies: annotation properties

Editors: Sabrina Toro (@sabrinatoro), Nicolas Matentzoglu (@matentzn)  
Examples with images can be found [here](https://docs.google.com/presentation/d/1AIB7WNNkhQKzKnViJHZoNNjxZZ2Y90LuE2QqeTG1ra4/edit?usp=sharing).

## What are annotation properties?
An entity such as an individual, a class, or a property can have annotations, such as labels, synonyms and definitions. **An annotation property is used to link the entity to a value**, which in turn can be anything from a literal (a string, number, date etc) to another entity (such as, another class).  

Here are some examples of frequently used annotation properties: (every element **in bold** is an annotation property)

- http://purl.obolibrary.org/obo/MONDO_0004975
    – **rdfs:label** –> ‘Alzheimer disease’
    – **oboInOwl:hasExactSynonym** –> Alzheimer dementia
    – **oboInOwl:hasDbXref** -> `NCIT:C2866`
    - **skos:exactMatch**  -> http://www.orpha.net/ORDO/Orphanet_238616


## Some useful things to know about annotation properties

**Annotation properties have their own IRIs**, just like classes and individuals. For example, the IRI of the RDFS built in label property is http://www.w3.org/2000/01/rdf-schema#label. Other examples:

- oboInOwl:hasExactSynonym : http://www.geneontology.org/formats/oboInOwl#hasExactSynonym
- oboInOwl:hasDbXref : http://www.geneontology.org/formats/oboInOwl#hasDbXref


**Annotation properties are just like other entities (classes, individuals) and can have their own annotations.** For example, the annotation propert http://purl.obolibrary.org/obo/IAO_0000232 has an rdfs:label ('curator note') and a human readable definition (IAO:0000115): 'An administrative note of use for a curator but of no use for a user'.
 

**Annotation properties can be organised in a hierarchical structure.**

For example, the annotation property 'synonym_type_property' (http://www.geneontology.org/formats/oboInOwl#SynonymTypeProperty) is the parent property of other, more specific ones (such as "abbreviation").

**Annotation properties are (usually) used with specific type of annotation values.**

- Literal: (one can see [type: xsd:string] in the annotation)
    - xsd:string    
        - e.g. 'definition' (http://purl.obolibrary.org/obo/IAO_0000115)
    - xds:boolean  
        - e.g. 'owl:deprecated' (http://www.w3.org/2002/07/owl#deprecated)
- Entity IRI :  
    - Classes or individuals: e.g. 'has curation status' (http://purl.obolibrary.org/obo/IAO_0000114)
    - Arbitray URIs, e.g. links to website with the 'seeAlso' (http://www.w3.org/2000/01/rdf-schema#seeAlso) property
    - Or even other annotation properties `*`  
        - e.g. 'has_synonym_type' (http://www.geneontology.org/formats/oboInOwl#hasSynonymType)      
        - e.g. 'in_subset' (http://purl.obolibrary.org/obo/IAO_0000112)

Note: the type of annotation required for an annotation property can be defined by adding a Range + "select datatype" in the Annotation Property's Description  
e.g. : 'scheduled for obsoletion on or after' (http://purl.obolibrary.org/obo/IAO_0006012)

- **Annotations do not affect reasoning**. No matter what values you connect with your annotation properties, the reasoner will ignore it - even if it is nonsensical.


## Annotation Property vs Data and Object Properties

Some Annotation Properties look like data properties (connecting an entity to a literal value) and other look like object properties (connecting an entity to another entity). Other than the fact that statement involving data and object properties look very different in RDF, the key difference from a user perspective is that OWL Reasoners **entirely ignore triples involving annotation properties**. Data and Object Properties are taken into account by the reasoner.

Object properties are different to annotation properties in that they:

- connect pairs of individuals **in way that affects reasoning**
- represent relationship between classes **in way that affects reasoning**
- Example property: 'has part' (http://purl.obolibrary.org/obo/BFO_0000051)
- Object Properties can have the following property characteristics: Inverse, Symmetric, Asymmetric, Reflexive, Irreflexive, Functional, Inverse Functional, and Transitive which effect reasoning. Annotation properties cannot have such properties (or if they had, reasoners would ignore them).

Data properties are different to annotation properties in that they:

- connect individuals with literals **in way that affects reasoning**
- represent relation between a class and literal **in way that affects reasoning**
- You can use data properties to logically define OWL classes with data ranges. For example, you can define the class of `Boomer` as all people born between 1946 and 1964. If an individual would be asserted to be a Boomer, but is born earlier than 1946, the reasoner would file a complaint.
- Example Data Property: 'hasName', 'hasPrice', 'hasCalories', 'hasSugarContent',...
- More details on how to use Data Properties [here](https://oboacademy.github.io/obook/tutorial/fhkb/#data-properties-in-the-fhkb)


## Creating new Annotation Properties

Note: before creating a new annotation property, it is always a good idea to check for an existing annotation property first.   

- For example: OBO Metadata Ontology (https://www.ebi.ac.uk/ols/ontologies/omo), which could be imported  

Detailed explanations for adding a new annotation property can be found [here](https://mondo.readthedocs.io/en/latest/editors-guide/new-annotation-property/)


## The term "Annotation" in Ontologies and Data Curation means different things.

The word "annotation" is used in different contexts to mean different things. For instance, "annotation in owl" (ie annotations to an ontology term) is different from "annotation in the biocuration sense" (ie gene-to-disease, gene-to-phenotype, gene-to-function annotations). It is therefore crucial to give context when using the word "annotation". 
