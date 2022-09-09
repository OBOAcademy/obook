# Week 4:

**First Instructor:** Nicole Vasilevsky  
**Second Instructor:** Nico Matentzoglu

## Description

This week will cover the history of ontologies, ontology logic (predicate logic, OBO formal ontology logic, description logic), and OWL. We will cover the basic principles of ontology engineering, including basic features of the ontology software, Protege, and the use of reasoners (ELK).

## Learning objectives

By the end of this session you should:

1. Be able to explain why we need ontologies
2. Build a basic ontology yourself
3. Be able to create a branch in GitHub, make edits in Protege and create a pull request
4. Know how to write a good ticket on the issue tracker

## Preparation this week

### Esssential

#### OpenHPI Course Content

- [Ontologies and Logic](https://open.hpi.de/courses/semanticweb2015/items/2oYC9PkLYvxv4InZuBMBVl) (Videos 3.0-3.10 | **Duration:** ~3.5 hrs)
- [OWL, Rules, and Reasoning](https://open.hpi.de/courses/semanticweb2015/items/2oCcvFX4bzhBbNWE6EVpoV) (Videos 4.0-4.8 | **Duration:** ~2.7 hrs)

#### Download/Install software

Participants will need to have access to the following resources and tools prior to the training:

- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home) (_this should alredy be done_)
- **Protege** - Please install Protege 5.5, download it [here](https://protege.stanford.edu/)

#### Install **ELK 0.5**

- - Click here to get the latest [Protege Plugin latest build](https://oss.sonatype.org/service/local/artifact/maven/content?r=snapshots&g=org.semanticweb.elk&a=elk-distribution-protege&e=zip&v=LATEST) (this is available on the bottom of [ELK pages](https://github.com/liveontologies/elk-reasoner/wiki/GettingElk). This will download a zipped file.)

  - When downloaded, unzip and copy puli and elk jars (two .jar files) in the unpacked directory.
  - Paste these files in your Protege plugin directory.

##### Install ELK plugin on Mac:

This can be done via one of two ways:

#### Approach 1

1. Paste these files in your Protege plugin directory. This is in one of two locations:
   - ~/.Protege/plugins (note this is usually hidden from finder, but you can see it in the terminal) or
   - Go to Protege in Applications (Finder), right click, 'Show package contents' -> Java -> plugins
1. Copy and paste the two files into the plugins directory
1. Restart Protege. You should see ELK 0.5 installed in your Reasoner menu.

For a video showing how to install Elk on a Mac, click [here](https://www.dropbox.com/s/n3td2n48xmwd3mj/Install_ELK_0.5.mov?dl=0)

#### Approach 2

1. In Terminal:
   `open ~/.Protege, then click on plugins`
2. Click on plugins
3. Copy and paste the two files into the plugins directory
4. Restart Protege. You should see ELK 0.5 installed in your Reasoner menu.

Important: it seems Elk 0.5. Does not work with all versions of Protege, in particular, 5.2 and below. These instructions were only tested with Protege 5.5.

### Install GitHub Desktop

Please make sure you have some kind of git client installed on your Machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

### Clone Mondo repo

Follow these instructions to [clone the Mondo repo](clone-mond-repo.md)

### Support and Additional Resources

- [Ontology tutorials and Resources](https://tislab.org/ontologyResources.html)
- [Monkeying around with OWL: Musings on building and using ontologies, posts by Chris Mungall](https://douroucouli.wordpress.com/)
- [Documentation on Cell Ontology relations](https://github.com/obophenotype/cell-ontology/blob/master/documentation/relations_guide.md)
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)

### Semantic Engineer Toolbox

- [Protege](https://protege.stanford.edu/)
- [ELK Protege Plugin](https://oss.sonatype.org/service/local/artifact/maven/content?r=snapshots&g=org.semanticweb.elk&a=elk-distribution-protege&e=zip&v=LATEST)
- [GitHub Desktop](https://desktop.github.com/)

## Week 04 Content

1. Ontology principles, formalism, semantics (Nico) (~30 min)
2. Protege tutorial (Nicole) (~90 min):

- Review of the Protege interface (Emily and Daniel)

  - questions about [pizza tutorial](https://www.michaeldebellis.com/post/new-protege-pizza-tutorial)
  - any issues with installing Protege or GitHub desktop?
  - Make sure Emily and Daniel have access to [Mondo repo](https://github.com/monarch-initiative/mondo/settings/access)

- Protege tutorial (Nicole)
  1. Download the Mondo ontology from GitHub (see instructions [here](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/github-workflow.md)).
  2. Open Mondo in Protege and browse and [search Mondo](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/SearchingMondo.md).
  3. Do [basic edits in Mondo](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/editing-mondo.md) and make a [pull request](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/pull-request.md) (PR).
  4. [Add new terms to Mondo](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/add-new-terms.md) and make a [PR](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/pull-request.md).
  5. [Class Description View and adding superclass assertions](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/class-description-view.md)
  6. [Basics of writing a good ticket](https://docs.google.com/presentation/d/1xcw--zXZsN5fGogagRjhuaeh_h7DJKZZm0JClcKQ8Y8/edit#slide=id.g9b7706cb95_0_95)
  7. Practice creating a ticket for a new term request in [GitHub](https://github.com/nicolevasilevsky/c-path-practice)
