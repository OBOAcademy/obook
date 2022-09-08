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

## How to add taxon restrictions:

Please see how-to guide on [adding taxon restrictions](../howto/add-taxon-restrictions.md)

## Why annotation for some taxon restrictions?

Annotations for taxon restrictions are used as a shortcut. These are used to more simply represent complex description.
Shortcuts work as a macro that is expanded out (see [this document](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#7) for technical details):

`Eg C never_in_taxon T -> C disjointWith in-taxon some T`
