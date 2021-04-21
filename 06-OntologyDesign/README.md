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
- Complete [Ontological Engineering](https://open.hpi.de/courses/semanticweb2015/items/1iXXFr86raHqrB5bRBJZeM) from OpenHPI.

## Outline
- Ontology languages ("formats")
- Creating modules from existing ontologies
  - What is a module?
  - How do we use the modules in our ontologies? (Protege example)
  - Extraction methods: MIREOT vs. SLME
- Creating a module to import with `robot extract`
- Ontology design patterns
  - Real world example: Ontology for Biomedical Investigations (OBI)
- Using design patterns in `robot template`
- Combining modules with `robot merge`
