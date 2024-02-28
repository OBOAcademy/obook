# The Base File Specification (DRAFT)

The "base file" is a specific _release flavour_ (variant) of an ontology. It reflects the intention of the ontology author for the official (publicly released) representation of the ontologies "base entities". "Base entities" are entities that are defined ("owned") by the ontology. The representation includes the intended public metadata (annotations), and classification (subClassOf hierarchy), including any statements where a base entity is the subject. The purpose of this document is to provide a detailed specification of what a base is, including a technical implementation which reflects best practice.

Up until March 2023, the ontology "base" reflected the structure of the editors file with no instantiation of axioms inferred by a reasoner.

The new base reflects the structure of the primary ontology release file (in the OBO world, the release variant that is available at `http://purl.obolibrary.org/obo/ontology.owl`), which often (but not always) corresponds to what is called the [full release](release-artefacts.md).

## Motivation

- Dependency management
- Modular ontology development (refer to "[no-modification principle](#no-modification))"

The "base file" allows complete versions of ontologies to be released in a way that facilitates modular composition. This could be composition ahead of time (for example, building a KG or application ontology), or dynamic composition; a future version of OLS may allow seamless transition between ontologies, e.g. traversing from mondo to uberon to cl to go in a way that preserves the complete structure of each ontology.

It is also built for safety - it is guaranteed that the intentions of contributing ontologies are respected, and hierarchies are not broken.

## Technical specification

```
Note: The following section is _normative_.
```

As per design, a base file is not defined in terms of what it contains, but by some constraints on what it MUST NOT contain. A "base file" MUST NOT:

1. contain any axiom where the subject is not a _base entity_. Positively formulated, it may only contain axioms where the subject is a _base entity_.


```
Note: The following section is _NOT normative_.
```

For practical purposes, we have defined a non-normative recommendation for how base files should be defined. _Non-normative_ means: the ontology developer may decide to adopt, modify or alter this recommendation in any way they want, as long as the _normative_ constraints above are not violated.

A "base file" SHOULD:

- include all "base entities", including deprecated ones
- include all standard and any number of user defined annotations on "base entities". Standard annotations are defined by the [Ontology Metatada Ontology (OMO)](https://github.com/information-artifact-ontology/ontology-metadata) and include labels (rdfs:label), deprecation assertions (owl:deprecated) and definitions (IAO:0000115). User-defined annotations are all annotations that are non-standard and are intended for inclusion in the public release.
- include a non-redundant set of reasoner-inferred axioms, including
   - inferred `rdfs:subClassOf` axioms between "base entities"
   - inferred `rdfs:subClassOf` axioms from "base entities" to non-base entity parents
   - inferred "existential restrictions", axioms of the form "`:A rdfs:subClassOf :R some :B`" where `:A` is a "base entity", and `:R` is an object property as defined by the ontology developer responsible for defining the release.
- "non-redundant" means that the `rdfs:subClassOf` sub-graph of the ontology corresponds to the "transitive reduct". In laypersons terms this means, roughly, that if a `rdfs:subClassOf` axiom is already implied by a path of `rdfs:subClassOf` axioms, that axiom is considered "redundant". (For example: given `:A rdfs:subClassOf :B`, `:B rdfs:subClassOf :C`, `:A rdfs:subClassOf :C`, the latter, `:A rdfs:subClassOf :C` is redundant because it is already implied by tge path through the former two axioms.)
- break down all `owl:equivalentClass` axioms into `rdfs:subClassOf` axioms where the subject is a "base entity"

## Implementation

This is the current implementation of the recommended base technical specification above. The full operational definition of the process for generating the "base file" is:

```
# base: A version of the ontology that does not include any externally imported axioms.
$(ONT)-base.owl:
	robot merge -i $(SRC) -i $(OTHER_SRC) -i $(ALL_IMPORTS) \
	reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
	materialize $(patsub %, --term %, $(OBJECT_PROPERTIES_OF_INTEREST)) \
	relax \
	reduce -r ELK \
	remove --base-iri $(URIBASE)/OBA --axioms external --preserve-structure false --trim false \
    {STANDARD_COMMANDS}
	--output $@
```

_This is a breakdown of the sub-processes:_

- `robot merge -i $(SRC) -i $(OTHER_SRC) -i $(ALL_IMPORTS)`:  Merge the ontology with all its dependencies together.
- `reason --reasoner {REASONER} --equivalent-classes-allowed asserted-only --exclude-tautologies structural`: Add all inferred `rdfs:subClassOf` axioms.
- `materialize $(patsub %, --term %, $(OBJECT_PROPERTIES_OF_INTEREST))`: Add all inferred subclass of R some B restrictions, where R is an "object property of interest".
- `relax`: break down all `owl:equivalentClass` axioms into `rdfs:subClassOf` axioms where the subject is a "base entity"
- `reduce -r {REASONER}`: remove all redundant `rdfs:subClassOf` axioms
- `remove --base-iri {BASEIRI} --axioms external --preserve-structure false --trim false`: remove all axioms where the subject is not a "base entity"

## How to determine the "subject" of an axiom

Instead of exhaustively defining the idea of subject (extensional definition), we define it by inclusion (intentional definition):

Given:

- `?x` a base entity
- `?y` an arbitrary expression (like a class or property name, or class expression)
- `?property` an instance of `owl:AnnotationProperty`, `owl:ObjectProperty` or `owl:DataProperty`
- `?annotation_property` an instance of `owl:AnnotationProperty`
- `?object_property` an instance of `owl:ObjectProperty`
- `?data_property` an instance of `owl:DataProperty`

The following axioms are considered to having `?x` as a subject (aka "base axioms"):

- Assertions of the form `?x  ?property ?value` (includes Annotation, Object and DataProperty Assertions)
- SubClassOf axioms of the form `?x  rdfs:subClassOf ?y`
- Equivalent class axioms of the form `?x  owl:equivalentClass ?y`
- Equivalent class axioms of the form `?y  owl:equivalentClass ?x`
- An assertion of a characteristic of the form `Characteristic(?x)`, like `TransitiveCharacteristic(?x)` etc.
- An assertion of the form `ObjectPropertyDomain(?x, ?y)`
- An assertion of the form `ObjectPropertyRange(?x, ?y)`

Examples of axioms that _do not have `?x` as a subject_:

- SubClassOf axioms of the form `?y rdfs:subClassOf ?x`
- An assertion of the form `ObjectPropertyDomain(?y, ?x)` (where `?x` is the domain of an object property `?y`)
- An assertion of the form `ObjectPropertyRange(?y, ?x)` (where `?x` is the range of an object property `?y`)
- A GCI axiom of the form `SomeValuesFrom(?object_property, ?x) rdfs:subClassOf ?y`
- A GCI axiom of the form `?y rdfs:subClassOf SomeValuesFrom(?object_property, ?x)`
- A GCI axiom of the form `SomeValuesFrom(?x, ?y) rdfs:subClassOf ?z`
- _IMPORTANT NOTE_: Handling of GCIs is still work in progress. It is not straight forward to define which is the defining entity. For now, unless all entities on the left are in the ontology for which we are making a base, GCIs are never in the base. This is being reviewed and may change in the future.

<a id="no-modification"></a>

## The No-Modification Principle

We start with a proposed principle that applies to databases (triplestores and other databases) that expose one or more ontologies and that also applies to derived ontologies:

Each ontology’s released SubClassOf hierarchy (across the authority signature) should be preserved. Specifically, the original SubClassOf hierarchy SHOULD be preserved in the majority of cases. Modifications to the SubClassOf hierarchy MUST NOT be re-released.

Here modifications means:

- Removing a SubClassOf axiom
- Adding a new SubClassOf axiom

This includes is-a (SubClassOf between named classes) and SubClassOf where the parent is an expression (including existentials, aka relationships)

Except under the following conditions:

- An ontology subset is being made
   - This SHOULD be done by the main provider EXCEPT for import modules
   - When an ontology subset is made it should be both complete and correct **with respect to the original SubClassOf graph**. Here correct means that every axiom in the subset must be entailed by the parent ontology. Complete means roughly that all axioms from the parent ontology must be in the subset, unless an entity in the signature of the axiom is not in the subset signature (including object properties). Thus if a subset signature has classes C1, …, Cn and OP1, then any entailed Cx SubClassOf OP1 some Cy (where x and y are in 1..n) should be included, but Cx SubClassOf OP2 some Cy would be excluded
- Axioms may be added under conditions recognized where injections are allowed
   - Any such exceptions MUST be to link to another ontology (bridging axioms)
   - For example, a ssAO to a snAO
- The modifications are explicitly sanctioned by the source ontology providers

Here "original" refers to the source ontology and all immediate products (for example, uberon and uberon-basic). Re-released means made available by alternate downloads or queries
