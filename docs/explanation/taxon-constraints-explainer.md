# Guide to Taxon Restrictions

## What are taxon restrictions?

Taxon restrictions are a formalised way to record what species a term applies to—something crucial in multi-species ontologies.

Even species neutral ontologies (e.g., GO) have classes that have implicit taxon restriction.

```
GO:0007595 ! Lactation - defined as “The secretion of milk by the mammary gland.”
```

## Uses for taxon restrictions

1. **Finding inconsistencies.** Taxon restrictions use terms from the NCBI Taxonomy Ontology, which asserts pairwise disjointness between sibling taxa (e.g., nothing can be both an insect and a rodent). When terms have taxon constraints, a reasoner can check for inconsistencies.

    _When GO implemented taxon restrictions, [they found 5874 errors](https://pubmed.ncbi.nlm.nih.gov/20973947/)!_

2. **Defining taxon-specific subclasses.** You can define a taxon-specific subclass of a broader concept, e.g., 'human clavicle'. This allows you, for example, to assert relationships for the new term that don't apply to all instances of the broader concept:

    ```
    'human clavicle' EquivalentTo 'clavicle bone' and ('in taxon' some 'Homo sapiens')
    'human clavicle' SubClassOf 'connected to' some sternum
    ```

3. **Creating SLIMs.** Use a reasoner to generate ontology subsets containing only those terms that are logically allowed within a given taxon.

4. **Querying.** Facet terms by taxon. E.g., in Brain Data Standards, in_taxon axioms allow faceting cell types by species. (note: there are limitations on this and may be incomplete).
      
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
