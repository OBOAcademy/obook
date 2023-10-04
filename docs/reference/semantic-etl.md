# The 3 phases of Semantic Data Engineering / ETL

<a href="../reference/obook-maturity-indicator"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2FOBOAcademy%2Fobook%2Fmaster%2Fdocs%2Fresources%2Fobook-badge-development.json" /></a>

Semantic Data Engineering or Semantic Extract-Transform-Load (ETL) is an engineering discipline that is concerned with extracting information from a variety of sources, linking it together into a knowledge graph and enabling a range of semantic analyses for downstream users such as data scientists or researchers.

1. Getting Data
   1. Information Extraction from text
   1. Obtaining data from external sources
   1. In-house biocuration
2. Integrating data
   1. Entity Resolution: Make sure that if your sources talk about the same things, they use the same ontologies to reference those things.
   1. Knowledge merging: Combine the resolved sources into a coherent whole, for example a knowledge graph.
3. Analysis: Query the integrated data and run advanced analyses using Semantic Technologies (next week).

## Glossary:

The following glossary only says how we use the terms we are defining, not how they are defined by some higher authority.

| Term | Definition | Example |
| ---- | ----- | ----- |
| Entity | An entity is a thing in the world, like a molecule, or something more complex, like a disease. Entities do not have to be material, they can be processes as well, like cell proliferation. | Marfan syndrome, H2O molecule, Ring finger, Phone |
| Term | A term is a sequence of characters (string) that refers to an *entity* in a precise way. | SMOKER (referring to the role of being a smoker), HP:0004934 (see explanations below) |
| Relation | A link between two (or more) entities that signifies some kind of interaction. | `:A :loves :B`, `:smoking :causes :cancer` |
| Property | A type of relation. | The `:causes` in `:smoking :causes :cancer` |

## Getting the data

