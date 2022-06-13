# How to create an OBO ontology from scratch

**Editors**:

* Nicolas Matentzoglu (@matentzn)
* Sabrina Toro (@sabrinatoro)

**Summary**:

This is a guide to build an **OBO ontology** from scratch. We will focus on the kind of thought processes you want to go through, and providing the following:

- Reasons for [NOT building an ontology](#minimal-conditions)
- A basic [recipe for getting started](#recipe)
- An overview of different [starting points](#starting-points) on your journey to building an ontology
- A guide for deciding [what kind of ontology](#project-domain) you want to build
- An [example](#example) walk-through of the process.

<a name="minimal-conditions"></a> 

## Minimal conditions for building an ontology

Before reading on, there are three simple rules for when _NOT_ to build an ontology everyone interested in ontologies should master, like a mantra:

Do not build a new ontology if:

1. one _in scope_ already _exists_ (none-in-scope condition).
2. _something simpler_ than a full-fledged OWL ontology _can do the job_ (something-simpler-works condition).
3. there is not _at least one glass-clear use case_ written down which could be addressed by the existence of the ontology (killer-use-case condition).

<a name="scope-condition"></a> 

### None-in-scope condition

Scope is one of the hardest and most debated subjects in the OBO Foundry operation calls. There are essentially two aspects to scope:

1. The _entities you intended to model_ belong to some specific biological categories. For example `phenotype`, `disease`, `anatomical entity`, `assay`, `environmental exposure`, `biological process`, `chemical entity`. Before setting out to build an ontology, you should get a rough sense of what kind of entities you need to describe your domain. However, this is an iterative process and more entities will be revealed later on.
2. The _subject domain_ you intend to model. For example, you may want to provide an ontology to describe the domain of `Alzheimer's Disease`, which will need many different kinds of biological entities (like `anatomical entity` and `disease` classes).

As a rule of thumb, `you should NOT create a term if another OBO ontology has a branch of for entities of the same kind`. For example, if you have to add terms for assays, you should work with the [Ontology for Biomedical Investigations](https://github.com/obi-ontology/obi) to add these to their [assay branch](http://purl.obolibrary.org/obo/OBI_0000070).

Remember, the vision of OBO is to build a semantically coherent ontology for all of biology, and the individual ontologies in the OBO Foundry should be considered "modules" of this super ontology. You will find that while collaboration is _always hard_ the only way for our community to be sustainable _and compete with commercial solutions_ is to take that hard route and work together.

### Something-simpler-works condition

There are many kinds of semantic artefacts that can work for your use case:

1. Controlled vocabularies: Creating identifiers for concepts in your domain and without too much concern for logical reasoning. Some examples can be are [Linked Open Data Vocabularies (LOV)](https://lov.linkeddata.es/dataset/lov/) or [schema.org vocabularies](https://schema.org/). Sometimes a table of identifiers in an SQL database is enough.
2. Thesauri: Describe the synonyms used in your domain in a standardised fashion.
3. Taxonomies: Create a hierarchical categorisations for concepts in your domain, without any specific regards for semantics. You just create a hierarchy that "makes some sense" for your use case. Examples: [ICD10](https://www.icd10data.com/ICD10CM/Codes), [United Nations Standard Products and Services Code (UNSPSC)](https://www.ungm.org/Public/UNSPSC).
4. Semantic data models: If you need to define how terms in your database should be constrained in a semantic way (similar to a database schema), then Shape languages like [SHEX or SHACL](https://www.w3.org/2014/data-shapes/wiki/SHACL-ShEx-Comparison) may be much more suitable for your use case. See [LinkML tutorials](https://linkml.io/linkml/intro/tutorial.html) to get a sense of this: you will build a semantic data model in Yaml which can then be exported to SHACL, OWL or JSON Schema (great tutorial, useful to do no matter what).
5. Ontologies: Sets of logical axioms. If you require formal reasoning (and only then!) does it make sense to jump in the deep pit of ontology engineering. This is, by far, the hardest to build of the bunch. You will have to wrestle with Logic, Open World Assumption and many more arcane subjects.

Think of it in terms of cost. Building a simple vocabulary with minimal axiomatisation is 10x cheaper than building a full fledged domain model in OWL, and helps solving your use case just the same. Do not start building an ontology unless you have some understanding of these alternatives first.

### Killer-use-case condition

Do not build an ontology because someone tells you to or because you "think it might be useful". Write out a proper use case description, for example in the form of an [agile user story](https://www.atlassian.com/agile/project-management/user-stories), convince two or three colleagues this is worthwhile and only then get to work. Many ontologies are created for very vague use cases, and not only do they cost you time to build, they also _cost the rest of the community time_ - time it takes them to figure out that they do not want to use your ontology. Often, someone you trust tells you to build one and you believe they know what they are doing - do not do that. Question the use of building the ontology until you are convinced it is the right thing to do. If you do not care about reasoning (either for validation or for your application), do not build an ontology.

<a name="recipe"></a> 

## Basic recipe to start building an ontology

Depending on your specific starting points, the way you start will be slightly different, but some common principles apply.

1. Write down the use cases for the ontology (see above). This will determine certain design decisions later on. These should be concrete, like: controlled vocabulary for named entity recognition, logical model of a domain, auto-classification of data.
1. Make a table of all similar ontologies that exist, within and outside OBO (this requires [research](../lesson/ontology-term-use/#2-finding-good-ontologies), and is an essential part of the process). Document exactly in what way they are different from your use case, and why you need to build a new one (see [none-in-scope condition](#scope-condition) above).
1. Determine whether you have something to start from. Often, you will have a database with entities you may wish to turn into classes in your ontology. See starting points [below](#starting-points).
1. Gather [your tools](../reference/semantic-engineering-toolbox.md). You need to think about tools for at least two kinds of workflows to start with: 
    1. Curation workflows: How will you edit your ontology? Some simple ontologies are edited using tables that link to [logical templates](../lesson/templates-for-obo.md). Others are edited primarily [with Protege](../lesson/contributing-to-obo-ontologies.md).
    2. Continuous integration and release workflows: How will you import terms from other ontologies? How will you ensure the [quality](../tutorial/robot-tutorial-qc.md) of you ontology moving forward?
1. Decide on the Ontology ID (important, do not skip). Changing this later can be extremely costly. Refer to the [OBO ID policy](https://obofoundry.org/id-policy.html#allocating-idspaces) for details. An ID should be short and unique.
1. Create a basic set-up for managing your workflows. This comprises (usually) three aspects (you may wish to try and use [the Ontology Development Kit](../tutorial/setting-up-project-odk.md) - it does exactly that):
    1. Make a GitHub repository.
    1. Add your editors files (owl, tsv, whatever you decided to use) to that repository.
    1. Implement some `workflow` system, i.e. some way to run commands like `release` or `test`, as you will run these repeatedly. A typical system to achieve this is [make](https://makefiletutorial.com/), and many projects choose to encode their workflows as `make` targets ([ODK](https://github.com/INCATools/ontology-development-kit), [OBI Makfile](https://github.com/obi-ontology/obi/blob/master/Makefile)).
1. Determine the metadata and logical patterns you wish to employ for your curation. Here it is important that you determine what [kind of an ontology](#project-domain) you want to build.

**Note**: Later in the process, you also want to think about the following:

- Think about [how to manage your ontology project](../tutorial/managing-ontology-project.md): Which roles you need, and how you manage community contributions.

<a name="starting-points"></a> 

## Starting points

There are many different starting points for building an ontology:

- We _have a database or a dataset_ and want to build an ontology that covers entities in that database. As a variation, you have two or more databases that you need to integrate.
- We already _have a basic ontology_ in our domain (a cell ontology, an anatomy ontology), but need to build an extension (e.g. a species specific extension to an existing cross-species ontology).
- We _have controlled vocabulary or a list of standard or commonly used terms for a domain_ and want to formalise them in an ontology for interoperability and machine-readability, with versioning support to manage evolution. Sometimes, we may even wish to simply using ontology infrastructure (tools and best practices) to maintain a quite informal vocabulary structure.
- There _are existing ontologies_ that are, however, not _quite fit for purpose_ (even if they should be) and there's no way to make any of them right, so I have to create Yet Another Variant.
- We have a large, _hierarchical enumeration in a datamodel_ that pulls terms from many ontologies.
- We need to _build a completely new ontology_ for a domain that currently does not even have a controlled vocabulary. This case almost never happens nowadays. In this case, all domain knowledge (concepts and their relations) is somewhere in the heads of the experts.

<a name="project-domain"></a> 

## What kind of ontology do you need?

There are two fundamentally different kinds of ontologies which need to be distinguished:

1. **Project ontologies** (sometimes referred to as application ontologies) are ontologies that are developed to fulfil a specific use case, like:
    - Grouping data in your project
    - Indexing search engines or your organisation
    - Informing Natural Language Processing applications
    - Populating the biocuration interface your organisation provides to enable curators to annotate data
2. **Domain ontologies** are ontologies which seek to model a domain of discourse. In particular they:
    - Reflect scientific consensus and are therefore social and collaborative enterprises subject to change
    - Are build with re-use in mind:
       - They re-use terms from other domain ontologies
       - They provide terms intended for re-use by other ontologies
       - They work with other ontologies on implementing consistent logical patterns that apply across all domain ontologies in the community.
    - Are logically consistent with all ontologies they depend on, refer to, import.

**Some things to consider:**

- It is _extremely_ hard to build domain ontologies. Do not try to do that without a proper sustainability plan (i.e. considerable resources over multiple years).
- Project ontologies _are **not** bad domain ontologies_. Project ontologies can be build according to the same standards as domain ontologies. While controversial, the OBO Foundry is currently (March 2022) debating whether project ontologies are admissible to the OBO ontology library.
- Project ontologies can have _huge impact_. One of the most impactful ontologies in the biomedical world is the [Experimental Factor Ontology (EFO)](https://github.com/EBISPOT/efo) - a massive project ontology used for many applications from knowledge graph integration to biocuration.
- Project ontologies are allowed to _change the semantics_ of imported ontologies, for example by adding additional  axioms or even removing some - anything necessary to achieve the use case!
- Domain ontologies (in the OBO world) are _not allowed_ to change semantics of imported ontologies.
- Project ontologies can import terms from domain ontologies, and coin their own terms where necessary. This can be a good option if resources are scarce, and there is not enough time for consensus building with the community or the often lengthy contribution workflows. "I just need some terms" usually points to "I need a project ontology".
- Domain ontologies seek to model a domain exhaustively: any concept that "belongs" to that domain is a strong candidate for a term.

It is _imperative_ that it is clear which of the two you are building. Project ontologies sold as domain ontologies are a very common practice and they cause a lot of harm for open biomedical data integration.

<a name="example"></a> 

## Example: Building Vertebrate Breed Ontology

We will re-iterate some of the steps taken to develop the [Vertebrate Breed Ontology](https://github.com/monarch-initiative/vertebrate-breed-ontology). At the time of this writing, the VBO is still in early stages, but it nicely illustrates all the points above.

### Use case
[See here](https://github.com/monarch-initiative/vertebrate-breed-ontology#readme). Initial interactions with the OMIA team further determined more long term goals such as phenotypic similarity and reasoning.

### Similar ontologies
Similar ontologies. While there is no ontology OBO ontology related to breeds, the Livestock Breed Ontology (LBO) served as an inspiration (much different scale). NCBI taxonomy is a more general ontology about existing taxa as they occur in the wild.

### Starting point
Our starting point was the raw OMIA data.

- We got a list of breeds from DAD-IS, which includes name of the breed, transboundary name, species, country, and more
- We first had to understand the data and how the different pieces of data relate to each other. 
  - Some breed names are the same, but refer to either different species and/or different countries
  - Several breeds share a common "transboundary name", which represent the original breed from which they come from
- We needed to determine what a single concept / an indentifiable term would be
  - In order to define a single breed, we needed to include the name of the breed, the transboundary name (when applicable), the species, and the country
- We needed to understand the metadata and how each concepts relate to each other
  - 'breed' is an instance of 'species', therefore 'species' should be the parent term of 'breeds' (using a _is_a_ relation) 
  - when applicable, 'transboundary' should be the parent term of 'breeds'
  - Note about the concept of "species": is "species" equivalent to the NCBI Taxon representing "species"? 
    Design decision: Since `species` represents the same concept as ‘species’ in NCBI, the ontology should be built ‘on top of’ NCBI terms to avoid confusion of concepts and to avoid conflation of terms with the same concept


Warnings based on our experience:
- Always retain links to original source ids (encoding problems, update problems)
- Always add provenance to as much information as you can (where do labels come from?)

### Gather your tools

For us this was using Google Sheets, ROBOT & ODK.

## The Ontology ID

At first, we chose to name the ontology "Unified Breed Ontology" (UBO). Which meant that for everything from ODK setup to creating identifiers for our terms, we used the `UBO` prefix. Later in the process, we decided to change the name to "Vertebrate Breed Ontology". Migrating all the terms and the ODK setup from `ubo` to `vbo` required some expert knowledge on the workings of the ODK, and created an unnecessary cost. We should have finalised the choice of name first.

## Create a basic set up

1. Making a [Repo with ODK](https://github.com/monarch-initiative/vertebrate-breed-ontology)
2. Develop a [workflow that turns a Google Sheet into a component](https://github.com/monarch-initiative/vertebrate-breed-ontology/blob/master/src/ontology/vbo.Makefile).

## Determine the metadata and logical patterns you wish to employ.

- We decided to build a domain ontology, for the representation of vertebrate breeds.
- As our initial data is relatively flat, we decided to use ROBOT templates and Google Sheets to manage them.

### Some notes, need to be cleaned up (ignore)

- Creation of components: for basic information: each “layer” is built in a google sheet for example:
    - Transboundary: are children of species
    - Breeds: are children of either species or transboundary (therefore we need transboundary and species in order to be able to add breeds)
- Addition of new information as we have them
    - E.g. adding xref and synonym from OMIA
- Upcoming: xref and synonym form another database. 
- Future: Continue to add to the original document and/or create new components

### Acknowledgements

Thank you to Melanie Courtot, Sierra Moxon, John Graybeal, Chris Stoeckert, Lars Vogt and Nomi Harris for their helpful comments on this how-to.

