# Automating Ontology Development Workflows

## Prerequisites
- Review tutorial on [Application Ontology Development](/redesign/05_applicationOntologyDevelopment.md)
- **Optional**: [download ROBOT](http://robot.obolibrary.org) so you can use it outside of Docker (scroll down to find the Windows instructions)


## Preparation
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
- Complete [Running Basic SPARQL Queries](https://medium.com/virtuoso-blog/dbpedia-basic-queries-bc1ac172cc09) tutorial (~45 minutes - 1 hour)
- Complete OpenHPI [Week 5: Ontology Engineering](https://open.hpi.de/courses/semanticweb2015/items/1iXXFr86raHqrB5bRBJZeM) videos 5.1, 5.2, and 5.4 - 5.6 (~2.5 hours)
  - We are skipping **5.3: Ontology Learning** and both sections on **MORE Ontology Evaluation** (5.7 and 5.8)
- Complete the [ROBOT Mini-Tutorial](https://github.com/jamesaoverton/obook/blob/master/06-OntologyDesign/ROBOT_tutorial.md) to learn three new ROBOT commands

## What is delivered as part of the course

**Description:**  We will learn about building high quality ontologies with reuse and design patterns. First, we will cover the various "flavors" of ontology languages. We will talk about how to reuse pieces of existing ontologies as imports. Then, we will dive deeper into using the ROBOT command line tool to extract these import modules and build full ontologies from design patterns in spreadsheets (ROBOT templates).

By the end of this unit, you should be able to:
- Find terms from other ontologies to reuse in your ontology
- Extract those terms from the external ontology using ROBOT and import them into your ontology
- Identify ontology design patterns for the logical definitions in your ontology
- Create ROBOT templates using the ontology design patterns and use them to add to your ontology


### Learning objectives
- Unix shell
- Make
- Advanced Git, GitHub
- ROBOT
- ODK

## Tutorials
- in person or video (link videos here as they become available)

## Additional materials and resources

## Contributors
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)