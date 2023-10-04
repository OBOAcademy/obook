# Glossary of Terms

This document is a list of terms that you might encounter in the ontology world. It is not an exhaustive list and will continue to evolve. Please create a ticket if there is a term you find missing or a term you encounter that you do not understand, and we will do our best to add them. This list is not arranged in any particular order. Please use the search function to find terms.

Acknowledgement: Many terms are taken directly from [OAK documentation](https://incatools.github.io/ontology-access-kit/glossary.html) with the permission of [Chris Mungall](https://orcid.org/0000-0002-6601-2165). Many descriptions are also taken from https://www.w3.org/TR/owl2-syntax/.

#### Annotation

This term is frequently ambiguous. It can refer to [Text Annotation](#Text-Annotation), [OWL Annotation](#OWL-Annotation), or Association.

#### AnnotationProperty

Annotation properties are [OWL](#OWL) [axioms](#Axiom) that are used to place annotations on individuals, class names, property names, and ontology names. They do not affect the logical definition unless they are used as a "shortcut" that a pipeline expands to a logical axiom.

#### Anonymous Ancestor

An accumulation of all of the superclasses from ancestors of a class.

#### Anonymous Individual

If an [individual](#Individual) is not expected to be used outside an ontology, one can use an anonymous individual, which is identified by a local node ID rather than a global IRI. Anonymous individuals are analogous to blank nodes in RDF.

#### API

Application Programming Interface. An intermediary that allows two or more computer programs to communicate with each other. In ontologies, this usually means an [Endpoint](#Endpoint) in which the ontology can be programmatically accessed.

#### Application Ontology

Usually refers to a [Project Ontology](#Project-Ontology).

#### Axiom

Axioms are statements that are asserted to be true in the domain being described. For example, using a subclass axiom, one can state that the class a:Student is a subclass of the class a:Person. (Note: in OWL, there are also annotation axioms which does not apply any logical descriptions)

#### Bioportal

An [Ontology Repository](#Ontology-Repository) that is a comprehensive collection of multiple biologically relevant ontologies.

#### Controlled Vocabulary

Standardized and organized arrangements of words and phrases that provide a consistent way to describe data. A controlled vocabulary may or may not include definitions. Ontologies can be seen as a controlled vocabulary expressed in an ontological language which includes relations.

#### Class

An [OWL entity](#OWL-entity) that formally represents something that can be instantiated. For example, the class "heart".

#### CURIE

A CURIE is a compact [URI](#URI). For example, `CL:0000001` expands to http://purl.obolibrary.org/obo/CL_0000001. For more information, please see https://www.w3.org/TR/curie/. 

### `curies`

[`curies`](https://github.com/cthoyt/curies/) is a Python package for working with [prefix maps](#Prefix-Map) and 
[extended prefix maps](#Extended-Prefix-Map) and converting between [CURIEs](#CURIE) and [URIs](#URI).

#### Data Model

An abstract model that organizes elements of data and standardizes how they relate to one another.

#### dataProperty

dataProperty relate [OWL entities](#OWL-entity) to literal data (e.g., strings, numbers, datetimes, etc.) as opposed to [ObjectProperty](#ObjectProperty) which relate individuals to other [OWL entities](#OWL-entity). Unlike [AnnotationProperty](#AnnotationProperty), dataProperty axioms fall on the logical side of [OWL](#OWL) and are hence useable by reasoners.

#### Datatype

Datatypes are [OWL entities](#OWL-entity) that refer to sets of data values. Thus, datatypes are analogous to [classes](#Class), the main difference being that the former contain data values such as strings and numbers, rather than individuals. Datatypes are a kind of data range, which allows them to be used in restrictions. For example, the datatype xsd:integer denotes the set of all integers, and can be used with the [range](#Range) of a [dataProperty](#dataProperty) to state that the range of said dataProperty must be an integer. 

#### Description Logic

Description Logics (DL) are a family of formal knowledge representation languages. It provides a logical formalism for ontologies and is what [OWL](#OWL) is based on. DL querying can be used to query ontologies in Protege.

#### Domain

Domain, in reference to a [dataProperty](#dataProperty) or [ObjectProperty](#ObjectProperty), refers to the restriction on the [subject](#Subject) of a [triple](#Triple) - if a given property has a given [class](#Class) in its domain this means that any individual that has a value for the property, will be inferred to be an instance of that domain class. For example, if `John hasParent Mary` and `Person` is listed in the domain of `hasParent`, then `John` will be inferred to be an instance of `Person`. 

#### DOSDP

[Dead Simple Ontology Design Patterns](http://incatools.github.io/dead_simple_owl_design_patterns/). A templating system for ontologies with well-documented patterns and templates.

#### Edge

A typed, directed link between [Nodes](#Nodes) in a [knowledge graph](#Knowledge-Graph). Translations of OWL into Knowledge graphs vary, but typically edges are generated for simple triples, relating two individuals or two classes via an [AnnotationProperty](#AnnotationProperty) or [ObjectProperty](#ObjectProperty) and simple [existential restrictions](#Existential-Restriction) (A SubClassOf R some B), with the edge type corresponding to the property.

#### Endpoint

Where an [API](#API) interfaces with the ontology.

#### Existential Restriction

A relationship between two classes, A R (some) B, that states that all individuals of class A stand in relation R to at least one individual of class B. For example, `neuron has_part some dendrite` states that all instances of neuron have at least one individual of type dentrite as a part. In Manchester syntax, the keyword 'some' is used to denote existential restrictions and is interpreted as "there exists", "there is at least one", or "some". See [documentation on classifications](../explanation/intro-to-ontologies/#an-ontology-as-a-classification) for more details.

#### Extended Prefix Map

Extended prefix maps (EPMs) address the limitations in expressiveness of [prefix maps](#Prefix-Map) by including
explicit fields for CURIE prefix synonyms and URI prefix synonyms in addition to explicit fields for the preferred
CURIE prefix and URI prefix. An abbreviated example (just containing an entry for ChEBI) looks like:

```json
[
    {
        "prefix": "CHEBI",
        "uri_prefix": "http://purl.obolibrary.org/obo/CHEBI_",
        "prefix_synonyms": ["chebi"],
        "uri_prefix_synonyms": [
            "https://identifiers.org/chebi:"
        ]
    }
]
```

#### Functional Syntax

An official syntax of OWL (others are RDF-XML and OWL-XML) in which each line represents and axiom (although things get a little more complex with axiom annotations, and axioms use prefix syntax (order = relation (subject, object)). This is in contrast to in-fix syntax (e.g. Manchester syntax) (order = subject relation object). Functional syntax is the preferred syntax for editor files maintained on GitHub, because it can be safely diff'd and (somewhat) human readable.

#### Graph

Formally a graph is a data structure consisting of [Nodes](#Nodes) and [Edges](#Edge). There are different forms of graphs, but for our purposes an ontology graph has all [Terms](#Term) as nodes, and relationships connecting terms (is-a, part-of) as edges. Note the concept of an ontology graph and an [RDF](#RDF) graph do not necessarily fully align - RDF graphs of OWL ontologies employ numerous blank nodes that obscure the ontology structure.

#### Individual

An [OWL entity](#OWL-entity) that represents an instance of a class. For example, the instance "John" or "John's heart". Note that instances are not commonly represented in ontologies. For instance, "John" (an instance of person) or "John's heart" (an instance of heart).

#### Information Content

A measure of how informative an ontology concept is; broader concepts are less informative as they encompass many things, whereas more specific concepts are more unique. This is usually measured as `-log2(Pr(term))`. The method of calculating the probability varies, depending on which predicates are taken into account (for many ontologies, it makes sense to use part-of as well as is-a), and whether the probability is the probability of observing a descendant term, or of an entity annotated using that term.

#### Interface

A programmatic abstraction that allows us to focus on _what_ something should do rather than _how_ it is done.

#### Jaccard Similarity

A measures of the similarity between two sets of data to see which members are shared and distinct.

#### KGCL

Knowledge Graph Change Language (KGCL) is a [data model](#Data-model) for communicating desired changes to an ontology. It can also be used to communicate differences between two ontologies. See [KGCL docs](https://github.com/INCATools/kgcl).

#### Knowledge Graph

A network of real-world entities (i.e., objects, events, situations, and concepts) that illustrates the relationships between them. Knowledge graphs (in relation to ontologies) are thought of as real data built using an ontology as a framework.

#### Label

Usually refers to a human-readable text string corresponding to the `rdfs:label` [predicate](#predicate). Labels are typically unique per ontology. In OBO Format and in the bio-ontology literature, labels are sometimes called [Names](#Name). Sometimes in the machine learning literature, and in databases such as Neo4J, "label" actually refers to a [Category](#Category).

#### Lutra

[Lutra](https://ottr.xyz/#Lutra) is the open source reference implementation of the [OTTR](#OTTR) templating language.

#### Mapping

A means of linking two resources (e.g. two ontologies, or an ontology and a database) together. Also see [SSSOM]('SSSOM')

#### Materialised

The process of making inferred axioms explicit by asserting them.

#### Name

Usually synonymous with [Label](#Label), but in the formal logic and OWL community, "Name" sometimes denotes an [Identifier](#Identifier)

#### Named Individual

An [Individual](#Individual) that is given an explicit name that can be used in any ontology to refer to the same object; named individuals get IRIs whereas [anonymous individuals](#Anonymous-Individual) do not.

#### Nodes

[Terms](#Term) represented in a [graph](#Graph)

#### Object

The "right" side of a [Triple](#Triple).

#### ObjectProperty

An [owl entity](#OWL-Entity) that is used to related 2 [individuals](#Individual) ('my left foot' part_of 'my left leg') or two classes ('foot' part_of some leg) or an individual and a class ('the neuron depicted in this image' (is) has_soma_location some 'primary motor cortex. More rarely it is used to define a class in terms of some individual (the class 'relatives of Shawn' related_to Value Shawn.

#### OBO

Open Biological and Biomedical Ontology. This could refer to the [OBO Foundry](https://obofoundry.org/) (e.g. OBO ontologies = ontologies that follow the standards of the OBO Foundry) or [OBO Format](#OBO-Format)

#### OBO Format

A serialization format for ontologies designed for easy viewing, direct editing, and readable diffs. It is popular in bioinformatics, but not widely used or known outside the genomics sphere. OBO is mapped to OWL, but only expresses a subset, and provides some OWL abstractions in a more easy to understand fashion.

#### OLS

Ontology Lookup Service. An [Ontology Repository](#Ontology-Repository) that is a curated collection of multiple biologically relevant ontologies, many from [OBO](#OBO). OLS can be accessed with this [link](https://www.ebi.ac.uk/ols/index)

#### Ontology

A flexible concept loosely encompassing any collection of [OWL entities](#OWL-entity) and statements or relationships connecting them.

#### ODK

[Ontology Development Kit](https://github.com/INCATools/ontology-development-kit). A toolkit and docker image for managing ontologies.

#### Ontology Library

The systems or platform where various types of ontologies are stored from different sources and provide the ability to data providers and application developers to share and reuse the ontologies.

#### Ontology Repository

A curated collection of ontologies.

#### OTTR

[Reasonable Ontology Templates](https://ottr.xyz/). A system for composable ontology templates and documentation.

#### OWL

Web Ontology Language. An ontology language that uses constructs from [Description Logic](#Description-Logic). OWL is not itself an ontology format, it can be serialized through different formats such as [Functional Syntax](#Functional-Syntax), and it can be mapped to :[RDF](#RDF) and serialized via an RDF format.

#### OWL Annotation

In the context of [OWL](#OWL), the term [Annotation](#Annotation) means a piece of metadata that does not have a strict logical interpretation. Annotations can be on entities, for example, [Label](#Label) annotations, or annotations can be on [Axioms](#Axiom).

#### OWL API

A java-based [API](#API) to interact with OWL ontologies. Full documentation can be found at http://owlcs.github.io/owlapi/apidocs_5/index.html

#### OWL Entity

OWL Entities, such as classes, properties, and individuals, are identified by IRIs. They form the primitive terms of an ontology and constitute the basic elements of an ontology. For example, a class a:Person can be used to represent the set of all people. Similarly, the object property a:parentOf can be used to represent the parent-child relationship. Finally, the individual a:Peter can be used to represent a particular person called "Peter". 
The following is a complete list of types of OWL Entities:

- [Class](#Class) 
- [Individual](#Individual)
- [ObjectProperty](#ObjectProperty)
- [AnnotationProperty](#AnnotationProperty)
- [dataProperty](#dataProperty) 
- [Datatype](#datatype)

#### Predicate

An [OWL entity](#OWL-entity) that represents the type of a [Relationship](#Relationship).
Typically corresponds to an [ObjectProperty](#ObjectProperty) in [OWL](#OWL), but this is not always true;
in particular, the is-a relationship type is a builtin construct `SubClassOf` in OWL
Examples:

- is-a
- part-of (BFO:0000050)

#### Prefix Map

A prefix map is a dictionary data structure where keys represent CURIE prefixes and their associated values represent
URI prefixes. Ideally, these are constrained to be bijective (i.e., no duplicate keys, no duplicate values), but this is
not always done in practice. Here’s an abbreviated example prefix map describing OBO Foundry ontologies:

```json
{
  "CHEBI": "http://purl.obolibrary.org/obo/CHEBI_",
  "MONDO": "http://purl.obolibrary.org/obo/MONDO_",
  "GO": "http://purl.obolibrary.org/obo/GO_"
}
```

#### Project Ontology

An ontology that is specific to a project and does not necessarily have interoperability with other ontologies in mind.

#### Pronto

An [Ontology Library](#Ontology-Library) for parsing obo and owl files.

#### Property

An [OWL entity](#OWL-entity) that represents an attribute or a characteristic of an element.
In [OWL](#OWL), properties are divided into disjoint categories:

- [ObjectProperty](#ObjectProperty)
- [AnnotationProperty](#AnnotationProperty)
- [dataProperty](#dataProperty)

#### Protege

A typical ontology development tool used by ontology developers in the OBO-sphere. Full documentation can be found at https://protege.stanford.edu/.

#### Range

Range, in reference to a [dataProperty](#dataProperty) or [ObjectProperty](#ObjectProperty), refers to the restriction on the [object](#Object) of a [triple](#Triple) - if a given property has a given [class](#Class) in its domain this means that any individual that has a value for the property (i.e. is the subject of a relation along the property), will be inferred to be an instance of that domain class. For example, if `John hasParent Mary` and `Person` is listed in the domain of `hasParent`, then `John` will be inferred to be an instance of `Person`.

#### RDF

A datamodel consisting of simple [Subject](#Subject) [predicate](#predicate) [Object](#Object) [Triples](#Triple) organized into an RDF [Graph](#Graph).

#### rdflib

A python library to interact with RDF data. Full documentation can be found at https://rdflib.readthedocs.io/en/stable/.

#### Reasoner

An ontology tool that will perform inference over an ontology to yield new _axioms_ (e.g. new [Edges](#Edge)) or to determine if an ontology is logically coherent.

#### Relationship

A [Relationship](#Relationship) is a type connection between two [OWL entities](#OWL-entity). The first element is called the [subject](#Subject), and the second one the [Object](#Object), with the type of connection being the [Relationship Type](#Relationship-Type). Sometimes Relationships are equated with [Triples](#Triple) in [RDF](#RDF) but this can be confusing, because some relationships map to _multiple_ triples when following the OWL RDF serialization. An example is the relationship "finger part-of hand", which in OWL is represented using a [Existential Restriction](#Existential-Restriction) that maps to 4 triples.

#### Relationship Type

See [predicate](#predicate)

#### ROBOT

A toolkit for transforming and interacting with ontologies. Full documentation can be found at http://robot.obolibrary.org/

#### Semantic Similarity

A means of measuring similarity between either pairs of ontology concepts, or between entities annotated using ontology concepts. There is a wide variety of different methods for calculating semantic similarity, for example [Jaccard Similarity](#Jaccard-Similarity) and [Information Content](#Information-Content) based measures.

#### Semantic SQL

Semantic SQL is a proposed standardized schema for representing any RDF/OWL ontology, plus a set of tools for building a database conforming to this schema from RDF/OWL files. See [Semantic-SQL](https://github.com/INCATools/semantic-sql)

#### SPARQL

The standard query language and protocol for Linked Open Data on the web or for RDF [triplestores](#Triplestore) - used to query ontologies.

#### SSSOM

Simple Standard for Sharing Ontological Mappings (https://github.com/mapping-commons/sssom).

#### Subject

The "left" side of a [Triple](#Triple).

#### Subset

A named collection of elements, typically grouped for some purpose. In the ODK/OBO world, there is a standard [annotation property](#AnnotationProperty) and pattern for this, for more information, see the [subset documentation](../howto/add-new-slim/#adding-a-term-to-a-subset-slim).

#### Term

Usually used to mean [Class](#Class) and [Individuals](#Individual), however sometimes used to refer to wider [OWL entities](#OWL-Entity).

#### Text Annotation

The process of annotating spans of texts within a text document with references to ontology terms, or the result of this process. This is frequently done automatically. The [Bioportal](#Bioportal) implementation provides text annotation services.

#### Triple

A set of three entities that codifies a statement about semantic data in the form of [Subject](#Subject)-[predicate](#predicate)-[Object](#Object) expressions (e.g., "Bob is 35", or "Bob knows John"). Also see [Relationship](#Relationship).

#### Triplestore

A purpose-built database for the storage and retrieval of triples through semantic queries. A triple is a data entity composed of subject–predicate–object, like "Bob is 35" or "Bob knows Fred".

#### Ubergraph

An integrated OBO ontology [Triplestore](#Triplestore) and a [Ontology Repository](#Ontology-Repository), with merged set of mutually referential OBO ontologies (see the [ubergraph github](https://github.com/INCATools/ubergraph) for list of ontologies included), that allows for [SPARQL](#SPARQL) querying of integrated [OBO](#OBO) ontologies.

#### URI

A Uniform Resource Indicator, a generalization of URL. Most people think of URLs as being solely for addresses for web pages (or APIs) but in semantic web technologies, URLs can serve as actual identifiers for entities like [OWL entities](#OWL-entity). Data models like [OWL](#OWL) and [RDF](#RDF) use URIs as identifiers. In OAK, URIs are mapped to [CURIE](#CURIE)
