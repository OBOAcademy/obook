# Ontologies: Fundamentals

## Prerequisites
- Install Protege
- 

## Preparation
- Complete OpenHPI [Week 5: Ontology Engineering](https://open.hpi.de/courses/semanticweb2015/items/1iXXFr86raHqrB5bRBJZeM) videos 5.1, 5.2, and 5.4 - 5.6 (~2.5 hours)
  - We are skipping **5.3: Ontology Learning** and both sections on **MORE Ontology Evaluation** (5.7 and 5.8)
- Complete part of the **Ontologies 101 Tutorial** (~2 hours)
 - Clone the [Ontologies 101](https://github.com/OHSUBD2K/BDK14-Ontologies-101) repository, then open the folder `BDK14_exercises` from your file system
 - Open `basic-subclass/chromosome-parts.owl` in Protégé, then do the following exercises:
   - [Basic Subclass Hierarchy](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicSubclassHierarchy.html) (review) - make sure to look at the "detailed instructions" for adding annotations here, as it will go over adding annotations on annotation assertions
   - [Disjointness](https://ontology101tutorial.readthedocs.io/en/latest/Disjointness.html)
   - [Object Properties](https://ontology101tutorial.readthedocs.io/en/latest/ObjectProperties.html) - note that you will rarely, if ever, be making object properties, as most of the properties you'll ever need are defined in the [Relation Ontology](http://www.obofoundry.org/ontology/ro.html)
   - [OWL Class Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/OWL_ClassRestrictions.html)
 - Open `basic-restriction/er-sec-complex.owl` in Protégé, then do the following exercise:
   - [Basic Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicRestrictions.html)
 - Open `basic-dl-query/cc.owl` in Protégé, then do the following exercises:
   - [DL Query Tab](https://ontology101tutorial.readthedocs.io/en/latest/DL_QueryTab.html) - note that `owl:Nothing` is defined as the very bottom node of an ontology, therefore the DL query results will show `owl:Nothing` as a subclass. This is expected and does not mean there is a problem with your ontology! It's only bad when something is a subclass of `owl:Nothing` and therefore *unsatisfiable* (more on that below).
   - [Basic DL Queries](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicDL_Queries.html)
 - Open `basic-classification/ubiq-ligase-complex.owl` in Protégé, then do the following exercises:
   - [Basic Classification](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicClassification.html)
- Read [(I can't get no) satisfiability](http://ontogenesis.knowledgeblog.org/1329/) (~10 minutes)
 - **Optional**: Open a new ontology in Protégé. Try creating an *inconsistent* ontology using the classes and instances in the first Pets example (hint: you'll also need to create the "eats" object property)... what happens when you run the reasoner? Don't spend too much time on this if you get stuck, we'll look at an example of an inconsistent ontology in our session.

## What is delivered as part of the course

**Description:**  Learn the fundamentals of ontologies. 

### Learning objectives
- OpenHPI course review: questions? (~15 minutes)
- OWL ontology serializations ("formats") (~15 minutes)
- Converting between serializations with [`robot convert`](http://robot.obolibrary.org/convert) (Review; ~15 minutes)
- Creating modules from existing ontologies (~30 minutes)
  - What is a module?
  - How do we use the modules in our ontologies?
  - Extraction methods: MIREOT vs. SLME
- Creating a module to import with [`robot extract`](http://robot.obolibrary.org/extract) (Review; ~15 minutes)
- Ontology design patterns (~15 minutes)
  - Real world example: Ontology for Biomedical Investigations (OBI)
- Using design patterns in [`robot template`](http://robot.obolibrary.org/template) (Review; ~15 minutes)
- Including your modules in your ontology as imports


## Tutorials


## Additional materials and resources

## Contributors
- add name/ORCID here