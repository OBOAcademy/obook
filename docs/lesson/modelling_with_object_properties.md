# Modelling with Object Properties

In this lesson, we will give an intuition of how to work with `object properties` in OBO ontologies, also referred to as "relations".

We will cover, in particular, the following subjects:

1. What is the role of object properties in OBO ontologies, and how should we model them?
2. What is the relation ontology (RO), and how do we add object properties to it?

<a name="preparation"></a> 
## Preparation

We are working with the University of Manchester to incorporate the Family History Knowledge Base Tutorial fully into OBO Academy. While this is happening, we recommend you to do the old version of the tutorial:

http://owl.cs.manchester.ac.uk/publications/talks-and-tutorials/fhkbtutorial/

PDF can be downloaded [here](http://mowl-power.cs.man.ac.uk/fhkbtutorial/resources/FHKB-tutorial_v1_1.pdf).

In contrast to the Pizza tutorial, the Family history tutorial focuses on modelling with individuals. Chapters 4, 5, 8 and 9 are full of object property modelling, and are not only great to get a basic understanding of using them in your ontology, but also give good hints at where OWL and object properties fall short. We refer to the FHKB in the following and expect you to have completed at least chapter 5 before reading on.

## The Role of Object Properties in the OBO-sphere

To remind ourselves, there are three different types of relations in OWL:

1. Data properties (DatatypeProperty) connect your classes and individuals to data values, such as strings or numbers. In OBO, these are the least frequently used kinds of properties, used for example by CIDO and ONS.

For some example usage, run the following query in the ontobee OLS endpoint:

http://www.ontobee.org/sparql

```
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix owl: <http://www.w3.org/2002/07/owl#> 
SELECT distinct *
WHERE { 
GRAPH ?graph_uri
{ ?dp rdf:type owl:DatatypeProperty .
  ?sub ?dp ?obj } 
}
```

Note that many uses of data properties across OBO are a bit questionable, for example, you do _never_ want to attach a modification dates or similar to your classes using data properties, as these _fall under OWL semantics_. This means that logically, if a superclass has a relation using a DatatypeProperty, then this relation _holds for all subclasses of that class as well.

2. Annotation properties are similar to data properties, but they are _outside of OWL semantics_, i.e. OWL reasoners and reasoning do not care, in fact ignore, anything related to annotation properties. This makes them suitable for attaching metadata like labels etc to our classes and properties. We sometimes use annotation properties even to describe relationships between classes if we want reasoners to ignore them. The most typical example is IAO:replaced_by, which connects an obsolete term with its replacement. Widely used annotation properties in the OBO-sphere are standardised in the [OBO Metadata Ontology (OMO)](https://github.com/information-artifact-ontology/ontology-metadata).

3. The main type of relation we use in OBO Foundry are _object properties_. Object properties relate two individuals or classes with each other, for example:

```
OWLObjectPropertyAssertion(:part_of, :heart, :cardiovascular_system)
```

In the same way as _annotation properties_ are maintained in [OMO](https://github.com/information-artifact-ontology/ontology-metadata) (see above), _object properties_ are maintained in the [Relation Ontology (RO)](https://github.com/oborel/obo-relations).

Object properties are of central importance to all ontological modelling in the OBO sphere, and understanding their semantics is critical for any put the most trivial ontologies. We assume the reader to have completed the [Family History Tutorial mentioned above](#preparation).

<a name="semantics"></a> 
## Object property semantics in OBO

In our experience, these are the most widely used characteristics we specify about object properties (OP):

1. Sub-property: if an OP is a sub-property of another parent OP, it inherits all its semantic characteristics. Most importantly: if OP1 is a sub-property of OP2, then, if (a)--[OP1]-->(b), we infer that (a)--[OP2]-->(b).
2. Domain: if OP has a domain C, it means that every time (a)--[OP]-->(b), (a) must be a C. For example, `ecologically co-occurs with` in RO has the domain `'organism or virus or viroid'`, which means that whenever _anything_ `ecologically co-occurs with` something else, it will be _inferred_ to be a `'organism or virus or viroid'`.
3. Range: if OP has a range C, it means that every time (a)--[OP]-->(b), (b) must be a C. For example `produced by` has the domain `material entity`. _Note_ that in ontologies, ranges are _slightly_ less powerful then domains: If we have a class `Moderna Vaccine` which is SubClass of `'produced by' some 'Moderna'` we get that `Moderna Vaccine` is a `material entity` due to the domain constraint, but NOT that `Moderna` is a `material entity` due to the range constraint (explanation to this is a bit complicated, sorry).
4. Transitivity: if an OP is transitive, it means that if (a)--[OP]-->(b)--[OP]-->(c), (a)--[OP]-->(c). For example, if the eye is part of the head, which is part of the body, we can infer that the eye must be part of the body.
5. Property chains: Similar to transitive properties, [property chains](https://oborel.github.io/obo-relations/property-chains/) allow us to bridge across multiple properties. The FHKB tutorial above is _all about amazing property chains_ so you should have a deep understanding of these if you followed the tutorial.

Other characteristics like functionality and symmetry are used across OBO ontologies, but not nearly to the same extend as the 5 described above.

## The Relation Ontology (RO)

The Relation Ontology serves two main purposes in the OBO world:

1. As a place to standardise object properties. The idea is this: many ontologies are modelling _mereological_ relations, such as partonomies, which requires relation ships such as "part of" and "has part". To ensure that ontologies are interoperable, we need to make sure that all ontologies use the _same_ "part of" relationship. Historically this is not always been true, and still is not. At the time of this writing, running:
```
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix owl: <http://www.w3.org/2002/07/owl#> 
SELECT distinct ?graph_uri ?s
WHERE { 
GRAPH ?graph_uri 
{ ?s rdf:type owl:ObjectProperty ;
   rdfs:label "part of" . } 
}
```
On the [OntoBee SPARQL endpoint](http://www.ontobee.org/sparql) still reveals a number of ontologies using non-standard part-of relations. In our experience, most of these are accidental due to past format conversions, but not all. This problem was _much worse_ before RO came along, and our goal is to unify the representation of key properties like "part of" across all OBO ontologies. The [OBO Dashboard](http://dashboard.obofoundry.org/) checks for object properties that are not aligned with RO.
2. As a place to encode and negotiate object property semantics. Object properties (OP) can have domains and ranges, can have characteristics such as functionality and transitivity, see [above](#semantics). Arguing the exact semantics of an OP can be a difficult and lengthy collaborative process, esp. since OP semantics can have a huge impact on ontology reasoning. Detailed RO documentation (modelling patterns and practices) can be found in [here](https://oborel.github.io/obo-relations/). The process of how relationships are added to RO is discussed in the next section.

### Adding relationships to RO

To add a relationship we usually follow the following process. For details, please refer to the [RO documentation](https://oborel.github.io/obo-relations/).

1. Check whether the [OP is already in RO](https://www.ebi.ac.uk/ols/ontologies/ro). Search for synonyms - often the relationship you are looking exist, but under a different name. If you cant find the exact OP, see whether you can find similar OPs - this may help you also identify suitable parent OPs.
2. Make an [RO issue](https://github.com/oborel/obo-relations/issues). Take care to not only describe the name of your relationship, but also intended application areas with examples, a good [definition](https://github.com/oborel/obo-relations/issues/523), potential parent relationships, domains and ranges. The more detail you provide, the easier it will be for the community to review your request.
3. Make a [pull request](https://github.com/oborel/obo-relations/pulls). This involves the same steps as [usual](../howto/github_create_pull_request.md). If you are unsure what annotations need to be added and how to reflect the intended semantics, it may be useful to look at [past pull requests](https://github.com/oborel/obo-relations/pull/490/files).
4. Join our quarterly RO calls and check out the [RO documentation](https://oborel.github.io/obo-relations/).