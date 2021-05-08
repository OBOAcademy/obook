# Week 6: Ontology Design

**First Instructor:** Becky Jackson  
**Second Instructor:** James Overton

## Description
This week, we will learn about building high quality ontologies with reuse and design patterns. First, we will cover the various "flavors" of ontology languages. We will talk about how to reuse pieces of existing ontologies as imports. Then, we will dive deeper into using the ROBOT command line tool to extract these import modules and build full ontologies from design patterns in spreadsheets (ROBOT templates).

By the end of this session, you should be able to:
- Find terms from other ontologies to reuse in your ontology
- Extract those terms from the external ontology using ROBOT and import them into your ontology
- Identify ontology design patterns for the logical definitions in your ontology
- Create ROBOT templates using the ontology design patterns and use them to add to your ontology

## Preparation
- Complete OpenHPI [Week 5: Ontology Engineering](https://open.hpi.de/courses/semanticweb2015/items/1iXXFr86raHqrB5bRBJZeM) videos 5.1 - 5.6 (~2.75 hours)
- Complete the [ROBOT Mini-Tutorial](https://github.com/jamesaoverton/obook/blob/master/06-OntologyDesign/ROBOT_tutorial.md) to learn four new ROBOT commands

## Outline
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
