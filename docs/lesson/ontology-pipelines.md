# Ontology Pipelines with ROBOT and SPARQL

### Warning
These materials are under construction and may be incomplete.

## Prerequisites
- [Install ROBOT](http://robot.obolibrary.org) so you can use it outside of Docker (scroll down to the end of the ROBOT page to find the Windows instructions)
- **Optional** [Install ODK](../howto/odk-setup.md). The ODK includes ROBOT. In the more advanced parts of the course, you will need the ODK installed for some of the other dependencies it includes, and for Windows users it is often easier to follow the tutorials from inside the docker container rather than the Windows CMD.
- Familiarise yourself with the [ROBOT documentation](http://robot.obolibrary.org), to the point that you are aware of the various commands that exist.

## Tutorials
- Complete the [ROBOT Mini-Tutorial 1](../tutorial/robot-tutorial-1.md) to learn your first ROBOT commands: `convert`, `extract` and `template`
- Complete the [ROBOT Mini-Tutorial 2](../tutorial/robot-tutorial-2.md) to learn about `annotate`, `merge`, `reason` and `diff`
- Complete [Running Basic SPARQL Queries](https://medium.com/virtuoso-blog/dbpedia-basic-queries-bc1ac172cc09) tutorial (~45 minutes - 1 hour)

## What is delivered as part of the course

**Description:**  There are two basic ways to edit an ontology: (1) manually, using tools such as Protege, or (2) using computational tools such as ROBOT. Both have their advantages and disadvantages: manual curation is often more practical when the required ontology change follows a non-standard pattern, such as adding a textual definition or a synonym, while automated approaches are usually much more scalable (ensure that all axioms in the ontology are consistent, or that imported terms from external ontologies are up-to-date or that all labels start with a lower-case letter). Here, we will do a first dive into the "computational tools" side of the edit process. We strongly believe that the modern ontology curator should have a basic set of computational tools in their Semantic Engineering toolbox, and many of the lessons in this course should apply to this role of the **modern ontology curator**. [ROBOT](http://robot.obolibrary.org/remove) is one of the most important tools in the Semantic Engineering Toolbox. For a bit more background on the tool, please refer to the [paper](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-019-3002-3). We also recommend to get a basic familiarity with SPARQL, the query language of the semantic web, that can be a powerful combination with ROBOT to perform changes and quality control checks on your ontology.

<!--
We will continue to combine our previous work into workflows for daily ontology development in OBO. First, we will learn a few more ROBOT commands to help us edit and release ontologies: [`merge`](http://robot.obolibrary.org/merge), [`reason`](http://robot.obolibrary.org/reason), and [`annotate`](http://robot.obolibrary.org/annotate). Then, we will get an introduction to [GNU Make](https://www.gnu.org/software/make/) and see how Makefiles are used for creating ontology releases. Finally, we will learn how to use the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) (ODK) to start a new ontology and see how ROBOT and Makefiles are combined.

By the end of this unit, you should be able to:
- Find terms from other ontologies to reuse in your ontology
- Extract those terms from the external ontology using ROBOT and import them into your ontology
- Identify ontology design patterns for the logical definitions in your ontology
- Create ROBOT templates using the ontology design patterns and use them to add to your ontology
-->



## Additional materials and resources

## Contributors
- [Becky Jackson](https://orcid.org/0000-0003-4871-5569)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)
