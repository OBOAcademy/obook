# Application Ontology Development

UNDER CONSTRUCTION, DO NOT USE.

### Summary

An application ontology is an ontology which is usually composed of other ontologies for a particular use case, such as Natural Language Processing applications, Semantic Search and Knowledge Graph integration.
 
In this tutorial, we discuss the fundamental building blocks of application ontologies and show you how to build one using the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) as one of several options.

## Prerequisites

- A basic understanding of [Ontology Pipelines](../lesson/ontology-pipelines.md) using ROBOT is helpful to follow this tutorial.

### Learning objectives

- Understand how to plan an application ontology project independent of any particular methodology
- Develop an application ontology using the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit)
- Be aware off pitfalls when dealing with very large application ontologies

## Table of Contents

- [Overview](#overview)
- [The five "ingredients" of application ontologies](#ingredients)

<a id="ingredients" />

## Basic architecture

Add image.

<a id="ingredients" />

## Three "ingredients" of application ontologies

Any application ontology will be concerned with at least 3 ingredients:

- The **seed**. This is a the _set of terms you wish to import into your application ontology_. The seed can take many forms: 
  - a simple list of terms, e.g. `MONDO:123, MONDO:231`
  - a list of terms including additional _relational selectors_, e.g. `MONDO:123, incl. all children`
  - a list of terms including a _logical selector_, `MONDO:123, incl. all terms that are in some way logically related to MONDO:123`
  - There are probably more, but these are the main ones we work with in the context of biomedical application ontologies.
  - A general selector, like "all classes" or simply "everything".
- The **source ontologies**, often referred to as "mirrors" (at least by those working with ODK). These are the full ontologies which we want to use in our application ontology. For example, we may want to include anatomical entities from the [Uberon ontology](https://github.com/obophenotype/uberon) into our application ontology. These are usually downloaded from the internet into the application ontology workspace, and then processed by the application ontology extraction workflow (see later).
- Additional **ontology metadata** and **semantic glue**, i.e. axioms used to connect entities (classes) across your source ontologies to fulfil a use case. 



https://orcid.org/0000-0002-7356-1779


## Additional materials and resources
- TBD

## Contributors

- [Nicolas Matentzoglu](https://orcid.org/0000-0002-7356-1779)