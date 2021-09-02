# Ontology Design

## Prerequisites

Participants will need to have access to the following resources and tools prior to the training:
- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)
- **Protege** - Install Protege 5.5, download it [here](https://protege.stanford.edu/)
- **[Install ELK 0.5](https://github.com/jamesaoverton/obook/blob/master/docs/howto/install_elk_0.5_protege.md)** 
- **Install GitHub Desktop** Please make sure you have some kind of git client installed on your machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

## Preparation
- Review tutorial on [Ontology Term Use](ontology_term_use.md)
- Review tutorial on [Contributing to OBO Ontologies](https://github.com/jamesaoverton/obook/blob/master/docs/lesson/contributing_to_obo_ontologies.md)
- Clone Mondo repo: Follow these instructions to [clone the Mondo repo](clone-mond-repo.md)

## What is delivered as part of this course

**Description**: This course will cover reasoning with OWL.

### Learning objectives
1. Add existential restrictions
1. Add defined classes
1. Run the reasoner
1. Debug unsatisfiable classes

## Tutorials
**OpenHPI Course Content**
 - [Ontologies and Logic](https://open.hpi.de/courses/semanticweb2015/items/2oYC9PkLYvxv4InZuBMBVl) Videos 3.0-3.10 | **Duration:** ~3.5 hrs
 - [OWL, Rules, and Reasoning](https://open.hpi.de/courses/semanticweb2015/items/2oCcvFX4bzhBbNWE6EVpoV) Videos 4.0-4.8 | **Duration:** ~2.7 hrs

## Additional Materials and Resources
- [Ontology tutorials and Resources](https://tislab.org/ontologyResources.html)
- [Monkeying around with OWL: Musings on building and using ontologies, posts by Chris Mungall](https://douroucouli.wordpress.com/)
- [Documentation on Cell Ontology relations](https://github.com/obophenotype/cell-ontology/blob/master/documentation/relations_guide.md)
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)

## Semantic Engineer Toolbox
- [Protege](https://protege.stanford.edu/)
- [ELK Protege Plugin](https://oss.sonatype.org/service/local/artifact/maven/content?r=snapshots&g=org.semanticweb.elk&a=elk-distribution-protege&e=zip&v=LATEST)
- [GitHub Desktop](https://desktop.github.com/)

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)

## Disjointness

By default, OWL assumes that these classes can overlap, i.e. there are individuals who can be instances of more than one of these classes. We want to create a restriction on our ontology that states these classes are different and that no individual can be a member of more than one of these classes. We can say this in OWL by creating a _disjoint classes_ axiom.

1. Create a branch in the Mondo repo (name it: disjoint-[your initials]. For example: disjoint-nv)
1. Open the mondo-edit.obo file
1. Per this [ticket](https://github.com/monarch-initiative/mondo/issues/1221), we want to assert that **infectious disease** and **'syndromic disease'** are disjoint. 
1. To do this first search for and select the **infectious disease** class. 
1. In the class 'Description' view, scroll down and select the (+) button next to Disjoint With. You are presented with the now familiar window allowing you to select, or type, to choose a class. In the Expression editor, add 'syndromic disease' as disjoint with 'infectious disease'.
1. Run the ELK reasoner.
1. Scroll to the top of your hierarchy and note that owl:Nothing has turned red. This is because there are unsatisfiable classes.

### Review and fix one unsatisfiable classes

Below we'll review an example of one class and how to fix it. Next you should review and fix another one on your own and create a pull request for Nicole or Nico to review. Note, fixing these may require a bit of review and subjective decision making and the fix described below may not necessarily apply to each case.

1. Review `Bickerstaff brainstem encephalitis`: To understand why this class appeared under owl:Nothing, first click the ? next to owl:Nothing in the Description box. (Note, this can take a few minutes).




