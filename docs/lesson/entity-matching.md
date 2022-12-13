# Linking across vocabularies: Semantic Entity Matching

## Summary

All across the biomedical domain, we refer to domain entities (such as chemicals or anatomical parts) using identifiers, often from controlled vocabularies.

The decentralised evolution of scientific domains has led to to the emergence of disparate "semantic spaces" with different annotation practices and reference vocabularies and formalisms. To bridge between these spaces, entity mappings have emerged, which link, for example, genes from HGNC to ENSEMBL, diseases between OMIM and Mondo and anatomical entities between FMA and Uberon.

Entity matching is the process of establishing a link between an identifier in one semantic space to an identifier in another. There are many cultures of thought around entity matching, including Ontology Matching, Entity Resolution and 

## Overview of the terminology

| Concept | Definition |
| --- | --- |
| Ontology matching | The task of determining corresponding entities across ontologies. |
| Term mapping | A mapping is a correspondence between two terms, for example, a correspondence between two classes in an ontology, elements in a data model, database entities or terms in a controlled vocabulary. |
| Ontology alignment | An ontology alignment is a set of term mappings that links all concepts in a source ontology to their appropriate correspondence in a target ontology, if any. |

## Fundamentals

The excellent [OpenHPI course on Knowledge Engineering with Semantic Web Technologies](https://open.hpi.de/courses/semanticweb2015) gives a good overview:

<iframe width="560" height="315" src="https://www.youtube.com/embed/VJHKcq_GuxY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Another gentle overview on Ontology Matching was taught as part of the Knowledge & Data course at Vrije Universiteit Amsterdam. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/gnq9I0OTjRo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Basic tutorials

1. [Mapping curation with SSSOM](../tutorial/sssom-tutorial.md)
1. [Introduction to processing mappings with SSSOM and sssom-py CLI](../tutorial/sssom-toolkit.md)


## Introduction to Ontology Mapping

In this lesson we will take a look at ontology mappings in general and how you 
may want to think about implementing them. Note that the word "mapping" is pretty
overloaded in practice: for some people, it simply means "a correspondence of one term to another equivalent or near equivalent term." 
But even here, there is little understanding to what a "term" is in this sentence, 
or what "almost equivalent" means - and, there are many different kinds of mappings used in practice that are not "equivalent" at all. In its very essence, an individual mapping maps one string to another string - how, and what these strings could be, will be the subject of the following section.

In the following, we consider a **term** a *sequence of characters which has a well defined relationship to some thing in the real world*, for example:
- an ontology id like HP:0004934 corresponds to the concept of "Vascular calcification" in the real world. Note that HP:0004934 is annotated with the `rdfs:label` "Vascular calcification". 
The label itself is not necessarily a term - it could change, for example to "Abnormal calcification of the vasculature", and still retain the same meaning.
- "Vascular calcification" may be a term in my controlled vocabulary which I understand to correspond to that respective disease (not all controlled vocabularies have IDs for their terms). 
This happens for example in clinical data models that do not use formal identifiers to refer to the values of slots in their data model, like "MARRIED" in /datamodel/marital_status.
- Examples of terms: 
  - IDs of classes in an ontology
  - elements of a clinical value set
  - elements of clinical terminologies such as [Z63.1](https://www.icd10data.com/ICD10CM/Codes/Z00-Z99/Z55-Z65/Z63-/Z63.1)
- TLDR: terms correspond to things in the world and that correspondence is not subject to change. 
Labels can change without changing the meaning of a term.

## An attempt at a practical categorisation

In our experience, there are roughly four kinds of mappings:

- _string-string_: Relating one string, or label, to another string, or label. Understanding such mappings is fundamental to understanding all the other kinds of mappings.
- _string-term_: Relating a specific string or "label" to their corresponding term in a terminology or ontology. We usually refer to these as synonyms, but there may be other words used in this case.
- _term-term_: Relating a term, for example a class in an ontology, to another term. This is what most people in the ontology domain would understand when thy hear "ontology mappings".
- _complex mappings_: Relating two sets of terms. These are the rarest and most complicated kinds of mappings, as they related for example two phenotypic profiles (sets of phenotypes) with each other. We will discuss some more examples in a future lesson.

In some ways, these four kinds of mappings can be very different. We do believe, however, that there are enough important commonalities such as common features, widely overlapping use cases and overlapping toolkits to consider them together. In the following, we will discuss these in more detail, including important features of mappings and useful tools.

### Important features of mappings

Mappings have historically been neglected as second-class citizens in the medical terminology and ontology worlds -
the metadata is insufficient to allow for precise analyses and clinical decision support, they are frequently stale and out of date, etc. The question "Where can I find the canonical mappings between X and Y"? is often shrugged off and developers are pointed to aggregators such as [OxO](https://www.ebi.ac.uk/spot/oxo/) or [UMLS](https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/mapping_projects/index.html) which combine manually curated mappings with automated ones causing ["mapping hairballs"](#How-to-solve-the-problem-of-mapping-hairballs).

There are many important metadata elements to consider, but the ones that are by far the most important to consider one way or another are:

- _Precision_: Is the mapping exact, broad or merely closely related?
- _Confidence_: Do I trust the mapping? Was is done manually by an expert in my domain, or by an algorithm?
- _Source version_: Which version of the term (or its corresponding ontology) was mapped? Is there a newer mapping which has a more suitable match for my term?

Whenever you handle mappings (either create, or re-use), make sure you are keenly aware of at least these three metrics, and capture them. You may even want to consider using a proper mapping model like the [Simple Shared Standard for Ontology Mappings (SSSOM)](https://github.com/mapping-commons/SSSOM/blob/master/SSSOM.md) which will make your mappings FAIR and reusable.

### String-string mappings
String-string mappings are mappings that relate two strings. The task of matching two strings is ubiquitous for example in database search fields (where a user search string needs to be mapped to some strings in a database). Most, if not all effective ontology matching techniques will employ some form of string-string matching. For example, to match simple variations of labels such as "abnormal heart" and "heart abnormality", various techniques such as [Stemming](https://en.wikipedia.org/wiki/Stemming) and [bag of words](https://en.wikipedia.org/wiki/Bag-of-words_model#:~:text=The%20bag%2Dof%2Dwords%20model,word%20order%20but%20keeping%20multiplicity.) can be employed effectively. Other techniques such as edit-distance or Levenshtein can be used to quantify the similarity of two strings, which can provide useful insights into mapping candidates.

### String-term mappings / synonyms
String-term mappings relate a specific string or "label" to their corresponding term in a terminology or ontology. Here, we refer to these as "synonyms", but there may be other cases for string-term mappings beyond synonymy.

There are a lot of use cases for synonyms so we will name just a few here that are relevant to typical workflows of Semantic Engineers in the life sciences. 

[Thesauri](https://en.wikipedia.org/wiki/Thesaurus) are reference tools for finding synonyms of terms. Modern ontologies often include very rich thesauri, with some ontologies like Mondo capturing more than 70,000 exact and 35,000 related synonyms. They can provide a huge boost to traditional NLP pipelines by providing synonyms that can be used for both Named Entity Recognition and Entity Resolution. Some insight on how, for example, Uberon was used to boost text mining can be found [here](https://github.com/obophenotype/uberon/wiki/Using-uberon-for-text-mining).

### Term-term mappings / ontology mappings
Term-term mappings relate a term (or identifier), for example a class in an ontology, to another term, usually from another ontology or database. The term-term case of mappings is what most people in the ontology domain would understand when they hear "ontology mappings". This is also what most people understand when they here "Entity Resolution" in the database world - the task of determining whether, in essence, two rows in a database correspond to the same thing (as an example of a tool doing ER see [deepmatcher](https://github.com/anhaidgroup/deepmatcher), or [py-entitymatcher](https://pypi.org/project/py-entitymatching/)). For a list standard entity matching toolkit outside the ontology sphere see [here](https://www.biggorilla.org/software_cat/entity-matching/index.html). 

## How are mappings collected in practice?

Mappings between terms/identifiers are typically collected in three ways:

1. Automatically, using terminological matchers (of which ontology matchers one the most important category in our domain).
1. Manually, by dedicated curators.
1. Using a mix of automated and manual approaches, where automated approaches typically generate "mapping candidates" which are "double checked" by humans before used in production systems.

The main trade-off for mappings is very simple:
1. Automated mappings are _very_ error prone (not only are they hugely incomplete, they are also often faulty).
1. Human curated mappings are _very_ costly.

--> The key for any given mapping project is to determine the _highest acceptable error rate_, and then distribute the workload between human and automated matching approaches. We will discuss all three ways of collecting mappings in the following.

Aside from the main tradeoff above, there are other issues to keep in mind:
- Manually curated mappings are far from perfect. Most of the cost of mapping review lies in the decision _how thorough_ a mapping should be reviewed. For example, a human reviewer may be tasked with reviewing 1000 mappings. If the acceptable error rate is quite high, the review may simply involve the comparison of labels (see [here](../tutorial/sssom-tutorial.md)), which may take around 20 seconds. A tireless reviewer could possibly accept or dismiss 1000 mappings just based on the label in around 6 hours. Note that this is hardly better than what most automated approaches could do nowadays.
- Some use cases involve so much data that manual curation is nearly out of the question.

### Human curated mappings

In the most basic of cases, a human curator gets presented with a list of terms/identifiers from one database or ontology, and charged with finding corresponding terms in another. They make use of various tools, most importantly "term browsers" that help them determine appropriate matches.

For example, the curator may be charged with mapping all identifiers in their own phenotype database to the Human Phenotype Ontology (HPO). 

NICO CONTINUE HERE.

## Some examples of domain-specific mapping of importance to the biomedical domain

### Phenotype ontology mappings
Mapping phenotypes across species holds great promise for leveraging the knowledge generated by Model Organism Database communities (MODs) for understanding human disease. There is a lot of work happening at the moment (2021) to provide standard mappings between species specific phenotype ontologies to drive translational research ([example](https://github.com/mapping-commons/mh_mapping_initiative/tree/master/mappings)). Tools such as [Exomiser](https://github.com/exomiser/Exomiser) leverage such mappings to perform clinical diagnostic tasks such as variant prioritisation. Another app you can try out that leverages cross-species mappings is the Monarch Initiatives [Phenotype Profile Search](https://monarchinitiative.org/analyze/phenotypes).

### Disease ontology mappings
Medical terminology and ontology mapping is a huge deal in medical informatics ([example](https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/mapping_projects/index.html)). [Mondo](https://github.com/monarch-initiative/mondo) is a particularly rich source of well provenanced disease ontology mappings.

## Further reading
- A great overview can be found in ["Tackling the challenges of matching biomedical ontologies" (Faria et al 2018)](https://jbiomedsem.biomedcentral.com/articles/10.1186/s13326-017-0170-9)
- A yearly competition of ontology matching systems is held by the [Ontology Alignment Evaluation Initiative (OAEI)](https://oaei.ontologymatching.org/). The challenge [results](http://oaei.ontologymatching.org/2020/results/) are a useful guide to identifying systems for matching you may want to try.

