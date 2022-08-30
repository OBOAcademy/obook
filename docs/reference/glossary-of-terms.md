# Glossary of Terms

This document is a list of terms that you might encounter in the ontology world. It is not an exhaustive list and will continue grow and evolve. Please do create a ticket if there is a term you find missing here, or a term that you encounter that you do not understand, and we will do our best to add them in here. This list is not arranged in any particular order, please use the search function to find needed term.

Acknowledgement: Many terms are taken directly from [OAK documentation](https://incatools.github.io/ontology-access-kit/glossary.html) with the permission of Chris Mungall.

#### Ontology
A flexible concept loosely encompassing any collection of [Ontology elements](#Ontology-element) and statements or relationships connecting them.

#### Knowledge Graph
A network of real-world entities—i.e. objects, events, situations, or concepts—and illustrates the relationship between them. Knowledge graphs (in the ontologies world) are thought of as real data built using an ontology as a framework.

#### Controlled Vocabulary
A standardized and organized arrangements of words and phrases and provide a consistent way to describe data. A controlled vocabulary may have no meaning specified (just a set of terms people agree on), or may also have detailed definitions. Ontologies can be seen as a controlled vocabulary expressed in an ontological language which includes relations. 

#### Data Model


#### Ontology element
A discrete part of an [Ontology](#Ontology), with a unique persistent identifier. The most important elements are [Terms](#Term) but other elements can include various metadata artefacts like [Annotation Properties](#Annotation-Property) or [Subsets](#Subset)

#### Term
A core element in an ontology, typically a [Class](#Class), but sometimes used to include instances or relationship types, depending on context.

#### Concept
See [Term](#Term)

#### CURIE
A CURIE is a compact [URI](#URI). For example, `CL:0000001`.

#### URI
A Uniform Resource Indicator, a generalization of URL. Most people think of URLs as being solely for addresses for web pages (or APIs) but in semantic web technologies, URLs can serve as actual identifiers for entities like ontology terms. Data models like [OWL](#OWL) and [RDF](#RDF) use URIs as identifiers. In OAK, URIs are mapped to [CURIE](#CURIE)

#### Label
Usually refers to a human-readable label corresponding to the `rdfs:label` [predicate](#predicate). Labels are typically unique per ontology. In OBO Format and in the bio-ontology literature, labels are sometimes called [Names](#Name). Sometimes in the machine learning literature, and in databases such as Neo4J, "label" actually refers to a [Category](#Category).

#### Name
Usually synonymous with [Label](#Label), but in the formal logic and OWL community, "Name" sometimes denotes an [Identifier](#Identifier)

#### Class
An [Ontology elements](#Ontology-element) that formally represents something that can be instantiated. For example, the class "heart"

#### Annotation
This term is frequently ambiguous. It can refer to [Text Annotation](#Text-Annotation), [OWL Annotation](#OWL Annotation), or [Association](#Association).

#### Text Annotation
The process of annotating spans of texts within a text document with references to ontology terms, or the result of this process. This is frequently done automatically. The [Bioportal](#Bioportal) implementation provides text annotation services.

#### Mapping
See [SSSOM]('SSSOM')

#### SSSOM
Simple Standard for Sharing Ontological Mappings. 

#### Graph
Formally a graph is a data structure consisting of [Nodes](#Nodes) and [Edges](#Edge). There are different forms of graphs, but for the purposes of OAK, an ontology graph has all [Terms](#Term) as nodes, and relationships connecting terms (is-a, part-of) as edges. Note the concept of an ontology graph and an [RDF](#RDF) graph do not necessarily fully align - RDF graphs of OWL ontologies employ numerous blank nodes that obscure the ontology structure.

#### Nodes

#### Edge

#### Triple

#### OWL
An ontology language that uses constructs from [Description Logic](#Description-Logic). OWL is not itself an ontology format, it can be serialized through different formats such as [Functional Syntax](#Functional-Syntax), and it can be mapped to :[RDF](#RDF) and serialized via an RDF format.

#### Description Logic

#### Functional Syntax

#### RDF
A datamodel consisting of simple [Subject](#Subject) [predicate](#predicate) [Object](#Object) [Triples](#Triple) organized into an RDF [Graph](#Graph)

#### Subject

#### Object

#### OBO Format
A serialization format for ontologies designed for easy viewing, direct editing, and readable diffs. It is popular in bioinformatics, but not widely used or known outside the genomics sphere. OBO is mapped to OWL, but only expresses a subset, and provides some OWL abstractions in a more easy to understand fashion.

#### KGCL
Knowledge Graph Change Language (KGCL) is a [Datamodel](#Datamodel) for communicating desired changes to an ontology. It can also be used to communicate differences between two ontologies. See [KGCL docs](https://github.com/INCATools/kgcl).

#### OWL Annotation
In the context of [OWL](#OWL), the term [Annotation](#Annotation) means a piece of metadata that does not have a strict logical interpretation. Annotations can be on entities, for example, [Label](#Label) annotations, or annotations can be on [Axioms](#Axiom).

#### Axiom

#### Pronto
An [Ontology Library](#Ontology-Library) for parsing obo and owl files

#### Ontology Library

#### Iterator
A programming language construct used frequently in OAK - it allows for passing of results from API calls without fetching everything in advance.

#### Interface
A programmatic abstraction that allows us to focus on *what* something should do rather than *how* it is done.

#### Implementation

#### Datamodel

#### Individual

#### Named Individual
An [Ontology elements](#Ontology-element) that represents an instance of a class. For example, the instance "John" or "John's heart". Note that instances are not commonly represented in ontologies.

#### Anonymous Individual

#### Property
An [Ontology elements](#Ontology-element) that represents an attribute or a characteristic of an element.
In [OWL](#OWL), properties are divided into disjoint categories:
  * [ObjectProperty](#ObjectProperty)
  * [AnnotationProperty](#AnnotationProperty)
  * [DatatypeProperty](#DatatypeProperty)

#### ObjectProperty

#### AnnotationProperty

#### DatatypeProperty

#### Edge
See [Relationship](#Relationship)

#### Triple
See [Relationship](#Relationship)

#### Relationship
A [Relationship](#Relationship) is a type connection between two ontology elements. The first element is called the [subject](#Subject), and the second one the [Object](#Object), with the type of connection being the [Relationship Type](#Relationship-Type). Sometimes Relationships are equated with [Triples](#Triple) in [RDF](#RDF) but this can be confusing, because some relationships map to *multiple* triples when following the OWL RDF serialization. An example is the relationship "finger part-of hand", which in OWL is represented using a [Existential Restriction](#Existential-Restriction) that maps to 4 triples.

#### Existential Restriction

#### Relationship Type
See [predicate](#predicate)

#### Predicate
An [Ontology elements](#Ontology-element) that represents the type of a [Relationship](#Relationship).
Typically corresponds to an [ObjectProperty](#ObjectProperty) in [OWL](#OWL), but this is not always true;
in particular, the is-a relationship type is a builtin construct `SubClassOf` in OWL
Examples:
 * is-a
 * part-of (BFO:0000050)


#### Subset
An [Ontology elements](#Ontology-element) that represents a named collection of elements, typically grouped for some purpose

#### Reasoner
An ontology tool that will perform inference over an ontology to yield new *axioms* (e.g. new [Edges](#Edge)) or to determine if an ontology is logically coherent.

#### Bioportal
An [Ontology Repository](#Ontology-Repository) that is a comprehensive collection of multiple biologically relevant ontologies.

#### Ontology Repository 

#### OLS
Ontology Lookup Service. An [Ontology Repository](#Ontology-Repository) that is a curated collection of multiple biologically relevant ontologies, many from [OBO](#OBO). OLS can be accessed with this [link](https://www.ebi.ac.uk/ols/index)

#### Endpoint


#### API
Application Programming Interface. An intermediary that allows two or more computer programs to communicate with each other. In ontologies, this usually means an [Endpoint](#Endpoint) in which the ontology can be programmatically accessed.

#### OBO

#### Ubergraph
A [Triplestore](#Triplestore) and a [Ontology Repository](#Ontology-Repository) that allows for [SPARQL](#SPARQL) querying of integrated [OBO](#OBO) ontologies.
Accessible via AK Ubergraph [Implementation](#Implementation)

#### Triplestore
A purpose-built database for the storage and retrieval of triples through semantic queries. A triple is a data entity composed of subject–predicate–object, like "Bob is 35" or "Bob knows Fred".

#### SPARQL
The standard query language and protocol for Linked Open Data on the web or for RDF [triplestores](#Triplestore) - used to query ontologies.

#### Semantic SQL
Semantic SQL is a proposed standardized schema for representing any RDF/OWL ontology, plus a set of tools for building a database conforming to this schema from RDF/OWL files. See [Semantic-SQL](https://github.com/INCATools/semantic-sql)

#### Semantic Similarity
A means of measuring similarity between either pairs of ontology concepts, or between entities annotated using ontology concepts. There is a wide variety of different methods for calculating semantic similarity, for example [Jaccard Similarity](#Jaccard-Similarity) and [Information Content](#Information-Content) based measures.

#### Jaccard Similarity


#### Information Content
A measure of how informative an ontology concept is; broader concepts are less informative as they encompass many things, whereas more specific concepts are more unique. This is usually measured as ``-log2(Pr(term))``. The method of calculating the probability varies, depending on which predicates are taken into account (for many ontologies, it makes sense to use part-of as well as is-a), and whether the probability is the probability of observing a descendant term, or of an entity annotated using that term.

#### Anonymous Ancestor

#### Materialised
