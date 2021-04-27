# Week 5: Ontology Practise

**First Instructor:** Becky Jackson  
**Second Instructor:** Nico Matentzoglu

## Description

This week, we will get more into ontology development, debugging, and quality control. This includes use of OWL class restrictions for automatic classfication and use of the DL query tab in Protégé. We will also introduce the [ROBOT command line tool](http://robot.obolibrary.org) and show how it can be used for quality control of the ontology (`robot report`) and for easy summaries of the terms (`robot export`).

By the end of this session, you should be able to:
1. Add logic to terms using OWL class restrictions and understand resulting automatic classfications
2. Query the ontology using the DL query tab
3. Check that the ontology is in good shape by running `robot report`
4. Generate CSVs (or TSVs!) containing term details using `robot export`

## Preparation

This week is all hands on - no videos to watch! Please follow the steps below and if you run into any problems, please do not hesitate to email me (Becky). Remember that ROBOT is included in the Docker container, so it is not necessary to download and install ROBOT, but you might want it for future work!

- Clone the [Ontologies 101](https://github.com/OHSUBD2K/BDK14-Ontologies-101) repository, then open the folder `BDK14_exercises` from your file system
- Open `basic-subclass/chromosome-parts.owl` in Protégé, then do the following exercises (in order; these will build on the same file):
  - [Basic Subclass Hierarchy](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicSubclassHierarchy.html) (review)
  - [Disjointness](https://ontology101tutorial.readthedocs.io/en/latest/Disjointness.html)
  - [Object Properties](https://ontology101tutorial.readthedocs.io/en/latest/ObjectProperties.html)
  - [OWL Class Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/OWL_ClassRestrictions.html)
- Open `basic-restriction/er-sec-complex.owl` in Protégé, then do the following exercise:
  - [Basic Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicRestrictions.html)
- Open `basic-dl-query/cc.owl` in Protégé, then do the following exercises:
  - [DL Query Tab](https://ontology101tutorial.readthedocs.io/en/latest/DL_QueryTab.html)
  - [Basic DL Queries](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicDL_Queries.html)
- Open `basic-classification/ubiq-ligase-complex.owl` in Protégé, then do the following exercises:
  - [Basic Classification](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicClassification.html)
- **Optional**: [download ROBOT](http://robot.obolibrary.org) so you can use it outside of Docker (scroll down to find the Windows instructions)

## Outline

- OWL class restrictions (~30 minutes)
  - Named vs. anonynmous classes
  - Superclasses, equivalent classes, and disjoint classes
  - "some" (existential) vs. "only" (universal)
  - Intersections ("and"), unions ("or"), and complements ("not")
- Reasoning: classification and debugging (~30 minutes)
  - What is classification?
  - How can you use the reasoner to debug?
- Review the DL query tab (~15 minutes)
- [ROBOT report](http://robot.obolibrary.org/report) (~30 minutes)
  - Download [`example.owl`](https://raw.githubusercontent.com/jamesaoverton/obook/master/05-OntologyPractise/example.owl), or get it via the command line:
    ```
    curl https://raw.githubusercontent.com/jamesaoverton/obook/master/05-OntologyPractise/example.owl > example.owl
    ```
  - [What `report` checks for](http://robot.obolibrary.org/report_queries/)
  - Let's try it out!
  - Hands-on practice fixing common errors
- [ROBOT export](http://robot.obolibrary.org/export) (~15 minutes)
  - Export headers & formats
  - Let's try it out!
- If time: object property domains & ranges

## Semantic Engineer Toolbox

- Protégé (continued)
  - [DL Query Tab](https://protegewiki.stanford.edu/wiki/DLQueryTab)
- [ROBOT](http://robot.obolibrary.org)
