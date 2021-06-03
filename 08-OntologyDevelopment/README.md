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

Please complete the following and then read the section below:
- [ROBOT Mini-Tutorial, part 2](https://github.com/jamesaoverton/obook/blob/master/08-OntologyDevelopment/ROBOT_tutorial_2.md)
- Software Carpentry: [Automation and Make](http://swcarpentry.github.io/make-novice/)

#### What is an ontology release?

Like software, official OBO Foundry ontologies have **versioned releases**. This is important because OBO Foundry ontologies are expected to be shared and reused. Since ontologies are bound to change over time as more terms are added and refined, other developers need stable versions to point to so that there are no surprises. OBO Foundry ontologies use [GitHub releases](https://docs.github.com/en/github/administering-a-repository/managing-releases-in-a-repository) to maintain these stable copies of older versions.

Generally, OBO Foundry ontologies maintain an "edit" version of their file that changes without notice and should not be used by external ontology developers because of this. The edit file is used to create releases on a (hopefully) regular basis. The released version of an OBO Foundry ontology generally a **merged** and **reasoned** version of the edit file. This means that all modules and imports are combined into one file, and that file has the inferred class hierarchy actually asserted. It also often has some extra metadata, including a [version IRI](https://www.w3.org/TR/owl2-syntax/#Ontology_IRI_and_Version_IRI). OBO Foundry defines the requirements for version IRIs [here](http://obofoundry.org/principles/fp-004-versioning.html).

The release workflow process should be stable and can be written as a series of steps, e.g.:
1. Update modules from templates
2. Merge ontology modules & the main edit file into one
3. Assert the inferred class hierarchy
4. Add a version IRI & other important metadata

This series of steps can be turned into ROBOT commands:
1. `robot template`
2. `robot merge`
3. `robot reason`
4. `robot annotate`

Since we can turn these steps into a series of commands, we can create a `Makefile` that stores these as "recipes" for our ontology release!


## Outline

- Review the ROBOT commands we've learned so far (Becky; review; 30 minutes)
  - Week 5: [`report`](http://robot.obolibrary.org/report) and [`query`](http://robot.obolibrary.org/query)
  - Week 6: [`convert`](http://robot.obolibrary.org/convert), [`extract`](http://robot.obolibrary.org/extract), and [`template`](http://robot.obolibrary.org/template)
  - New: [`merge`](http://robot.obolibrary.org/merge), [`reason`](http://robot.obolibrary.org/reason), and [`annotate`](http://robot.obolibrary.org/annotate)
  - Chaining ROBOT commands
  - Specifying custom prefixes
- Introduction to Makefiles & workflows (Becky; review; 30 minutes)
  - Review Software Carpentry course content
  - How can the ROBOT commands be combined to create an ontology release?
  - Practice writing recipes using ROBOT commands
- Using the ODK to bootstrap a new ontology (Nico; 45 minutes)
- Introduction to the [OBO Foundry Registry](http://obofoundry.org/) (if time)

## Semantic Engineer Toolbox

- [GNU Make](https://www.gnu.org/software/make/)
- [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit)
