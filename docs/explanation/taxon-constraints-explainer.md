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
    'human clavicle' EquivalentTo ('clavicle bone' and ('in taxon' some 'Homo sapiens'))
    'human clavicle' SubClassOf ('connected to' some sternum)
    ```

3. **Creating SLIMs.** Use a reasoner to generate ontology subsets containing only those terms that are logically allowed within a given taxon.

4. **Querying.** Facet terms by taxon. E.g., in Brain Data Standards, in_taxon axioms allow faceting cell types by species. (note: there are limitations on this and may be incomplete).
      
## Types of Taxon Restrictions 

There are, in essence, three categories of taxon-specific knowledge we use across OBO ontologies. Given a class `C`, which could be anything from an anatomical entity to a biological process, we have the following categories:


1. The ALL-IN restriction: "C [in_taxon](http://purl.obolibrary.org/obo/RO_0002162) T"
   - "Hair is found only in Mammals"
3. The NOT-IN restriction: "C [never_in_taxon](http://purl.obolibrary.org/obo/RO_0002161) T"
   - "Hair is never found in Birds"
5. The SOME-IN restriction: "C [present_in_taxon](http://purl.obolibrary.org/obo/RO_0002175) T"
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
- _Canonical logical representation_:
  ```
  IND:a Type (C and (in_taxon some T))`
  ```
- _Alternative representations_:
   - Generated subclass for QC purposes: `C_in_T SubClassOf (C and (in_taxon some T)` (`C_in_T` will be unsatisifiable if violates taxon constraints)
   - Canonical shortcut: AnnotationAssertion: `C present_in_taxon T` # Editors use this
- _Editor guidance_: Editors use the canonical shorcut (annotation axiom).  The taxon should be as specific as possible, ideally a species.

## Using taxon restrictions for Quality Control

As stated above, one of the major applications for taxon restrictions in OBO is for quality control (QC), by finding logical inconsistencies. Many OBO ontologies consist of a complex web of term relationships, often crossing ontology boundaries (e.g., GO biological process terms referencing Uberon anatomical structures or CHEBI chemical entities). If particular terms are only defined to apply to certain taxa, it is critical to know that a chain of logic implies that the term must exist in some other taxon which should be impossible. Propagating taxon restrictions via logical relationships greatly expands their effectiveness (the GO term above may acquire a taxon restriction via the type of anatomical structure in which it occurs).

It can be helpful to think informally about how taxon restrictions propagate over the class hierarchy. It's different for all three types:

- ALL-IN restrictions (`in_taxon`) include all _superclasses_ of the taxon, and all _subclasses_ of the subject term:
  ```mermaid
     graph BT;
       n1(hair) ;
       n2(whisker) ;
       n3(Mammalia) ;
       n4(Tetrapoda) ;
       n2--is_a-->n1 ;
       n3--is_a-->n4 ;
       n1==in_taxon==>n3 ;
       n1-.in_taxon.->n4 ;
       n2-.in_taxon.->n3 ;
       n2-.in_taxon.->n4 ;
       linkStyle 0 stroke:#999 ;
       linkStyle 1 stroke:#999 ;
       style n1 stroke-width:4px ;
       style n3 stroke-width:4px ;
   ```
- NOT-IN restrictions (`never_in_taxon`) include all _subclasses_ of the taxon, and all _subclasses_ of the subject term:
  ```mermaid
     graph BT;
       n1(facial whisker) ;
       n2(whisker) ;
       n3(Homo sapiens) ;
       n4(Hominidae) ;
       n1--is_a-->n2 ;
       n3--is_a-->n4 ;
       n2==never_in_taxon==>n4 ;
       n2-.never_in_taxon.->n3 ;
       n1-.never_in_taxon.->n4 ;
       n1-.never_in_taxon.->n3 ;
       linkStyle 0 stroke:#999 ;
       linkStyle 1 stroke:#999 ;
       style n2 stroke-width:4px ;
       style n4 stroke-width:4px ;
   ```
- SOME-IN restrictions (`present_in_taxon`) include all _superclasses_ of the taxon, and all _superclasses_ of the subject term:
  ```mermaid
     graph BT;
       n1(hair) ;
       n2(whisker) ;
       n3(Felis) ;
       n4(Carnivora) ;
       n2--is_a-->n1 ;
       n3--is_a-->n4 ;
       n2==present_in_taxon==>n3 ;
       n1-.present_in_taxon.->n3 ;
       n2-.present_in_taxon.->n4 ;
       n1-.present_in_taxon.->n4 ;
       linkStyle 0 stroke:#999 ;
       linkStyle 1 stroke:#999 ;
       style n2 stroke-width:4px ;
       style n3 stroke-width:4px ;
   ```

The Relation Ontology defines number of property chains for the `in_taxon` property. This allows taxon restrictions to propagate over other relationships. For example, the `part_of o in_taxon -> in_taxon` chain implies that if a muscle is part of a whisker, then the muscle must be in a mammal, but not in a human, since we know both of these things about whiskers:

