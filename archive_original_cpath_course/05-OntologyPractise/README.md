# Week 5: Ontology Practise

**First Instructor:** Becky Jackson  
**Second Instructor:** Nico Matentzoglu

## Description

This week, we will get more into ontology development, debugging, and quality control. This includes use of OWL class restrictions for automatic classification and use of the DL query tab in Protégé. We will also introduce the [ROBOT command line tool](http://robot.obolibrary.org) and show how it can be used for quality control of the ontology (`robot report`) and for easy summaries of the terms (`robot query`).

By the end of this session, you should be able to:

1. Add logic to terms using OWL class restrictions and understand resulting automatic classifications
2. Query the ontology using the DL query tab
3. Check that the ontology is in good shape by running `robot report`
4. Generate files containing term details from simple SPARQL queries using `robot query`

## Preparation

This week is all hands on - no videos to watch! Please follow the steps below and if you run into any problems, please do not hesitate to email me (Becky). Remember that ROBOT is included in the Docker container, so it is not necessary to download and install ROBOT, but you might want it for future work!

For the tutorial, don't worry too much about the IDs. You can continue to use the auto-generated IDs that we set up last week with the `MONDO` prefix. If you want to play around with changing the prefix, you can go to Preferences > New entities and change the prefix from `MONDO_` to `GO_`. If you don't want to mess with your settings, though, that's OK!

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
    - [DL Query Tab](https://ontology101tutorial.readthedocs.io/en/latest/DL_QueryTab.html) - note that `owl:Nothing` is defined as the very bottom node of an ontology, therefore the DL query results will show `owl:Nothing` as a subclass. This is expected and does not mean there is a problem with your ontology! It's only bad when something is a subclass of `owl:Nothing` and therefore _unsatisfiable_ (more on that below).
    - [Basic DL Queries](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicDL_Queries.html)
  - Open `basic-classification/ubiq-ligase-complex.owl` in Protégé, then do the following exercises:
    - [Basic Classification](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicClassification.html)
- Read [(I can't get no) satisfiability](http://ontogenesis.knowledgeblog.org/1329/) (~10 minutes)
  - **Optional**: Open a new ontology in Protégé. Try creating an _inconsistent_ ontology using the classes and instances in the first Pets example (hint: you'll also need to create the "eats" object property)... what happens when you run the reasoner? Don't spend too much time on this if you get stuck, we'll look at an example of an inconsistent ontology in our session.
- Complete [Running Basic SPARQL Queries](https://medium.com/virtuoso-blog/dbpedia-basic-queries-bc1ac172cc09) tutorial (~45 minutes - 1 hour)
- **Optional**: [download ROBOT](http://robot.obolibrary.org) so you can use it outside of Docker (scroll down to find the Windows instructions)

## Outline

- Review & answer questions about the homework (~30 minutes)
  - OWL axioms (restrictions, equivalent & disjoint class axioms)
  - Reasoning: classification and debugging
- [ROBOT report](http://robot.obolibrary.org/report) (~45 minutes)
  - Download [`example.owl`](https://raw.githubusercontent.com/jamesaoverton/obook/master/05-OntologyPractise/example.owl), or get it via the command line:
    ```
    curl https://raw.githubusercontent.com/jamesaoverton/obook/master/05-OntologyPractise/example.owl > example.owl
    ```
  - [What `report` checks for](http://robot.obolibrary.org/report_queries/)
  - Let's try it out!
  - Hands-on practice fixing common errors
- [ROBOT query](http://robot.obolibrary.org/query) (~45 minutes)
  - Writing simple SPARQL queries (review)
  - Let's try it out!

## Semantic Engineer Toolbox

- Protégé (continued)
  - [DL Query Tab](https://protegewiki.stanford.edu/wiki/DLQueryTab)
- [ROBOT](http://robot.obolibrary.org)
