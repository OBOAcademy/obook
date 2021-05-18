## Add New Terms with an Equivalance Axiom to Mondo: 

Before you start:

- make sure you have set your preferences in Protege (see instructions [here](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/add-new-terms.md).
-   make sure you are working on a branch - see quick guide [here](https://docs.google.com/presentation/d/1M8NZQOIQVswng-so6ROxVeMJfDnzth7BYNj_5MXxEik/edit#slide=id.g9db6baf776_1_0).
-   make sure you have the editor's file open in Protege as detailed [here](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/SearchingMondo.md).

### Creating a new class

New classes are created in the Class hierarchy panel on the left.

There are three buttons at the top of the class hierarchy view. These allow you to add a subclass (L-shaped icon), add a sibling class (c-shaped icon), or delete a selected class (x'd circle).

![image](https://user-images.githubusercontent.com/6722114/118696258-f791d480-b7c2-11eb-836a-a594227c6da9.png)


### Practice adding a new term:

#### Add the new term 'mycotoxin allergy'

1. Search for the parent term 'allergic disease' (see [search guide](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/SearchingMondo.md) if you are unsure how to do this).
1. When you are clicked on the term in the Class hierarchy pane, click the add subclass button to add a child class to 'allergic disease'
1. A dialog will popup. Name this new subclass: mycotoxin allergy. Click "OK" to add the class.

#### Add annotations and a logical axiom 

Equivalence axioms in Mondo are added according to Dead Simple Ontology Design Patterns (DOSDPs). You can view all of the design patterns in Mondo by going to [code/src/patterns/dosdp-patterns/](https://github.com/monarch-initiative/mondo/tree/master/src/patterns/dosdp-patterns)

For this class, we want to follow the design pattern for [allergy](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergy.yaml).

1. Review this pattern before proceeding.
1. Based on the pattern specifications, add a text definition to this term.
1. Add the database cross reference to this term: MONDO:patterns/allergy
1. Add a synonym that is consistent with this pattern.
1. Add a synonym that is consistent with this pattern.

![image](https://user-images.githubusercontent.com/6722114/118697325-07f67f00-b7c4-11eb-8d6d-7f2dd9cdcd62.png)

1. Add the equivalence axiom according to the pattern specifications.