```mermaid
     graph BT;
       n1(hair) ;
       n2(whisker) ;
       n3(Mammalia) ;
       n4(Homo sapiens) ;
       n5(Hominidae) ;
       n6(whisker muscle) ;
       n2--is_a-->n1 ;
       n5--is_a-->n3 ;
       n4--is_a-->n5 ;
       n6--part_of-->n2 ;
       n1==in_taxon==>n3 ;
       n2==never_in_taxon==>n5 ;
       n2-.in_taxon.->n3 ;
       n6-.in_taxon.->n3 ;
       n6-.never_in_taxon.->n4 ;
       n2-.never_in_taxon.->n4 ;
       n6-.never_in_taxon.->n5 ;
       linkStyle 0 stroke:#999 ;
       linkStyle 1 stroke:#999 ;
       linkStyle 2 stroke:#999 ;
       linkStyle 3 stroke:#008080 ;
       style n6 stroke-width:4px ;
   ```

Property chains are the most common way in which taxon restrictions propagate across ontology boundaries. For example, Gene Ontology uses various subproperties of [results in developmental progression of](http://purl.obolibrary.org/obo/RO_0002295) to connect biological processes to Uberon anatomical entities. Any taxonomic restrictions which hold for the anatomical entity will propagate to the biological process via this property.

The graph depictions in the preceding illustrations are informal; in practice `never_in_taxon` and `present_in_taxon` annotations are translated into more complex logical constructions using the `in_taxon` object property, described in the next section. These logical constructs allow the OWL reasoner to determine that a class is unsatisfiable when there are conflicts between taxon restriction inferences. 

## Implementation and reasoning with taxon restrictions

The OWL axioms required to derive the desired entailments for taxon restrictions are somewhat more complicated than one might expect. Much of the complication is the result of workarounds to limitations dictated by the [OWL EL profile](https://www.w3.org/TR/owl2-profiles/#OWL_2_EL). Because of the size and complexity of many of the ontologies in the OBO Library, particularly those heavily using taxon restrictions, we primarily rely on the ELK reasoner, which is fast and scalable since it implements OWL EL rather than the complete OWL language. In the following we discuss the particular kinds of axioms required in order for taxon restrictions to work with ELK, with some comments about how it could work with HermiT (which implements the complete OWL language but is much less scalable). We will focus on this example ontology:

```mermaid
     graph BT;
       n1(hair) ;
       n2(whisker) ;
       n3(muscle) ;
       n4(whisker muscle) ;
       n5(whisker muscle in human) ;
       n6(whisker in catfish) ;
       n7(whisker in human) ;
       n8(life) ;
       n9(Teleostei) ;
       n10(Siluriformes) ;
       n11(Tetrapoda) ;
       n12(Mammalia) ;
       n13(Hominidae) ;
       n14(Homo sapiens) ;
       n2--is_a-->n1 ;
       n4--is_a-->n3 ;
       n9--is_a-->n8 ;
       n10--is_a-->n9 ;
       n11--is_a-->n8 ;
       n12--is_a-->n11 ;
       n13--is_a-->n12 ;
       n14--is_a-->n13 ;
       n5--is_a-->n4 ;
       n6--is_a-->n2 ;
       n7--is_a-->n2 ;
       n4--part_of-->n2 ;
       n11 --disjoint_with--- n9 ;
       n1==in_taxon==>n12 ;
       n2==never_in_taxon==>n13 ;
       n5==in_taxon==>n14 ;
       n7==in_taxon==>n14 ;
       n6==in_taxon==>n10 ;
       linkStyle 0 stroke:#999 ;
       linkStyle 1 stroke:#999 ;
       linkStyle 2 stroke:#999 ;
       linkStyle 3 stroke:#999 ;
       linkStyle 4 stroke:#999 ;
       linkStyle 5 stroke:#999 ;
       linkStyle 6 stroke:#999 ;
       linkStyle 7 stroke:#999 ;
       linkStyle 8 stroke:#999 ;
       linkStyle 9 stroke:#999 ;
       linkStyle 10 stroke:#999 ;
       linkStyle 11 stroke:#008080 ;
       linkStyle 12 stroke:red ;
       style n5 stroke-width:4px,stroke:red ;
       style n6 stroke-width:4px,stroke:red ;
       style n7 stroke-width:4px,stroke:red ;
   ```

There are three classes outlined in red which were created mistakenly; the asserted taxon for each of these conflicts with taxon restrictions in the rest of the ontology:

- **'whisker in human'** — We expect this to be unsatisfiable since it is a subclass of 'whisker', which has a 'never in Hominidae' restriction. 'Whisker in human' is asserted to be in_taxon 'Homo sapiens', a subclass of 'Hominidae'.
- **'whisker in catfish'** — We expect this to be unsatisfiable since it is a subclass of 'whisker', and thus a subclass of 'hair'. 'Hair' has an 'only in Mammalia' restriction. 'Whisker in catfish' is asserted to be in_taxon 'Siluriformes' (catfish), which is a subclass of Teleostei and thus disjoint from 'Mammalia'.
- **'whisker muscle in human'** — We expect this to be unsatisfiable since it is a 'whisker muscle' and thus part of a 'whisker', and thus inherits the 'never in Hominidae' restriction from 'whisker' via the property chain `part_of o in_taxon -> in_taxon`. This conflicts with its asserted in_taxon 'Homo sapiens', a subclass of 'Hominidae'.

### Taxon restriction modeling

We can start by modeling the two taxon restrictions in the ontology like so:
- 'hair' 'in_taxon' 'Mammalia': `'hair' SubClassOf (in_taxon some 'Mammalia')`
- 'whisker' 'never_in_taxon' 'Mammalia': `'whisker' SubClassOf (not (in_taxon some 'Hominidae'))`

Both HermiT and ELK can derive that 'whisker in human' is unsatisfiable. This is the explanation:
- `'human whisker' EquivalentTo ('whisker' and (in_taxon some 'Homo sapiens'))`
- `'Homo sapiens' SubClassOf 'Hominidae'`
- `'whisker' SubClassOf (not ('in_taxon' some 'Hominidae'))`

Unfortunately, neither reasoner detects the other two problems. We'll address the 'whisker in catfish' first. The reasoner infers that this class is `in_taxon` both 'Mammalia' and 'Siluriformes'. While these are disjoint classes (all sibling taxa are asserted to be disjoint in the taxonomy ontology), there is nothing in the ontology stating that something can only be in one taxon at a time. The most intuitive solution to this problem would be to assert that `in_taxon` is a functional property. However, due to limitations of OWL, can't be used in combination with property chains. Furthermore, functional properties aren't part of OWL EL. There is one solution that works for HermiT, but not ELK. We could add an axiom like the following to every "always in taxon" restriction:

- `'hair' SubClassOf (in_taxon only 'Mammalia')`

This would be sufficient for HermiT to detect the unsatisfiability of 'whisker in catfish' (assuming taxon sibling disjointness). Unfortunately, `only` restrictions are not part of OWL EL. Instead of adding the `only` restrictions, we can generate an extra disjointness axiom for every taxon disjointness in the taxonomy ontology, e.g.:

- `(in_taxon some 'Tetrapoda') DisjointWith (in_taxon some 'Teleostei')`

The addition of axioms like that is sufficient to detect the unsatisfiability of 'whisker in catfish' in both HermiT and ELK. This is the explanation:

- `'whisker in catfish' EquivalentTo ('whisker' and (in_taxon some 'Siluriformes'))`
- `'whisker' SubClassOf 'hair'`
- `'hair' SubClassOf (in_taxon some 'Mammalia')`
- `'Mammalia' SubClassOf 'Tetrapoda'`
- `'Siluriformes' SubClassOf 'Teleostei'`
- `(in_taxon some 'Teleostei') DisjointWith (in_taxon some 'Tetrapoda')`

While we can now detect two of the unsatisfiable classes, sadly neither HermiT nor ELK yet finds 'whisker muscle in human' to be unsatisfiable, which requires handling the interaction of a "never" assertion with a property chain. If we were able to make `in_taxon` a functional property, HermiT should be able to detect the problem; but as we said before, OWL doesn't allow us to combine functional properties with property chains. The solution for HermiT also works for ELK (in combination with the extra disjointness we added in the previous case); we need to add even more generated disjointness axioms, one for each taxon, e.g.,:

- `(in_taxon some Hominidae) DisjointWith (in_taxon some (not Hominidae))`

We also need to add another axiom to the translation of each never_in_taxon assertion, e.g.,:

- `in_taxon some (not 'Hominidae')`

Now both HermiT and ELK can find 'whisker muscle in human' to be unsatisfiable. This is the explanation:

- `'whisker muscle in human' EquivalentTo ('whisker muscle' and (in_taxon some 'Homo sapiens'))`
- `'Homo sapiens' SubClassOf 'Hominidae'`
- `'whisker muscle' SubClassOf (part_of some 'whisker')`
- `'whisker' SubClassOf (in_taxon some ('not 'Hominidae'))`
- `part_of o in_taxon SubPropertyOf in_taxon`
- `(in_taxon some 'Hominidae') DisjointWith (in_taxon some (not 'Hominidae'))`

## How to add taxon restrictions:

Please see how-to guide on [adding taxon restrictions](../howto/add-taxon-restrictions.md)

## Why annotation for some taxon restrictions?

Annotations for taxon restrictions are used as a shortcut. These are used to more simply represent complex description.
Shortcuts work as a macro that is expanded out (see [this document](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#7) for technical details):

`Eg C never_in_taxon T -> C disjointWith in-taxon some T`
