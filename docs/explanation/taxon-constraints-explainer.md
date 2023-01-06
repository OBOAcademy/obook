# Guide to Taxon Restrictions

## What are taxon restrictions?

Taxon restrictions (or, "taxon constraints") are a formalised way to record what species a term applies to—something crucial in multi-species ontologies.

Even species neutral ontologies (e.g., GO) have classes that have implicit taxon restriction.

```
GO:0007595 ! Lactation - defined as “The secretion of milk by the mammary gland.”
```

## Uses for taxon restrictions

1. **Finding inconsistencies.** Taxon restrictions use terms from the NCBI Taxonomy Ontology, which asserts pairwise disjointness between sibling taxa (e.g., nothing can be both an insect and a rodent). When terms have taxon restrictions, a reasoner can check for inconsistencies.

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


1. The ALL-IN restriction: "C in_taxon T"
  - "Hair is found only in Mammals"
3. The NOT-IN restriction: "C never_in_taxon T"
  - "Hair is never found in Birds"
5. The SOME-IN restriction: "C present_in_taxon T"
  - "Hair is found in Skunks"
  - "Hair is found in Whales"

#### The ALL-IN restriction: "C in_taxon T"

- _Meaning_: "_All_ instances of `C` are in some instance of taxon `T`"
  - As this is a relation between instances, it may have been more correct to give this property a label such as "in organism".
- _Canonical logical representation_:
  ```
  C SubClassOf (in_taxon some T)
  
  ```
   - Comment: Ideally `in_taxon` would be declared to be an OWL functional property, meaning that something can only be `in_taxon` a single organism. However, this is prevented by some limitations of OWL (interactions with property chains).
- _Alternative representations_: None
- _Editor guidance_:  Editors use the canonical logical representation in a SubClassOf axiom to add a taxon restriction, or in a simple (non-nested) EquivalentClass axiom to define a taxon-specific subclass (which will also imply the taxon restriction). When used in a SubClassOf axiom, the taxon should be as specific as possible for the maximum utility, but may still need to be quite broad, as it applies to _every_ instance of `C`.

#### The NOT-IN restriction: "C SubClassOf (not (in_taxon some T))"

- _Meaning_: "_No_ instances of `C` are in taxon `T`"
- _Canonical logical representation_:
  ```
  C SubClassOf (not (in_taxon some T))`
  ```
- _Alternative representations_:
   - Alternative EL logical representation: `C DisjointWith (in_taxon some T)`
   - EL helper axiom: `C SubClassOf (in_taxon some (not T))`
   - Canonical shortcut: AnnotationAssertion: `C never_in_taxon T` # Editors use this
- _Editor guidance_: Editors use the canonical shortcut (annotation axiom). For `never_in_taxon` annotations, the taxon should be as broad as possible for the maximum utility, but it must be the case that a `C` is never found in any subclass of that taxon.

#### The SOME-IN restriction: "a ClassAssertion: `C` and in_taxon some `T`"

- _Meaning_: "_At least one specific_ instance of `C` is in taxon `T`". 
- _Canonical logical representation_: `IND:a Type: C and (in_taxon some T)`
- _Alternative representations_:
   - Generated subclass for QC purposes: `C_in_T SubClassOf (C and (in_taxon some T)` (`C_in_T` will be unsatisifiable if violates taxon constraints)
   - Canonical shortcut: AnnotationAssertion: `C present_in_taxon T` # Editors use this
- _Editor guidance_: Editors use the canonical shorcut (annotation axiom).  The taxon should be as specific as possible, ideally a species.

## How to add taxon restrictions:

Please see how-to guide on [adding taxon restrictions](../howto/add-taxon-restrictions.md)

## Why annotation for some taxon restrictions?

Annotations for taxon restrictions are used as a shortcut. These are used to more simply represent complex description.
Shortcuts work as a macro that is expanded out (see [this document](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#7) for technical details):

`Eg C never_in_taxon T -> C disjointWith in-taxon some T`
