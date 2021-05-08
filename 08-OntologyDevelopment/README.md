# Week 8: Ontology Development

**First Instructor:** Nico Matentzoglu, Becky Jackson  

## Description

This week, we will start to combine our previous work into workflows for daily ontology development in OBO. First, we will learn a few more ROBOT commands to help us edit and release ontologies: [`merge`](http://robot.obolibrary.org/merge), [`reason`](http://robot.obolibrary.org/reason), and [`annotate`](http://robot.obolibrary.org/annotate). Then, we will get an introduction to [GNU Make](https://www.gnu.org/software/make/) and see how Makefiles are used for creating ontology releases. Finally, we will learn how to use the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) (ODK) to start a new ontology and see how ROBOT and Makefiles are combined.

By the end of this session, you should be able to:

- Merge ontology modules & imports with `robot merge`
- Create a classified version of an ontology with `robot reason`
- Add metadata to an ontology with `robot annotate`
- Create a simple release workflow using ROBOT commands in a Makefile
- Create a new ontology with ODK

## Preparation

- Complete the ROBOT Mini-Tutorial, part 2 (*TODO*)
- Complete the following course segments:
  - Software Carpentry: [Automation and Make](http://swcarpentry.github.io/make-novice/)
  - Open HPI: [Knowledge Engineering](https://open.hpi.de/courses/semanticweb2015/items/6V96GOecoS3u481LerzYx2) (*maybe*)

## Outline

- Ontology releases (Becky; 15 minutes)
- Review the ROBOT commands we've learned so far (Becky; review; 30 minutes)
  - Week 5: [`report`](http://robot.obolibrary.org/report) and [`query`](http://robot.obolibrary.org/query)
  - Week 6: [`convert`](http://robot.obolibrary.org/convert), [`extract`](http://robot.obolibrary.org/extract), and [`template`](http://robot.obolibrary.org/template)
  - New: [`merge`](http://robot.obolibrary.org/merge), [`reason`](http://robot.obolibrary.org/reason), and [`annotate`](http://robot.obolibrary.org/annotate)
- Introduction to Makefiles (Becky; review; 30 minutes)
  - Review Software Carpentry course content
  - Practice writing recipes using ROBOT commands
- Introduction to the [OBO Foundry Registry](http://obofoundry.org/) (Nico; 15 minutes)
- Using the ODK to bootstrap a new ontology (Nico; 30 minutes)

## Semantic Engineer Toolbox

- [GNU Make](https://www.gnu.org/software/make/)
- [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit)
