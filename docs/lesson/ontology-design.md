# Ontology Design

### Warning
These materials are under construction and incomplete.

## Prerequisites

Participants will need to have access to the following resources and tools prior to the training:
- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)
- **Protege** - Install Protege 5.5, download it [here](https://protege.stanford.edu/)
- **[Install ELK 0.5](../howto/installing-elk-in-protege.md)** 
- **Install GitHub Desktop** Please make sure you have some kind of git client installed on your machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

## Preparation
- Review tutorial on [Ontology Term Use](ontology-term-use.md)
- Review tutorial on [Contributing to OBO Ontologies](contributing-to-obo-ontologies.md)
- Clone Mondo repo: Follow these instructions to [clone the Mondo repo](../howto/clone-mondo-repo.md)

## What is delivered as part of this course

**Description**: This course will cover reasoning with OWL.

### Learning objectives

At the end of this lesson, you should know how to do:

1. Add existential restrictions
1. Add defined classes
1. Add disjoint axioms
1. Debug unsatisfiable classes

## Tutorials
**OpenHPI Course Content**
1. [Ontologies and Logic](https://open.hpi.de/courses/semanticweb2015/items/2oYC9PkLYvxv4InZuBMBVl) Videos 3.0-3.10 | **Duration:** ~3.5 hrs  
1. [OWL, Rules, and Reasoning](https://open.hpi.de/courses/semanticweb2015/items/2oCcvFX4bzhBbNWE6EVpoV) Videos 4.0-4.8 | **Duration:** ~2.7 hrs  

## Additional Materials and Resources
- [Ontology tutorials and Resources](https://tislab.org/ontologyResources.html)
- [Monkeying around with OWL: Musings on building and using ontologies, posts by Chris Mungall](https://douroucouli.wordpress.com/)
- [Documentation on Cell Ontology relations](https://github.com/obophenotype/cell-ontology/blob/master/documentation/relations_guide.md)
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)
- [How to deal with unintentional equivalent classes](https://douroucouli.wordpress.com/2018/09/04/debugging-ontologies-using-owl-reasoning-part-2-unintentional-entailed-equivalence/): Cool post by Chris Mungall on how to deal with an important reasoning issue.

## Semantic Engineer Toolbox
- [Protege](https://protege.stanford.edu/)
- [ELK Protege Plugin](https://oss.sonatype.org/service/local/artifact/maven/content?r=snapshots&g=org.semanticweb.elk&a=elk-distribution-protege&e=zip&v=LATEST)
- [GitHub Desktop](https://desktop.github.com/)

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)

## Acknowledgement
- Content was adapted from [Ontology 101 Tutorial](https://ontology101tutorial.readthedocs.io/en/latest/)

## OWL class restrictions

In OWL, we use object properties to describe binary relationships between two individuals (or instances). We can also use the properties to describe new classes (or sets of individuals) using _restrictions_. A restriction describes a class of individuals based on the relationships that members of the class participate in. In other words, a restriction is a kind of class, in the same way that a named class is a kind of class.

For example, we can use a named class to capture all the individuals that are idiopathic diseases. But we could also describe the class of idiopathic disease as all the instances that are '_has modifier'_ idiopathic disease.

In OWL, there are three main types of restrictions that can be placed on classes. These are **quantifier restriction**, **cardinality restrictions**, and **hasValue** restriction. In this tutorial will initially focus on quantifier restrictions.

Quantifier restrictions are further categorized into two types, the **existential** and the **universal** restriction.

- **Existential** restrictions describe classes of individuals that participate in at least one relationship along a specified property to individuals that are members of a specified class. For example, the class of individuals that have at least one ( **some** ) 'has modifier' relationship to members of the `idiopathic disease` class. In Protege, the keyword **'some'** is used to denote existential restrictions.
- **Universal** restrictions describe classes of individuals that for a given property only have relationships along this property to individuals that are members of a specified class. For example, we can say a cellular component is capable of many functions using the existential quantifier, however, OWL semantics assume that there could be more. We can use the universal quantifier to add closure to the existential. That is, we can assert that a cellular component is capable of these functions, and is only capable of those functions and no other. Another example is that the process of hair growth is found **only** in instances of the class Mammalia. In Protege the keyword '**only**' is used.

In this tutorial, we will deal exclusively with the existential (some) quantifier.

## Superclass restrictions

_Strictly speaking in OWL, you don't make relationships between classes_, however, using OWL restrictions we essentially achieve the same thing.

We wanted to capture the knowledge that the named class '**idiopathic achalasia**' is an **idiopathic disease**. In OWL speak, we want to say that every instance of an ' **idiopathic achalasia**' is also an instance of the class of things that have at least one 'has modifier' relationship to an **idiopathic disease**. In OWL, we do this by creating an existential restriction on the **idiopathic achalasia** class.

1. In the Entities tab, select '**idiopathic achalasia**' in the class hierarchy and look at its current class description in the bottom right box. 
1. Note that there are two superclasses (as denoted by the SubClass Of list). '**'gastroesophageal disease'**' and **'has modifier' some idiopathic**.
1. Run the reasoner.
1. You should see that this class is now inferred to be an **idiopathic disease** because of this SubClassOf (superclass) restriction.

## Equivalence Axioms and Automatic classification

This example introduces **equivalence axioms** or **defined classes** (also called **logical definitions**) and automatic classification.

The example involves classification of Mendelian diseases that have a monogenic (single gene) varation. These equivalence axioms are based off the Mondo Deisgn Pattern [disease_series_by_gene](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/disease_series_by_gene.yaml). 

Constructs:  
- and (intersection)  
- equivalence (logical definitions)  
- existential restrictions (e.g. 'disease has basis in dysfunction of')  

### Add an equivalence axiom to an existing Mondo term
1. Create a new branch and open (or re-open) mondo-edit.obo
1. Navigate to the class `'cardioacrofacial dysplasia 1'`
1. According to [OMIM](https://omim.org/entry/619142), this disease is caused by a variation in the gene PRKACA.
1. We want to add an equivalence axiom that says every instance of this class is a type of `'cardioacrofacial dysplasia'` that has dysfunction in the PRKACA gene.
1. To do this, click the + next to Equivalent To in the lower right Description box.
1. Add the following equivalence axiom:
`'cardioacrofacial dysplasia'
 and ('disease has basis in dysfunction of' some PRKACA)`
1. Run the reasoner.
1. You shouldn't see any change, but try deleting the superclass assertion to 'cardioacrofacial dysplasia' and re-running the reasoner.
1. You should see that 'cardioacrofacial dysplasia' is an inferred superclass.
1. Undo the last change and save your work and commmit and create a pull request.

### Adding classes and automatically classifying them
For teaching purposes, let's say we need a new class that is 'fungal allergy'.

1. Create a branch and re-open mondo-edit.obo
1. Add a new term under owl:Thing named 'fungal allergy'. 
1. Following the design pattern [allergy.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergy.yaml), add the text definition, synonym and equivalentTo axiom, using the substance ECTO_0000524 'exposure to mycotoxin'.
1. Run the reasoner and note where the class is automatically classified.
1. Create a pull request and note in the PR what the parent class is.

### Debugging automatic classifications
1. On the same branch, add a new term under owl:Thing named 'oral cavity neoplasm'.
1. Following the design pattern [neoplasm_by_origin](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/neoplasm_by_origin.yaml), add the term label and the equivalence axiom.
1. Run the reasoner and note where the term in automatically classified. You should see it is under owl:Nothing.
1. Click the ? next to owl:Nothing in the Description box to see the explanation.
1. Can you determine why this is an unsatisfiable class? 
1. Create a pull request and add a comment explaining why this is unsatisfiable.

## Disjointness

By default, OWL assumes that these classes can overlap, i.e. there are individuals who can be instances of more than one of these classes. We want to create a restriction on our ontology that states these classes are different and that no individual can be a member of more than one of these classes. We can say this in OWL by creating a _disjoint classes_ axiom.

1. Create a branch in the Mondo repo (name it: disjoint-[your initials]. For example: disjoint-nv)
1. Open the mondo-edit.obo file
1. Per this [ticket](https://github.com/monarch-initiative/mondo/issues/1221), we want to assert that **infectious disease** and **'syndromic disease'** are disjoint. 
1. To do this first search for and select the **infectious disease** class. 
1. In the class 'Description' view, scroll down and select the (+) button next to Disjoint With. You are presented with the now familiar window allowing you to select, or type, to choose a class. In the Expression editor, add 'syndromic disease' as disjoint with 'infectious disease'.
1. Run the ELK reasoner.
1. Scroll to the top of your hierarchy and note that owl:Nothing has turned red. This is because there are unsatisfiable classes.

### Review and fix one unsatisfiable class

Below we'll review an example of one class and how to fix it. Next you should review and fix another one on your own and create a pull request for Nicole or Nico to review. Note, fixing these may require a bit of review and subjective decision making and the fix described below may not necessarily apply to each case.

1. Review `Bickerstaff brainstem encephalitis`: To understand why this class appeared under owl:Nothing, first click the ? next to owl:Nothing in the Description box. (Note, this can take a few minutes).

![image](https://user-images.githubusercontent.com/6722114/131927956-de79cfd5-404d-49ec-8bd9-198719ab6bd5.png)

1. The explanation is displayed above - it is because this class is a descedent of `Guillain-Barre syndrome`, which is a child of `syndromic disease`. 
1. Next, we have to ask if `Bickerstaff brainstem encephalitis` is an appropriate child of `regional variant of Guillain-Barre syndrome`. Note, Mondo integrates several disease terminologies and ontologies, and brought in all the subclass hierarchies from these source ontologies. To see the source of this superclass assertion, click the @ next to the assertion.
1. This source came from Orphanet, see below.

![image](https://user-images.githubusercontent.com/6722114/131928141-6706b3b7-f9e2-4726-84ee-7021922f9688.png)

1. Based on the text definition, there does not seem to be any suggestion that this disease is a type of Guillain-Barre syndrome.
1. Assuming that this disease is not a type of Guillain-Barre syndrome, we should exclude the superclass `regional variant of Guillain-Barre syndrome` (see this [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7524576/) and this [paper](https://jnnp.bmj.com/content/70/1/50). It seems a bit unclear what the relationship of BBE is to Guillain-Barre syndrome. This also brings into the question if a disease can be syndromic and an infectious disease - maybe this disjoint axiom is wrong, but let's not worry about this for the teaching purposes.)
1. To exclude a superclass, follow the instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/revise-terms-in-mondo/#exclude-a-superclass).



