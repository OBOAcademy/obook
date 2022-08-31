# Glossary of Terms

This document is a list of terms that you might encounter in the ontology world. It is not an exhaustive list and will continue to evolve. Please create a ticket if there is a term you find missing or a term you encounter that you do not understand, and we will do our best to add them. This list is not arranged in any particular order. Please use the search function to find terms.

Acknowledgement: Many terms are taken directly from [OAK documentation](https://incatools.github.io/ontology-access-kit/glossary.html) with the permission of Chris Mungall. Many descriptions are also taken from https://www.w3.org/TR/owl2-syntax/

#### Annotation
This term is frequently ambiguous. It can refer to [Text Annotation](#Text-Annotation), [OWL Annotation](#OWL Annotation), or [Association](#Association).

#### AnnotationProperty
Annotation properties are used to place annotations on individuals, class names, property names, and ontology names. They do not affect the logical definition unless they are used as a "shortcut" that a pipeline expands to a logical axiom.

#### Anonymous Ancestor
An accumulation of all of the superclasses from ancestors of a class.

#### Anonymous Individual
If an individual is not expected to be used outside an ontology, one can use an anonymous individual, which is identified by a local node ID rather than a global IRI. Anonymous individuals are analogous to blank nodes in RDF.

#### API
Application Programming Interface. An intermediary that allows two or more computer programs to communicate with each other. In ontologies, this usually means an [Endpoint](#Endpoint) in which the ontology can be programmatically accessed.

#### Application Ontology
Usually refers to a [Project Ontology](#Project Ontology).

#### Axiom
Axioms are statements that are asserted to be true in the domain being described. For example, using a subclass axiom, one can state that the class a:Student is a subclass of the class a:Person.

#### Bioportal
An [Ontology Repository](#Ontology-Repository) that is a comprehensive collection of multiple biologically relevant ontologies.

#### Concept
See [Term](#Term)

#### Controlled Vocabulary
Standardized and organized arrangements of words and phrases that provide a consistent way to describe data. A controlled vocabulary may or may not include definitions. Ontologies can be seen as a controlled vocabulary expressed in an ontological language which includes relations.

#### Class
An [Ontology elements](#Ontology-element) that formally represents something that can be instantiated. For example, the class "heart"

#### CURIE
A CURIE is a compact [URI](#URI). For example, `CL:0000001`.

#### Data Model
A representation of the structure and integrity of the data elements of the, in principle "single", specific enterprise application(s) by which it will be used.

#### Datamodel
An abstract model that organizes elements of data and standardizes how they relate to one another and to the properties of real-world entities.

#### DatatypeProperty
DatatypeProperty relate terms to literal data (e.g., strings, numbers, datetimes, etc.) as opposed to [ObjectProperty](#ObjectProperty) which relate individuals to other terms. 

#### Description Logic
Description Logic (DL) are a family of formal knowledge representation languages. It provides a logical formalism for ontologies and is what [OWL](#OWL) is based on. DL querying can be used to query ontologies in Protege.

#### Edge
[ObjectProperty](#ObjectProperty) (or relations) represented in a [graph](#Graph)

#### Edge
See [Relationship](#Relationship)

#### Endpoint
Where an [API](#API) interfaces with the ontology.

#### Existential Restriction
Existential restrictions describe classes of individuals that participate in at least one relationship along a specified property to individuals that are members of a specified class. In Protégé, the keyword 'some' is used to denote existential restrictions and is interpreted as "there exists", "there is at least one", or "some". See [documentation on classifications](../explanation/intro-to-ontologies/#an-ontology-as-a-classification) for more details.

#### Functional Syntax
The syntax in which the ontology is written - "a functional-style syntax ontology document is a sequence of Unicode characters accessible via some IRI by means of the standard protocols such that its text matches the ontologyDocument production of the grammar defined in this specification document, and it can be converted into an ontology by means of the canonical parsing process" From https://www.w3.org/TR/owl2-syntax/

#### Graph
Formally a graph is a data structure consisting of [Nodes](#Nodes) and [Edges](#Edge). There are different forms of graphs, but for the purposes of OAK, an ontology graph has all [Terms](#Term) as nodes, and relationships connecting terms (is-a, part-of) as edges. Note the concept of an ontology graph and an [RDF](#RDF) graph do not necessarily fully align - RDF graphs of OWL ontologies employ numerous blank nodes that obscure the ontology structure.

#### Individual
An [Ontology elements](#Ontology-element) that represents an instance of a class. For example, the instance "John" or "John's heart". Note that instances are not commonly represented in ontologies.

#### Information Content
A measure of how informative an ontology concept is; broader concepts are less informative as they encompass many things, whereas more specific concepts are more unique. This is usually measured as ``-log2(Pr(term))``. The method of calculating the probability varies, depending on which predicates are taken into account (for many ontologies, it makes sense to use part-of as well as is-a), and whether the probability is the probability of observing a descendant term, or of an entity annotated using that term.

#### Interface
A programmatic abstraction that allows us to focus on *what* something should do rather than *how* it is done.

#### Iterator
A programming language construct used frequently in OAK - it allows for passing of results from API calls without fetching everything in advance.

#### Jaccard Similarity
A measures of the similarity between two sets of data to see which members are shared and distinct.

#### KGCL
Knowledge Graph Change Language (KGCL) is a [Datamodel](#Datamodel) for communicating desired changes to an ontology. It can also be used to communicate differences between two ontologies. See [KGCL docs](https://github.com/INCATools/kgcl).

#### Knowledge Graph
A network of real-world entities (i.e., objects, events, situations, and concepts) that illustrates the relationships between them. Knowledge graphs (in the ontologies world) are thought of as real data built using an ontology as a framework.

#### Label
Usually refers to a human-readable label corresponding to the `rdfs:label` [predicate](#predicate). Labels are typically unique per ontology. In OBO Format and in the bio-ontology literature, labels are sometimes called [Names](#Name). Sometimes in the machine learning literature, and in databases such as Neo4J, "label" actually refers to a [Category](#Category).

#### Mapping
See [SSSOM]('SSSOM')

#### Materialised
The process of calculating the implicit statements in an ontology - making inferred axioms explicit by asserting them.

#### Name
Usually synonymous with [Label](#Label), but in the formal logic and OWL community, "Name" sometimes denotes an [Identifier](#Identifier)

#### Named Individual
An [Individual](#Individual) that is given an explicit name that can be used in any ontology to refer to the same object.

#### Nodes
[Terms](#Term) represented in a [graph](#Graph)

#### Object
The "right" side of a [Triple](#Triple).

#### ObjectProperty
A simple association between two terms, also see [predicate](#predicate) & [Relationship](#Relationship). 

#### OBO
Open Biological and Biomedical Ontology. This could refer to the [OBO Foundry](https://obofoundry.org/) (e.g. OBO ontologies = ontologies that follow the standards of the OBO Foundry) or the [Functional Syntax](#Function-Syntax)/file format that some ontologies use.

#### OBO Format
A serialization format for ontologies designed for easy viewing, direct editing, and readable diffs. It is popular in bioinformatics, but not widely used or known outside the genomics sphere. OBO is mapped to OWL, but only expresses a subset, and provides some OWL abstractions in a more easy to understand fashion.

#### OLS
Ontology Lookup Service. An [Ontology Repository](#Ontology-Repository) that is a curated collection of multiple biologically relevant ontologies, many from [OBO](#OBO). OLS can be accessed with this [link](https://www.ebi.ac.uk/ols/index)

#### Ontology
A flexible concept loosely encompassing any collection of [Ontology elements](#Ontology-element) and statements or relationships connecting them.

#### Ontology element
A discrete part of an [Ontology](#Ontology), with a unique persistent identifier. The most important elements are [Terms](#Term) but other elements can include various metadata artefacts like [Annotation Properties](#Annotation-Property) or [Subsets](#Subset)

#### Ontology Library
The systems or platform where various types of ontologies are stored from different sources and provide the ability to data providers and application developers to share and reuse the ontologies.

#### Ontology Repository 
A curated collection of ontologies.

#### OWL
An ontology language that uses constructs from [Description Logic](#Description-Logic). OWL is not itself an ontology format, it can be serialized through different formats such as [Functional Syntax](#Functional-Syntax), and it can be mapped to :[RDF](#RDF) and serialized via an RDF format.

#### OWL Annotation
In the context of [OWL](#OWL), the term [Annotation](#Annotation) means a piece of metadata that does not have a strict logical interpretation. Annotations can be on entities, for example, [Label](#Label) annotations, or annotations can be on [Axioms](#Axiom).

#### Predicate
An [Ontology elements](#Ontology-element) that represents the type of a [Relationship](#Relationship).
Typically corresponds to an [ObjectProperty](#ObjectProperty) in [OWL](#OWL), but this is not always true;
in particular, the is-a relationship type is a builtin construct `SubClassOf` in OWL
Examples:
 * is-a
 * part-of (BFO:0000050)
 
#### Project Ontology
An ontology that is specific to a project and does not necessarily have interoperability with other ontologies in mind. 

#### Pronto
An [Ontology Library](#Ontology-Library) for parsing obo and owl files

#### Property
An [Ontology elements](#Ontology-element) that represents an attribute or a characteristic of an element.
In [OWL](#OWL), properties are divided into disjoint categories:
  * [ObjectProperty](#ObjectProperty)
  * [AnnotationProperty](#AnnotationProperty)
  * [DatatypeProperty](#DatatypeProperty)
  
#### RDF
A datamodel consisting of simple [Subject](#Subject) [predicate](#predicate) [Object](#Object) [Triples](#Triple) organized into an RDF [Graph](#Graph).

#### Reasoner
An ontology tool that will perform inference over an ontology to yield new *axioms* (e.g. new [Edges](#Edge)) or to determine if an ontology is logically coherent.

#### Relationship
A [Relationship](#Relationship) is a type connection between two ontology elements. The first element is called the [subject](#Subject), and the second one the [Object](#Object), with the type of connection being the [Relationship Type](#Relationship-Type). Sometimes Relationships are equated with [Triples](#Triple) in [RDF](#RDF) but this can be confusing, because some relationships map to *multiple* triples when following the OWL RDF serialization. An example is the relationship "finger part-of hand", which in OWL is represented using a [Existential Restriction](#Existential-Restriction) that maps to 4 triples.

#### Relationship Type
See [predicate](#predicate)  

#### Semantic Similarity
A means of measuring similarity between either pairs of ontology concepts, or between entities annotated using ontology concepts. There is a wide variety of different methods for calculating semantic similarity, for example [Jaccard Similarity](#Jaccard-Similarity) and [Information Content](#Information-Content) based measures.

#### Semantic SQL
Semantic SQL is a proposed standardized schema for representing any RDF/OWL ontology, plus a set of tools for building a database conforming to this schema from RDF/OWL files. See [Semantic-SQL](https://github.com/INCATools/semantic-sql)

#### SPARQL
The standard query language and protocol for Linked Open Data on the web or for RDF [triplestores](#Triplestore) - used to query ontologies.

#### SSSOM
Simple Standard for Sharing Ontological Mappings. 

#### Subject
The "left" side of a [Triple](#Triple).

#### Subset
An [Ontology elements](#Ontology-element) that represents a named collection of elements, typically grouped for some purpose

#### Term
A core element in an ontology, typically a [Class](#Class), but sometimes used to include instances or relationship types, depending on context.

#### Text Annotation
The process of annotating spans of texts within a text document with references to ontology terms, or the result of this process. This is frequently done automatically. The [Bioportal](#Bioportal) implementation provides text annotation services.

#### Triple
A set of three entities that codifies a statement about semantic data in the form of [Subject](#Subject)-[predicate](#predicate)-[Object](#Object) expressions (e.g., "Bob is 35", or "Bob knows John").

#### Triple
See [Relationship](#Relationship)

#### Triplestore
A purpose-built database for the storage and retrieval of triples through semantic queries. A triple is a data entity composed of subject–predicate–object, like "Bob is 35" or "Bob knows Fred".

#### Ubergraph
A [Triplestore](#Triplestore) and a [Ontology Repository](#Ontology-Repository) that allows for [SPARQL](#SPARQL) querying of integrated [OBO](#OBO) ontologies.

#### URI
A Uniform Resource Indicator, a generalization of URL. Most people think of URLs as being solely for addresses for web pages (or APIs) but in semantic web technologies, URLs can serve as actual identifiers for entities like ontology terms. Data models like [OWL](#OWL) and [RDF](#RDF) use URIs as identifiers. In OAK, URIs are mapped to [CURIE](#CURIE)