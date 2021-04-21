# Week 5: Ontology Practise

**First Instructor:** Becky Jackson  
**Second Instructor:** Nico Matentzoglu

## Description
This week, we will get more into ontology development, debugging, and quality control. This includes use of OWL class restrictions for automatic classfication and use of the DL query tab in Protege. We will also introduce the [ROBOT command line tool](http://robot.obolibrary.org) and show how it can be used for quality control of the ontology (`robot report`) and for easy summaries of the terms (`robot export`).

By the end of this session, you should be able to:
1. Add logic to terms using OWL class restrictions and understand resulting automatic classfications
2. Query the ontology using the DL query tab
3. Check that the ontology is in good shape by running `robot report`
4. Generate CSVs (or TSVs!) containing term details using `robot export`

## Preparation
- Clone the [Ontologies 101](https://github.com/OHSUBD2K/BDK14-Ontologies-101) repository, then open the folder `BDK14_exercises` from your file system
- Open `basic-subclass/chromosome-parts.owl` in Protege, then do the following exercises (in order; these will build on the same file):
  - [Basic Subclass Hierarchy](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicSubclassHierarchy.html) (review)
  - [Disjointness](https://ontology101tutorial.readthedocs.io/en/latest/Disjointness.html)
  - [Object Properties](https://ontology101tutorial.readthedocs.io/en/latest/ObjectProperties.html)
  - [OWL Class Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/OWL_ClassRestrictions.html)
- Open `basic-restriction/er-sec-complex.owl` in Protege, then do the following exercise:
  - [Basic Restrictions](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicRestrictions.html)
- Open `basic-dl-query/cc.owl` in Protege, then do the following exercises:
  - [DL Query Tab](https://ontology101tutorial.readthedocs.io/en/latest/DL_QueryTab.html)
  - [Basic DL Queries](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicDL_Queries.html)
- Open `basic-classification/ubiq-ligase-complex.owl` in Protege, then do the following exercises:
  - [Basic Classification](https://ontology101tutorial.readthedocs.io/en/latest/EXERCISE_BasicClassification.html)
- **Optional**: [download ROBOT](http://robot.obolibrary.org) so you can use it outside of Docker (scroll down to find the Windows instructions)

## Outline
- OWL class restrictions
  - Named vs. anonynmous classes
  - Superclasses, equivalent classes, and disjoint classes
  - "some" (existential) vs. "only" (universal)
  - Intersections ("and"), unions ("or"), and complements ("not")
- Reasoning: classification and debugging
  - What is classification?
  - How can you use the reasoner to debug?
- The DL query tab
- [ROBOT report](http://robot.obolibrary.org/report)
  - What do we check for and why?
  - Let's try it out!
- [ROBOT export](http://robot.obolibrary.org/export)
  - Export headers & formats
  - Let's try it out!
- If time: object property domains & ranges