As a Semantic Engineer, you typically coordinate the data collection from three largely separate sources:
1. Unstructured text, for example a corpus of scientific literature
2. External biological databases, such as [STRING](https://string-db.org/), a database of Protein-Protein Interaction Networks.
3. Manual in-house [bio-curation](https://en.wikipedia.org/wiki/Biocuration) efforts, i.e. the manual translation and integration of information relevant to biology (or medicine) into a database.

Here, we are mostly concerned with the automated approaches of Semantic ETL, so we briefly touch on these and provide pointers to the others.

### Information Extraction from text

The task of information extraction is concerned with extracting information from unstructured textual sources to enable identifying entities, like diseases, phenotypes and chemicals, as well as classifying them and storing them in a structured format.

The discipline that is concerned with techniques for extracting information from text is called Natural Language Processing (NLP).

NLP is a super exciting and vast engineering discipline which goes beyond the scope of this course. NLP is concerned with many problems such as document classification, speech recognition and language translation. In the context of information extraction, we are particularly interested in Named Entity Recognition (NER), and Relationship Extraction (ER).

#### [Named Entity Recognition](https://monkeylearn.com/blog/named-entity-recognition/) 
Named Entity Recognition (NER) is the task of identifying and categorising entities in text. NER tooling provides functionality to first isolate parts of sentence that correspond to things in the world, and then assigning them to categories (e.g. Drug, Disease, Publication).

For example, consider this sentence:

```
As in the X-linked Nettleship-Falls form of ocular albinism (300500), the patients showed reduced visual acuity, photophobia, nystagmus, translucent irides, strabismus, hypermetropic refractive errors, and albinotic fundus with foveal hypoplasia.
```

An NER tool would first identify the relevant sentence parts that belong together:

```
As in the [X-linked] [Nettleship-Falls] form of [ocular albinism] (300500), the patients showed [reduced visual acuity], [photophobia], [nystagmus], [translucent irides], [strabismus], [hypermetropic refractive errors], and [albinotic fundus] with [foveal hypoplasia].
```

And then categorise them according to some predefined categories:

```
As in the Phenotype[X-linked] [Nettleship-Falls] form of Disease[ocular albinism] (300500), the patients showed Phenotype[reduced visual acuity], Phenotype[photophobia], Phenotype[nystagmus], Phenotype[translucent irides], Phenotype[strabismus], Phenotype[hypermetropic refractive errors], and Phenotype[albinotic fundus] with Phenotype[foveal hypoplasia].
```

_Interesting sources for further reading:_

- [Using Uberon for text mining](https://github.com/obophenotype/uberon/wiki/Using-uberon-for-text-mining)
- [Named Entity Recognition with NLTK and SpaCy](https://towardsdatascience.com/named-entity-recognition-with-nltk-and-spacy-8c4a7d88e7da)
- [NLP Sandbox](https://sagebionetworks.org/in-the-news/introducing-nlpsandbox-io/)
- [Named Entity Recognition with Gilda]()  # TODO write something on this

#### [Relationship extraction](http://nlpprogress.com/english/relationship_extraction.html)

Relationship extraction (RE) is the task of extracting semantic relationships from text. 
RE is an important component for the construction of Knowledge Graphs from the Scientific Literature, a task that many Semantic Data Engineering projects pursue to  augment or inform their manual curation processes. 

_Interesting sources for further reading:_

- http://nlpprogress.com/english/relationship_extraction.html
- https://github.com/roomylee/awesome-relation-extraction
- https://www.indra.bio/

### Other data sources and in-house curation efforts

- Scientific data sources relevant to work around genes, phenotypes and diseases are plentiful. See [here](https://monarchinitiative.org/about/data-sources) for an overview of the data sources used by the Monarch Initiative. All of the sources listed are part of a Semantic ETL pipeline involving the extraction of the data from data dumps (like published spreadsheets) or Web APIs, the transformation into a common format (including mapping to ontologies) and its subsequent load into the [Monarch Knowledge Graph](https://monarchinitiative.org/). More comprehensive lists are being produced in the academic literature, for example [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC29860/).
- In-house biocuration. [Biocuration](https://en.wikipedia.org/wiki/Biocuration#:~:text=Biocuration%20is%20the%20field%20of,biocurators%2C%20software%20developers%20and%20bioinformaticians.) is the task of manual translation and integration of information relevant to biology (or medicine) into some kind of database form. Biocuration can take many forms:
  - The curation of scientific literature, i.e. extracting structured metadata from scientific papers to increase discoverability of relevant knowledge. The object of the curation is usually a particular publication, which goes through a triage process (Is the paper relevant to my problem? Is it good enough?), an initial metadata extraction phase (titles, authors, etc), and eventually to extracting the scientific knowledge (not unlike what the Named Entity Recongnition and Relation Extraction procedures described [above](#Information-Extraction-from-text)) do.
  - The focussed curation of specific scientific entities, such as diseases. For example, you may be interested in discovering all therapeutic interventions / drugs used for treating a specific disease.
  
## Integrating data

There is a huge amount of literature and tutorials on the topic of integrating data, the practice of consolidating data from disparate sources into a single dataset. We want to emphasise here two _aspects_ of data integration, which are of particular importance to the Semantic Data engineer.

1. Entity Resolution: Make sure that if your sources talk about the same things, they use the same ontologies to reference those things.
1. Knowledge merging: Combine the resolved sources into a coherent whole, for example a knowledge graph.

### Entity Resolution (ER):

Entity resolution (ER), sometimes called "record linking" or "grounding", is the task of disambiguating records that correspond to real world entities across and within datasets. This task as many dimensions, but for us, the most important one is mapping a string, for example the one that was matched by our Named Entity Recognition pipeline, to ontology terms.

Given our example:

```
As in the Phenotype[X-linked] Nettleship-Falls form of Phenotype[ocular albinism] (300500), the patients showed Phenotype[reduced visual acuity], Phenotype[photophobia], Phenotype[nystagmus], Phenotype[translucent irides], Phenotype[strabismus], Phenotype[hypermetropic refractive errors], and Phenotype[albinotic fundus] with Phenotype[foveal hypoplasia].
```

We could end up, for example, resolving ocular albinism to [HP:0001107](https://monarchinitiative.org/phenotype/HP:0001107).

There are a lot of materials about Entity Resolution in general:
- https://www.districtdatalabs.com/basics-of-entity-resolution
- https://www.sciencedirect.com/topics/computer-science/entity-resolution
- https://github.com/gyorilab/gilda

In effect the term _Ontology Mapping_, which is the focus of this lesson, is _Entity Resolution_ for ontologies - usually we don't have problem to use the two terms synonymously, although you may find that the literature typically favours one or the other.

### Knowledge Graph / Ontology merging

Knowledge, Knowledge Graph or Ontology Merging are the disciplines concerned with combining all your data sources into a semantically coherent whole. This is a very complex research area, in particular to do this in a way that is semantically consistent. There are essentially two separate problems to be solved to achieve semantic merging:
1. The entities aligned during the entity resolution process must be aligned in the semantically correct way: if you you use logical equivalence to align them (`owl:equivalentClasses`) the classes must mean absolutely the same thing, or else you may run into the [hairball problem](https://www.biorxiv.org/content/10.1101/048843v3), in essence faulty equivalence cliques. In cases of close, narrow or broadly matching classes, the respective specialised semantically correct relationships need to be used in the merging process.
2. The axioms of the merged ontologies must be logically consistent. For example, one ontology may say: _a disease is a material entity_. Another: _a disease is a process_. A background, or upper, ontology such as the ubiquitous [Basic Formal Ontology (BFO)](http://www.obofoundry.org/ontology/bfo.html) furthermore says that a _process is not a material entity and vice versa_. Merging this two ontologies would cause logical inconsistency.

Unfortunately, the literature on ontology and knowledge graph merging is still sparse and very technical. You are probably best off checking out the OpenHPI course on [Ontology Alignment](https://www.youtube.com/watch?v=VJHKcq_GuxY&ab_channel=OpenHPITutorials), which is closely related.