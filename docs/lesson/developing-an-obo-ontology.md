# Developing an OBO Reference Ontology

### Warning
These materials are under construction and incomplete.

## Prerequisites
- Review tutorial on [Ontology Development Automation](automating-ontology-workflows.md)

## Preparation
- TBD

## What is delivered as part of the course

**Description:** Leading a new or existing OBO project; maybe reference ontology develoment?

### Learning objectives
- detailed knowledge of OBO principles and best practises
- use OBO Dashboard
- use OBO Registry
- use PURL system

## Tutorials

# Week 8: Ontology Development

**First Instructor:** Nico Matentzoglu, Becky Jackson  

## Description

By the end of this session, you should be able to:

- Merge ontology modules & imports with `robot merge`
- Create a classified version of an ontology with `robot reason`
- Add metadata to an ontology with `robot annotate`
- Create a simple release workflow using ROBOT commands in a Makefile
- Create a new ontology with ODK

## Preparation

Please complete the following and then read the section below:
- [ROBOT Mini-Tutorial, part 2](../tutorial/robot-tutorial-2.md)
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


- Review the ROBOT commands we've learned so far (Becky; review; 30 minutes)
    - Week 5: [`report`](http://robot.obolibrary.org/report) and [`query`](http://robot.obolibrary.org/query)
    - Week 6: [`convert`](http://robot.obolibrary.org/convert), [`extract`](http://robot.obolibrary.org/extract), and [`template`](http://robot.obolibrary.org/template)
    - New: [`merge`](http://robot.obolibrary.org/merge), [`reason`](http://robot.obolibrary.org/reason), [`annotate`](http://robot.obolibrary.org/annotate), and [`diff`](http://robot.obolibrary.org/diff)
    - [Chaining ROBOT commands](http://robot.obolibrary.org/chaining)
    - Specifying [custom prefixes](http://robot.obolibrary.org/global#prefixes)
- Introduction to Makefiles & workflows (Becky; review; 30 minutes)
    - Review Software Carpentry course content
    - How can the ROBOT commands be combined to create an ontology release?
    - Practice writing recipes using ROBOT commands
- Using the ODK to [bootstrap a new ontology](https://github.com/INCATools/ontology-development-kit/blob/master/docs/CreatingRepo.md) (Nico; 45 minutes)
- Introduction to the [OBO Foundry Registry](http://obofoundry.org/) (if time)


## Additional materials and resources

## Contributors
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)
