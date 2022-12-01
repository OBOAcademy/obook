# Finding and using Disease and Phenotype Ontologies

### Warning

These materials are under construction and incomplete.

## Prerequisites

- None

## Preparation

- Review tutorial on [Ontology Term Use](../redesign/01_ontologyTermUse.md)

## What is delivered as part of the course?

**Description:** An introduction to the landscape of disease and phenotype terminologies and ontologies, and how they can be used to add value to your analysis.

### Learning objectives

- [Become aware of the major disease and phenotype ontologies that are available](#major)
- [Be able to decide which phenotype or disease ontology to use for different use cases](#decision)
- [Understand how to leverage disease and phenotype ontologies for advanced data analytics](#analytics)
- [Have a basic understanding of how to integrate other data](#integrate)

## Tutorials

- [Video from Disease and Phenotypes c-path lesson 2021-06-16](https://www.dropbox.com/sh/c32zcq1iroh6km1/AACR5_se8epI1Qacy5aYmN08a?dl=0&preview=GMT20210616-170346_Recording_1920x1080.mp4)

## Additional materials and resources

## Contributors

- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)

<a name="major"></a>

## Major disease and phenotype ontologies that are available

A landscape analysis of major disease and phenotype ontologies that are currently available is [here](../reference/medical-ontology-landscape.md) (also available in Zenodo [here](https://zenodo.org/record/6299898#.YvM_kezMJ6od)).

<a name="decision"></a>

## Decide which phenotype or disease ontology to use for different use cases

Different ontologies are built for different purposes and were created for various reasons. For example, some ontologies are built for text mining purposes, some are built for annotating data and downstream computational analysis.

The unified phenotype ontology (uPheno) aggregates species-specific phenotype ontologies into a unified resource. Several species-specific phenotype ontologies exist, such as the [Human Phenotype Ontology](https://hpo.jax.org/app/), Mammalian Phenotype Ontology (http://www.informatics.jax.org/searches/MP_form.shtml), and many more.

Similarly to the phenotype ontologies, there are many disease ontologies that exist that are specific to certain areas of diseases, such as infectious diseases (e.g. [Infectious Disease Ontology](https://bioportal.bioontology.org/ontologies/IDO)), cancer (e.g. [National Cancer Institute Thesaurus](https://ncithesaurus.nci.nih.gov/ncitbrowser/pages/home.jsf?version=20.11e)), rare diseases (e.g. [Orphanet](https://www.orpha.net/consor/cgi-bin/index.php)), etc.

In addition, there are several more general disease ontologies, such as the [Mondo Disease Ontology](https://mondo.monarchinitiative.org/), the [Human Disease Ontology (DO)](http://www.disease-ontology.org/), [SNOMED](https://browser.ihtsdotools.org/?), etc.

Different disease ontologies may be built for different purposes; for example, ontologies like Mondo and DO are intended to be used for classifying data, and downstream computational analyses. Some terminologies are used for indexing purposes, such as the International classification of Diseases (ICD). ICD-11 is intended for indexing medical encounters for the purposes of billing and coding. Some of the disease ontologies listed on the [landscape](../reference/medical-ontology-landscape.md) contain terms that define diseases, such as [Ontology for General Medical Sciences (OGMS)](http://obofoundry.org/ontology/ogms.html) are upper-level ontologies and are intended for integration with other ontologies.

When deciding on which phenotype or disease ontology to use, some things to consider:

- Do you need a more specific ontology, such as a species-specific ontology, or do you need a more general ontology that is cross-species or covers more aspects of diseases?
- Is the ontology open and free to use?
- Does the description of the ontology describe its intended use? For example, some ontologies are built for text mining purposes, some are built for annotating data and downstream computational analysis.
- Is the ontology actively maintained?
- Does the ontology contain the terms you need? If not, is there a mechanism to request changes or add new terms? Are the ontology developers responsive to change requests on their tracker?
- Is the ontology widely used by the community? You can check things like active contributors on GitHub, usages described on the OBO Foundry page (for example http://obofoundry.org/ontology/mondo.html), published papers, and/or citations.

<a name="analytics"></a>

## Understand how to leverage disease and phenotype ontologies for advanced data analytics

<a name="integrate"></a>

## How to integrate other data
