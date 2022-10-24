# Guide to Taxon Restrictions

## What are taxon restrictions?

Taxon restrictions are a formalised way of to record what species a term applies to - something crucial in multi-species ontologies.

Even species neutral ontologies (eg GO) have classes that have implicit taxon restriction.

`Eg GO:0007595 ! Lactation - defined as “The secretion of milk by the mammary gland.”`

## Why restrict taxon?

1. Finding inconsistencies
   Taxon restriction use NCBITaxon which have pairwise disjointness between species (eg Nothing is both an insect and a rodent and a primate)
   When addint taxon constraints, a reasoner can check for inconsistencies.

E.g. when GO implemented taxon restrictions, they found 5874 errors [PMID:20973947](https://pubmed.ncbi.nlm.nih.gov/20973947/)

2. Creating SLIMs
   Allows for use of reasoner to generate taxon related SLIMs

3. Querying
   E.g. in Brain Data Standards, in_taxon axioms that allow faceting cell types by species. (note: there are limitations on this and may be incomplete)
      
## Types of Taxon Restrictions 

There are, in essence, three categories of taxon-specific knowledge we use across OBO ontologies. Given a class `C`, which could be anything from an anatomical entity to a biological process, we have the following categories:


1. The ALL-IN restriction: "C in-taxon T"
2. The NOT-IN restriction: "C never-in-taxon T"
3. The SOME-IN restriction: "C present-in-taxon T"

#### The ALL-IN restriction: "in-taxon some T"

- _Meaning_: "_All_ instances of `C` are in taxon `T`"
- _Canonical logical representation_: `C SubClassOf: in-taxon some T` 
   - Comment: no need for only-in-taxon if in-taxon is functional
- _Alternative representations_: None
- _Editor guidance_:  Editors use the Cannonical logical representation in subClassOf or simple (non-nested) EquivalentClass axioms.

#### The NOT-IN restriction: "C SubClassOf: not (in_taxon some T)"

- _Meaning_: "_No_ instances of `C` are in taxon `T`"
- _Canonical logical representation_: `C SubClassOf: not (in_taxon some T)` 
- _Alternative representations_:
   - Alternative EL logical representation: `C disjointWith in-taxon some T`
   - Canonical Shortcut: AnnotationAssertion: `C never-in-taxon T` # Editors use this
- _Editor guidance_: Editors use the canonical shorcut (annotation axiom). 

#### The SOME-IN restriction: "a ClassAssertion: `C` and in-taxon some `T`"

- _Meaning_: "_At least one specific_ instance of `C` is in taxon `T`". 
- _Canonical logical representation_: `IND:a Type: C and in-taxon some T`
- _Alternative representations_:
   - Canonical shortcut: AnnotationAssertion: `C present-in-taxon T` # Editors use this
- _Editor guidance_: Editors use the canonical shorcut (annotation axiom).  The taxon should be as specific as possible, ideally a species.

## How to add taxon restrictions:

Please see how-to guide on [adding taxon restrictions](../howto/add-taxon-restrictions.md)

## Why annotation for some taxon restrictions?

Annotations for taxon restrictions are used as a shortcut. These are used to more simply represent complex description.
Shortcuts work as a macro that is expanded out (see [this document](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#7) for technical details):

`Eg C never_in_taxon T -> C disjointWith in-taxon some T`
