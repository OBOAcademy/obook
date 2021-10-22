# Analysing Linked Data (Fundamentals)

### Warning
These materials are under construction and incomplete.

## Prerequisites
- Review tutorial on [Ontology Theory](ontology_fundamentals.md)

## Preparation
- Essential
  - [Linked Data Engineering](https://open.hpi.de/courses/semanticweb2016/overview): Week 1
- Support
  - [Programming Historian Linked Data tutorial](https://programminghistorian.org/en/lessons/intro-to-linked-data)
  - [Original Whitepaper (Tim Berners Lee et al)](https://www-sop.inria.fr/acacia/cours/essi2006/Scientific%20American_%20Feature%20Article_%20The%20Semantic%20Web_%20May%202001.pdf)
  - [Educational curriculum for Linked Data](https://euclid-project.eu/)
- Tools: Browse through the tools and standards listed in the [Semantic Engineer Toolbox](../reference/semantic_engineering_toolbox.md).

### Learning objectives
- Advanced SPARQL
- Term enrichment
- Semantic similarity
- Named Entity Recognition

## Tutorials

### The Linked Data landscape from an OBO perspective: Standards, Services and Tools

In the following we will look a bit at the general Linked Data landscape, and name some of its flagship projects and standards. It is important to be clear that the Semantic Web field is a very heterogenous one: 

#### Flagship projects of the wider Semantic Web community

- [Linked Open Data (LOD) cloud](https://lod-cloud.net/): The flagship project of the Semantic Web. An attempt to make all, or anyways a lot, of Linked Data accessible in one giant knowledge graph. A good overview can be found in [this](https://medium.com/virtuoso-blog/what-is-the-linked-open-data-cloud-and-why-is-it-important-1901a7cb7b1f) medium article. Note that some people seem to think that the Semantic Web _is_ (or should be) the Linked Open Data cloud. I would question this view, but I am not yet decided what my position is.
- [Schema.org](https://schema.org/): General purpose vocabulary for entities on the web, founded by Google, Microsoft, Yahoo and Yandex. To get a better sense of the types of entities and relationships covered see [here](https://schema.org/docs/full.html).
- [DBpedia](https://www.dbpedia.org/): Project that extracts structured data from Wikipedia and makes it available as a giant knowledge graph. The [associated ontology](http://mappings.dbpedia.org/server/ontology/classes/), similar to schema.org, covers entities encountered in common sense knowledge.
- [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page): Free and open knowledge base that can be edited in much the same way as Wikipedia is edited.

While these Semantic Web flagship projects are doubtlessly useful, it is sometimes hard to see how they can help for your biomedical research. We rarely make use of them in our day to day work as ontologists, but there are some notable exceptions:
- Where our work involves modelling environmental factors, we sometimes use wikidata as a standard way to refer for example to countries.
- For some more common sense knowledge use cases, such as nutrition, consider augmenting your knowledge graph with data from wikidata or dbpedia. While they may be a bit more messy and not directly useful for exploration by humans, it is quite possible that Machine Learning approaches can use the additional context provided by these knowledge graphs to improve embeddings and deliver more meaningful link predictions.
- Some OBO ontologies are already on Wikidata - perhaps you can find additional synonyms and labels which help with your data mapping problems!

#### Where the OBO and Semantic Web communities are slightly at odds

The [OBO format](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#5.1) is a very popular syntax for representing biomedical ontologies. A lot of tools have been built over the years to hack OBO ontologies on the basis of that format - I still work with it on a daily basis. Although it has semantically been proven to be a subset of OWL (i.e. there is a lossless mapping of OBO into OWL) and can be viewed as just another syntax, it is in many ways ideosyncratic. For starters, you wont find many, if any, IRIs in OBO ontologies. The format itself uses CURIEs which are mapped to the general OBO PURL namespace during transformation to OWL. For example, if you see MONDO:0003847 in an OBO file, and were to translate it to OWL, you will see this term being translated to http://purl.obolibrary.org/obo/MONDO_0003847. Secondly, you have a bunch of built-in properties like BROAD or ABBREVIATION that mapped to a vocabulary called oboInOwl (oio). These are pretty non-standard on the general Semantic Web, and  often have to be manually mapped to the more popular counterparts in the Dublin Core or SKOS namespaces.

Having URIs as identifiers is not generally popular in the life sciences. As discussed elsewhere, it is much more likely to encounter CURIEs such as MONDO:0003847 than URIs such as http://purl.obolibrary.org/obo/MONDO_0003847 in biomedical databases.

<a name="tools-biomedical-research"></a> 

#### Useful tools for biomedical research

Why does the biomedical research, and clinical, community care about the Semantic Web and Linked Data? There are endless lists of applications that try to apply semantic technologies to biomedical problems, but for this week, we only want to look at the broader picture. In our experience, the use cases where Semantic Web standards are applied successfully are:

- Where to find ontologies: Ontology repositories
   - [OBO Foundry Ontology Library](http://obofoundry.org/)
   - [BioPortal](https://bioportal.bioontology.org/)
     - [CPT Story](https://www.bioontology.org/why-bioportal-no-longer-offers-the-current-procedural-terminology-cpt/). The Current Procedural Terminology was the by far most highly accessed Terminology on Bioportal - for many years. Due to license concerns, it had to be withdrawn from the repository. This story serves a cautionary tale of using terminologies with non-open or non-transparent licensing schemes.
   - [AgroPortal](http://agroportal.lirmm.fr/): Like BioPortal, but focussed on the Agronomy domain.
   - [Linked Open Data Vocabularies (LOV)](https://lov.linkeddata.es/dataset/lov/): Lists the most important vocabularies in the Linked Data space, such as [Dublin Core](https://dublincore.org/), [SKOS](https://www.w3.org/TR/skos-reference/) and [Friend-of-a-Friend](http://xmlns.com/foaf/spec/) (FOAF).
- Where to find terms: Term browsers
   - [OLS](https://www.ebi.ac.uk/ols/index): The boss of the current term browsers out there. While the code base is a bit dated, it still gives access to a wide range of relevant open biomedical ontology terms. Note, while being a bit painful, it is possible to [set up your own OLS](https://github.com/EBISPOT/ontotools-docker-config) (for your organisation) which only contains those terms/ontologies that are relevant for your work.
   - [Ontobee](http://www.ontobee.org/): The default term browser for OBO term purls. For example, click on http://purl.obolibrary.org/obo/OBI_0000070. This will redirect you directly to Ontobee, to show you the terms location in the hierarchy. In practice, there is no particular reason why you would favour Ontobee over OLS for example - I just sometimes prefer the way Ontobee presents annotations and "uses" by other ontologies, so I use both.
   - [AberOWL](http://aber-owl.net/#/): Another ontology repository and semantic search engine. Some ontologies such as [PhenomeNet](http://aber-owl.net/ontology/PhenomeNET/) can only be found on AberOWL, however, I personally prefer OLS.
   - [identifiers.org](https://identifiers.org/): A centralised registry for identifiers used in the life sciences. This is one of the tools that bridge the gap between CURIEs and URLs, but it does not cover (OBO) ontologies very well, and if so, is not aware of the proper URI prefixes (see for example [here](https://identifiers.org/resolve?query=HP:0000001), and HP term resolution that does not list the proper persistent URL of the HP identifier (http://purl.obolibrary.org/obo/HP_0000001)). Identifiers.org has mainly good coverage for databases/resources that use CURIE type identifiers. But: you can enter any ID you find in your data and it will tell you what it is associated with.
- Curate biomedical data. There are a lot of different tools in this space - which we will discuss in a bespoke unit later in the course. Examples:
   - [isatools](https://isa-tools.org/index.html): The open source ISA framework and tools help to manage an increasingly diverse set of life science, environmental and biomedical experiments that employing one or a combination of technologies.
   - [RightField](https://rightfield.org.uk/about): System for curating ontology terms in Excel spreadsheets.
   - [CEDAR Templates](https://more.metadatacenter.org/tools-training/cedar-template-tools): Basically a templating system that allows to create templates to record metadata, for example in a lab setting, of course with ontology integration.
   - [Other examples](https://github.com/timrdf/csv2rdf4lod-automation/wiki/Alternative-Tabular-to-RDF-converters) of tabular data to RDF converters, but new ones coming up every year.
- Building ontologies
   - [Populous/Webulous](https://github.com/EBISPOT/webulous): A system to maintain/generate ontologies from spreadsheets. The idea was to basically to define patterns in a (now mostly dead) language called OPPL, and then apply them to spreadsheets to generate OWL axioms. EBI recently discontinued the service, as there is a general exodus to Google Sheets + ROBOT templates instead.
   - [ROBOT templates + Google Sheets and Cogs](http://robot.obolibrary.org/template): A lightweight approach based on a set of tools that allows curating ontologies in spreadsheets (e.g. Google Sheets) which are converted into OWL using ROBOT.
   - [DOSDP tools + Dead Simple Design Patterns (DOSDP)](https://github.com/INCATools/dead_simple_owl_design_patterns): Similar to ROBOT templates, DOSDPs (which really should be called DOSDTs, because they are not really design _patterns_; they are ontology templates), another system that allows the generation of OWL axioms based on spreadsheet data.
- Cleaning messy data
   - [OpenRefine](https://openrefine.org/): I have not myself used this ever, but some of my colleagues have. OpenRefine allows you to upload (spreadsheet) data, explore it and clean it (going as far as reconciling terms using Wikidata concepts).

##### Which biomedical ontologies should we use?

As a rule of thumb, for every single problem/term/use case, you will have 3-6 options to choose from, in some cases even more. The criteria for selecting a good ontology are very much dependent on your particular use case, but some concerns are generally relevant. A good first pass is to apply to "[10 simple rules for selecting a Bio-ontology](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004743)" by Malone et al, but I would further recommend to ask yourself the following:

- _Do I need the ontology for grouping and semantic analysis?_ In this case a high quality hierarchy reflecting biological subsumption is imperative. We will explain later what this means, but in essence, you should be able to ask the following question: "All instances/occurrences of this concept in the ontology are also instances of all its parent classes. Everything that is true about the parent class is always also true about instances of the children." It is important for you to understand that, while OWL semantics imply the above, OWL is difficult and many ontologies "pretend" that the subclass link means something else (like a rule of thumb grouping relation).
- _Can I handle multiple inheritance in my analysis?_ While I personally recommend to _always_ consider multiple inheritance (i.e, allow a term to have more than one parent class), there are some analysis frameworks, in particular in the clinical domain, that make this hard. Some ontologies are inherently ploy-hierarchical (such as [Mondo](https://github.com/monarch-initiative/mondo)), while others strive to be single inheritance ([DO](https://disease-ontology.org/), ICD).
- _Are key resources I am interested in using the ontology?_ Maybe the most important question that will drastically reduce the amount of data mapping work you will have to do: Does the resource you wish to integrate already annotate to a particular ontology? For example, EBI resources will be annotating phenotype data using EFO, which in turn used HPO identifiers. If your use case demands to integrate EBI databases, it is likely a good idea to consider using HPO as the reference ontology for your phenotype data.

Aside from aspects of your analysis, there is one more thing you should consider carefully: the open-ness of your ontology in question. As a user, you have quite a bit of power on the future trajectory of the domain, and therefore should seek to endorse and promote open standards as much as possible (for egotistic reasons as well: you don't want to have to suddenly pay for the ontologies that drive your semantic analyses). It is true that ontologies such as [SNOMED](https://www.snomed.org/snomed-ct/five-step-briefing) have some great content, and, even more compellingly, some really great coverage. In fact, I would probably compare SNOMED not with any particular disease ontology, but with the OBO Foundry as a whole, and if you do that, it is a) cleaner, b) better integrated. But this comes at a cost. SNOMED is a commercial product - millions are being payed every year in license fees, and the more millions come, the better SNOMED will become - and the more drastic consequences will the lock-in have if one day you are forced to use SNOMED because OBO has fallen too far behind. Right now, the sum of all OBO ontologies is probably still richer and more valuable, given their use in many of the central biological databases (such as the ones hosted by the [EBI](https://www.ebi.ac.uk/)) - but as SNOMED is seeping into the all aspects of genomics now (for example, it will soon be featured on [OLS](https://www.ebi.ac.uk/ols/index)!) it will become increasingly important to _actively_ promote the use of open biomedical ontologies - by contributing to them as well as by using them.

We will discuss ontologies in the medical, phenomics and genomics space in more detail in a later session of the course.

##### Other interesting links

- [Linked Data in e-Government](https://joinup.ec.europa.eu/sites/default/files/inline-files/D4.3.2_Case_Study_Linked_Data_eGov.pdf)
- [Industrial Ontologies Foundry](https://www.industrialontologies.org/): Something like the OBO Foundry for Industrial Ontologies
- [OntoCommons](https://ontocommons.eu/): An H2020 CSA project dedicated to the standardisation of data documentation across all domains related to materials and manufacturing.

### Basic Linked data and Semantic Web Concepts for the Semantic Data Engineer in the Biomedical Domain

In this section we will discuss the following:
- Introductory remarks
- The advantages of globally unique identifiers
- Some success stories of the Semantic Web in the biomedical domain
- Some basic concepts you should probably have heard about
- The ecosystem of the Semantic Web: Standards, Technologies and Research Areas
- Typical tasks of Semantic Data Engineers in the biomedical domain

#### Introduction

_Note of caution_: No two Semantic Web overviews will be equivalent to each other. Some people claim the Semantic Web as an idea is an utter failure, while others praise it as a great success (in the making) - in the end you will have to make up your own mind. In this section I focus on parts of the Semantic Web step particularly valuable to the biomedical domain, and I will omit many relevant topics in the wider Semantic Web area, such as Enterprise Knowledge Graphs, decentralisation and personalisation, and many more. Also, the reader is expected to be familiar with the basic notions of the Semantic Web, and should use this overview mainly to tie some of the ideas together.

The goal of this section is to give the aspiring Semantic Data Engineer in the biomedical domain a rough idea of key concepts around Linked Data and the Semantic Web insofar as they relate to their data science and and data engineering problems. Even after 20 years of Semantic Web research (the [seminal paper](https://www.scientificamerican.com/article/the-semantic-web/), conveniently and somewhat ironically behind a paywall, was published in May 2001), the area is still dominated by "academic types", although the advent of the Knowledge Graph is already changing that. As I already mentioned above, no two stories of what the Semantic Web is will sound the same. However, there are a few stories that are often told to illustrate why we need semantics. The [OpenHPI course](https://open.hpi.de/courses/semanticweb2016) names a few: 
- "From the web of documents to the web of data" tells the story of how the original web is essentially a huge heap of (interlinked) natural language text documents which are very hard to understand for search engines: Does the word "Jaguar" on this site refer to the car or the cat? Clarifying in your web page that the word Jaguar refers to the concept of "Jaguar the cat", for example like this: `<span about="dbpedia:Jaguar">Jaguar</span>`, will make it easier for the search engine to understand what your site is about and link it to other relevant content. From this kind of mark-up, structured data can be extracted and integrate into a giant, worldwide database, and exposed through SPARQL endpoints, that can then be queried using a suitable query language.
- "From human to machine understandable": as a Human, we know that a Jaguar is a kind of cat, and all cats have four legs. If you ask a normal search engine: "Does a Jaguar have four legs?" it will have a tough time to answer this question correctly (if it cannot find that exact statement anywhere). That is why we need _proper semantics_, some kind of formalism such that a "machine" can deduce from the statements "Jaguar is a cat; Cat has four legs" that "Jaguar has four legs".
- The "Semantic Layer Cake": a [box/brick diagram](https://en.wikipedia.org/wiki/Semantic_Web_Stack) showing how Semantic Web Technologies are stacked on top of each other. An engineering centric view that has been used countless times to introduce the Semantic Web, but rarely helped anyone to understand what it is about.

I am not entirely sure anymore that any of these ways (web of data, machine understanding, layered stack of matching standards) to motivate the Semantic Web are particularly effective for the average data scientists or engineer.
If I had to explain the Semantic Web stack to my junior self, just having finished my undergraduate, I would explain it as follows (no guarantee though it will help you).

______

The Semantic Web / Linked Data stack comprises roughly four components that are useful for the aspiring Semantic (Biomedical) Data Engineer/Scientist to distinguish:

##### A _way to refer to things_ (including entities and relations) in a global namespace. 

You, as a scientist, might be using the term "gene" to refer to basic physical and functional unit of heredity, but me, as a German, prefer the term "Gen". In the Semantic Web, instead of natural language words, we prefer to use *URIs to refer to things* such as https://www.wikidata.org/wiki/Q7187: if you say something using the name https://www.wikidata.org/wiki/Q7187, both your German and Japanese colleagues will "understand" what you are referring to. More about that in the next chapter.

##### Lots (loaaaads!) of _ways to make statements about things_. 

For example, to express "a mutation of SHH in humans causes isolated microphthalmia with coloboma-5" you could say something like (http://purl.obolibrary.org/obo/MONDO_0012709 | "microphthalmia, isolated, with coloboma 5")--\[http://purl.obolibrary.org/obo/RO_0004020 | "has basis in dysfunction of"\]-->(https://identifiers.org/HGNC:10848 | "SSH (gene)"). Or you could say:  (http://purl.obolibrary.org/obo/MONDO_0012709 | "microphthalmia, isolated, with coloboma 5")--\[http://www.w3.org/2000/01/rdf-schema#subClassOf | "is a"\]-->(http://purl.obolibrary.org/obo/MONDO_0003847 | "Mendelian Disease"). If we use the analogy of "language", then the URIs (above) are the words, and the statements are *sentences in a language*. Unfortunately, there are _many_ languages in the Semantic Web, such as OWL, RDFS, SKOS, SWRL, SHACL, SHEX, and dialects (OWL 2 EL, OWL 2 RL) and a *plethora* of scripts, or serialisations (you can store the exact same sentence in the same language such as RDF, or OWL, in many different ways)- more about that later. In here lies also one of the largest problems of the Semantic Web - lots of overlapping standards means, lots of incompatible data - which raises the bar for actually being able to seamlessly integrate "statements about things" across resources.

##### _Collections of statements about things that somehow belong together and provide some meaning, or context, for those things_. 

Examples include:
- *controlled vocabularies*, that define, for example, how to refer to a disease (e.g., we use http://purl.obolibrary.org/obo/MONDO_0012709 to refer to "isolated microphthalmia with coloboma 5"), 
- *terminologies* which describe how we humans refer to a disease (How is it called in German? Which other synonyms are used in the literature? How is the term defined in the medical literature?), 
- *taxonomies* which define how diseases are related hierarchically ("microphthalmia, isolated, with coloboma 5 is a kind of Mendelian disease"),  
- *ontologies* which further define how diseases are defined in terms of other entities, for example "microphthalmia, isolated, with coloboma 5 is a Mendelian disease that has its basis in the dysfunction of SSH".
- _Note_: In practice, when we say "ontology", we mean *all of the above together* - it is, however, good to know that they are somewhat distinct, and that there are different "languages" that can be used for each of these distinctions.

##### *Tools* that do something useful with these collections of statements. 

For example (as always, non exhaustive):

- Efficient *storage* (triple stores, in-memory ontology APIs, other databases). Similar to traditional SQL databases, the Semantic Web comes with a number of database solutions that are optimised to deliver "semantic content".
- *Semantically aware querying*: Very similar to traditional SQL (which, incidentally is often great to query semantic data), there are various ways to "interrogate", or query, your Linked Data, such as SPARQL, [DL Querying](https://ontology101tutorial.readthedocs.io/en/latest/DL_QueryTab.html), [Ontology-based data access](http://obdasystems.com/obda) (OBDA).
- *Subsetting* (module/subset extraction): Often, ontologies (or other collections of Linked Data statements) are very large and cover a lot of entities and knowledge that is not important to your work. There are a number of techniques that allow you to extract meaningful subsets for your use case; for example, you may be interested to get all the information you can about Mendelian diseases, but you don't care about common diseases (e.g. see [ROBOT extract](http://robot.obolibrary.org/extract)).
- *Visualisation*: As a Data Scientist, you are used to looking at your data in tabular form - while a lot of information stored in ontologies can still be inspected this way, in general semantic data is best perceived as a graph - which are notoriously hard to visualise. Fortunately, a lot of Linked Data, in particular ontologies in the biomedical domain are predominantly tree-shaped (you have a disease, and underneath sub-diseases). Term browsers like [OLS](https://www.ebi.ac.uk/ols/index) typically render ontologies as trees.
- *Data linking/matching*: This is key in particular in the biomedical sciences, as there is almost never just one way to refer to the same thing. In my experience, a good rule of thumb is that there are 3-6, e.g. 3-6 URIs that refer to "Mendelian Disease", all of which need to be *matched* together to integrate data across resources. There are many approaches to ontology matching - none of which are anywhere near perfect.
- *Automated error checking and validation* (Syntax, Structure (SHEX, SHACL), logical Consistency (DL Reasoner)): Naturally, writing sentences in any language is hard in the beginning, but this is even more true for highly complex languages such as OWL. In my experience, no-one can write flawless OWL without the help of automatic syntax and semantics checking, at least not consistently. Validation tools are a crucial part of your Semantic Engineering toolbox.
- _Translate_ between languages: Often we need to translate from one language, for example OWL, to another, for example SKOS to integrate divergent resources. Translations in the Semantic Web context are nearly always lossy (there are always things you can say in one language, but not in another), but they may be necessary nevertheless.
- _Discovery_ of terms ([OLS](https://www.ebi.ac.uk/ols/index), [BioPortal](https://bioportal.bioontology.org/)): If you are curating terms, you need to know what ID (URI) to use for "isolated microphthalmia with coloboma 5". For that, term browsers such as [OLS](https://www.ebi.ac.uk/ols/index) are perfect. Just type in your natural language search term, and you will find a series of suggestions for URIs you can use for your curation.
- Discovery of vocabularies [OBO Foundry ontology library](http://obofoundry.org/), [BioPortal](https://bioportal.bioontology.org/)): we will have a section later on on how to select appropriate ontologies for your use case, but the general problem of finding vocabularies, or ontologies, is answered by ontology repositories or libraries. Naturally, our favourite ontology library is the [OBO Foundry ontology library](http://obofoundry.org/) which contain a lot of high quality ontologies for the biomedical domain.
- Make implicit knowledge explicit, aka *reasoning*:
   - Deductive (DL Reasoning, Rule-based reasoning such as Datalog, SWRL). One of the major selling points for OWL, for example, in the biomedical domain is the ability to use logical reasoning in a way that is sound (only gives you correct inferences, at all times) and complete (all hidden implications are found, at all times, by the reasoner) - this is particularly great for medical knowledge where mistakes in computer algorithms can have devastating effects. However, I am slowly coming to the conviction that sound and complete reasoning is not the only form of deductive reasoning that is useful - many rule languages can offer value to your work by unveiling hidden relationships in the data without giving such strong "logical guarantees".
   - Inductive (Machine Learning approaches, Knowledge Graph Representation Learning). The new frontier - we will discuss later in the course how our ontology-powered Knowledge Graphs can be leveraged to identify drug targets, novel gene to phenotype associations and more, using a diverse set of Machine Learning-based approaches.

This week will focus on 1 (identifiers) and 4 (applications) - 2 (languages and standards) and 3 (controlled vocabularies and ontologies) will be covered in depth in the following weeks.

_Note on the side_: Its not always 100% clear what is meant by Linked Data in regular discourse. There are some supposedly "clear" definitions ("[method for publishing structured data](https://wordlift.io/blog/en/entity/linked-data)", "[collection of interrelated datasets on the Web](https://www.w3.org/standards/semanticweb/data)"), but when it comes down to the details, there is plenty of confusion (does an OWL ontology constitute Linked Data when it is published on the Web? Is it Linked Data if it does not use RDF? Is it Linked Data if it is less than 5-star - see below). In practice all these debates are academic and won't mean much to you and your daily work. There are _entities_, statements (context) being said about these entities using some standard (associated with the Semantic Web, such as OWL or RDFS) and tools that do something useful with the stuff being said.

#### When I say "Mendelian Disease" I mean http://purl.obolibrary.org/obo/MONDO_0003847

One of the top 5 features of the Semantic Web (at least in the context of biomedical sciences) is the fact that we can use URIs as a global identifier scheme that is unambiguous, independent of database implementations, independent of language concerns to refer to the entities in our domain.

For example, if I want to refer to the concept of "Mendelian Disease", I simply refer to http://purl.obolibrary.org/obo/MONDO_0003847 - and everyone, in Japan, Germany, China or South Africa, will be able to "understand" or _look up_ what I mean. I don't quite like the word "understanding" in this context as it is not actually trivial to explain to a human how a particular ID relates to a thing in the real world (semiotics). In my experience, this process is a bit rough in practice - it requires that there is a concept like "Mendelian Disease" in the mental model of the person, and it requires some way to link the ID http://purl.obolibrary.org/obo/MONDO_0003847 to that "mental" concept - not always as trivial as in this case (where there are standard textbook definitions). The latter is usually achieved (philosophers and linguists please stop reading) by using an annotation that somehow explains the term - either a label or some kind of formal definition - that a person can understand. In any case, not trivial, but thankfully not the worst problem in the biomedical domain where we do have quite a wide range of shared "mental models" (more so in Biology than Medical Science..). Using URIs allows us to facilitate this "understanding" process by leaving behind some kind of information at the location that is dereferenced by the URI (basically you click on the URI and see what comes up). Note that there is a huge deal of compromise already happening across communities. In the original Semantic Web community, the hope was somehow that dereferencing the URI (clicking on it, navigating to it) would reveal _structured_ information about the entity in question that could used by machines to understand what the entity is all about. In my experience, this was rarely ever realised in the biomedical domain. Some services like [Ontobee](http://ontobee.org/) expose such machine readable data on request (using a technique called content negotiation), but most URIs simply refer to some website that allow humans to understand what it means - which is already a _huge_ deal. For more on names and identifiers I refer the interested reader to James Overton's OBO tutorial [here](https://github.com/jamesaoverton/obo-tutorial/blob/master/docs/names.md).

_Personal note:_ Some of my experienced friends in the bioinformatics world say that "IRI have been more pain than benefit". It is clear that there is no single thing in the Semantic Web is entirely uncontested - everything has its critics and proponents.

##### The advent of the CURIE and the bane of the CURIE map

In reality, few biological resources will contain a reference to http://purl.obolibrary.org/obo/MONDO_0003847. More often, you will find something like `MONDO:0003847`, which is called a _CURIE_. You will find CURIEs in many contexts, to make Semantic Web languages easier to read and manage. The premise is basically that your document contains a prefix declaration that says something like this:

```
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>
```
which allows allows the interpreter to unfold the CURIE into the IRI:

```
MONDO:0003847 -> http://purl.obolibrary.org/obo/MONDO_0003847
```

In reality, the proliferation of CURIEs has become *a big problem for data engineers and data scientists* when analysing data. Databases rarely, if ever, ship the _CURIE maps_ with their data required to understand what a prefix effectively stands for, leading to a lot of guess-work in the daily practice of the Semantic Data Engineer (if you ever had to distinguish ICD: ICD10: ICD9: UMLS:, UMLSCUI: without a prefix map, etc you will know what I am talking about). Efforts to bring order to this chaos, essentially globally agreed _CURIE maps_ (e.g. [prefixcommons](https://github.com/prefixcommons/biocontext)), or ID management services such as [identifiers.org](https://identifiers.org/) exist, but right now there is no one solution - prepare yourself to having to deal with this issue when dealing with data integration efforts in the biomedical sciences. More likely than not, your organisation will build its own curie map and maintain it for the duration of your project.

#### Semantic Web in the biomedical domain: Success stories

There are probably quite a few divergent opinions on this, but I would like to humbly list the following four use cases as among the most impactful applications of Semantic Web Technology in the biomedical domain.

##### _Light Semantics for data aggregation_.

We can use hierarchical relations in ontology to group data. For example, if I know that http://purl.obolibrary.org/obo/MONDO_0012709 ("microphthalmia, isolated, with coloboma 5") http://www.w3.org/2000/01/rdf-schema#subClassOf ("is a") http://purl.obolibrary.org/obo/MONDO_0003847 ("Mendelian Disease"), then a specialised Semantic Web tool called a reasoner will know that, if I ask for all genes associated with Mendelian diseases, you also want to get those associated with "microphthalmia, isolated, with coloboma 5" specifically (note that many query engines such as [SPARQL with RDFS entailment regime](https://www.w3.org/TR/sparql11-entailment/) have simple reasoners embedded in them, but we would not call them "reasoner" - just query engine).

##### _Heavy Semantics for ontology management_.

Ontologies are extremely hard to manage and profit from the sound logical foundation provided by the Web Ontology Language (OWL). We can logically define our classes in terms of other ontologies, and then use a reasoner to classify our ontology automatically. For example, we can define abnormal biological process phenotypes in terms of biological processes (Gene Ontology) and classify our phenotypes entirely using the classification of biological processes in the Gene Ontology (don't worry if you don't understand a thing - we will get to that in a later week).

##### _Globally unique identifiers for data integration_.

Refer to the same thing the same way. While this goal was never reached in total perfection, we have gotten quite close. In my experience, there are roughly 3-6 ways to refer to entities in the biomedical domain (like say, ENSEMBL, HGNC, Entrez for genes; or SNOMED, NCIT, DO, MONDO, UMLS for diseases). So while the "refer to the same thing the same way" did not truly happen, a _combination of standard identifiers with terminological mappings_, i.e. links between terms, can be used to integrate data across resources (more about Ontology Matching later). Again, many of my colleagues disagree - they don't like IRIs, and unfortunately, you will have to build your own position on that. 

_Personal note_: From an evolutionary perspective, I sometimes think that having 2 or 3 competing terminological systems is better than 1, as the competition also drives the improvements in quality, but there is a lot of disagreement on this.

##### _Coordinated development of mutually compatible ontologies across the biomedical domain_: The Open Biological and Biomedical Ontologies (OBO) Foundry.

The [OBO Foundry](http://obofoundry.org/) is a community-driven effort to coordinate the development of vocabularies and ontologies across the biomedical domain. It develops standards for the representation of terminological content (like standard properties), and ontological knowledge (shared design patterns) as well as shared systems for quality control. Flagship projects include:
 - The [Relation Ontology](https://github.com/oborel/obo-relations) (RO) for the standardisation of relationships that connect entities in biomedical ontologies.
 - The [Core Ontology for Biology and Biomedicine (COB)](https://github.com/OBOFoundry/COB): upper ontology to align key entities used throughout biomedical ontologies.
 - The [OBO Metadata Ontology](https://github.com/information-artifact-ontology/ontology-metadata) for aligning ontology metadata properties across OBO ontologies.
 - The [OBO Persistent Identifier System](https://github.com/OBOFoundry/purl.obolibrary.org): an Identifier scheme for persistent URIs used by many ontologies on the web. The system is used to refer to terms as well as ontologies and their versions.
 - [OBO Dashboard](http://dashboard.obofoundry.org/dashboard/index.html): a system for the monitoring and continued improvement of OBO ontologies with automated Quality Control checks.

#### Semantic Web and Linked Data: Things you should have heard about

- The [Semantic Web Layer Cake](https://en.wikipedia.org/wiki/Semantic_Web_Stack): A iconic, colourful graphic that describes the layered design of the semantic web, from URIs to Logic. Its not particularly useful, but as a Semantic Web Explorer, you should have seen it.
- [Linked Data](https://en.wikipedia.org/wiki/Linked_data) is mostly referred to as a "method for publishing data", a key concept in the Semantic Web domain, coined by Tim Berners Lee in 2006. Related concepts:
  - [Linked Data Principles](https://www.w3.org/wiki/LinkedData):
    - Use URIs as names for things
    - Use HTTP URIs so that people can look up those names.
    - When someone looks up a URI, provide useful information.
    - Include links to other URIs. so that they can discover more things.
  - [5-Star system](https://5stardata.info/en/)
    1. make your stuff available on the Web (whatever format) under an open license
    2. make it available as structured data (e.g., Excel instead
    of image scan of a table)
    3. use non-proprietary formats (e.g., CSV instead of Excel)
    4. use URIs to denote things, so that people can point at
    your stuff
    5. link your data to other data to provide context
- [FAIR data](https://en.wikipedia.org/wiki/FAIR_data): Principles defined in 2016, somewhat orthogonal to Linked Data Principles. A nice tutorial, also going a bit more in depth into identifiers than what we did in this section, can be found [here](http://www.repronim.org/module-FAIR-data/01-Web-of-Data/). The idea of FAIR data is probably more impactful in the biomedical and pharmaceutical world then the idea of Linked Data. While there are some (slighltly irritating) voices on the sidelines that say that "It can't be FAIR if its not RDF", it is probably true that a nicely formatted CSV file on the Web is at least as useful as a (hard to understand) RDF dump containing the same data. Worldwide collaborations between major pharmaceutical corporations promoting FAIR data, such as the [Pistoia Alliance](https://www.pistoiaalliance.org/news/fair-toolkit-launch/) do mention Semantic Web Technologies in their [White papers](https://www.sciencedirect.com/science/article/pii/S1359644618303039?via%3Dihub), but keep the jargon a bit more hidden from the general public. Data, according to the FAIR principles, should be:
  - Findable (machine readable metadata, etc)
  - Accessible (open authentication, authorisation)
  - Interoperable (integrated with other data, closely related to controlled vocabularies and linked data)
  - Reusable (metadata, license, provenance)
- [World Wide Web Consortium (W3C)](https://www.w3.org/): The World Wide Web Consortium (W3C) is an international community that develops open standards, in particular many of those (but not all!) pertaining to the Semantic Web.

#### The Ecosystem of Linked Data and Semantic Web: Standards, Technologies and Research Areas

In the following, we will list some of the technologies you may find useful, or will be forced to use, as a Semantic Data Engineer. Most of these standards will be covered in the subsequent weeks of this course.

| Standard | Purpose | Use case |
| ------- | ------ | ----- |
| [Web Ontology Language](https://www.w3.org/2001/sw/wiki/OWL) (OWL) | Representing Knowledge in Biomedical Ontologies | All OBO ontologies must be provided in OWL as well. |
| [Resource Description Framework](https://www.w3.org/2001/sw/wiki/RDF) (RDF) | Model for data interchange. | Triples, the fundamental unit of RDF, are ubiquitous on the Semantic Web |
| [SPARQL Query Language for RDF](https://www.w3.org/2001/sw/wiki/SPARQL) | A standard query language for RDF and RDFS. | Primary query language to interrogate RDF/RDFS/Linked Data on the Web.|
| [Simple Knowledge Organization System](https://www.w3.org/2001/sw/wiki/SKOS) (SKOS)| Another, more lightweight, knowledge organisation system in many ways competing with OWL. | Not as widely used in the biomedical domain as OWL, but increasing uptake of "matching" vocabulary (skos:exactMatch, etc). |
| [RDF-star](https://w3c.github.io/rdf-star/)| A key shortcoming of RDF is that, while I can in principle say everything about everything, I cannot directly talk about edges, for example to attribute provenance: "microphthalmia, isolated, with coloboma 5 is kind of Mendelian disease"--source: Wikipedia | Use cases [here](https://w3c.github.io/rdf-star/UCR/rdf-star-ucr.html).|
|[JSON-LD](https://en.wikipedia.org/wiki/JSON-LD) | A method to encoding linked data in JSON format. | (Very useful to at least know about). |
| [RDFa](https://en.wikipedia.org/wiki/RDFa)| W3C Recommendation to embed rich semantic metadata in HTML (and XML). | I have to admit - in 11 years Semantic Web Work I have not come across much use of RDFa in the biomedical domain. But @jamesaoverton is using it in his tools! |

A thorough overview of all the key standards and tools can be found on the [Awesome Semantic Web](https://github.com/semantalytics/awesome-semantic-web) repo.

For a rough sense of current research trends it is always good to look at the accepted papers at one of the major conferences in the area. I like ISWC ([2020 papers](https://iswc2020.semanticweb.org/program/accepted-papers/)), but for the aspiring Semantic Data Engineering in the biomedical sphere, it is probably a bit broad and theoretical. Other interesting specialised venues are the [Journal of Biomedical Semantics](https://jbiomedsem.biomedcentral.com/) and the [International Conference on Biomedical Ontologies](https://icbo2020.inf.unibz.it/program/), but with the shift of the focus in the whole community towards Knowledge Graphs, other journals and conferences are becoming relevant.

Here are a few key research areas, which are, by no means (!), exhaustive.

- How can we combine data and knowledge from different ontologies/knowledge graphs?
    - [Ontology/Knowledge graph alignment](https://en.wikipedia.org/wiki/Ontology_alignment): How can we effectively link to ontologies, or knowledge graphs, together?
    - [Ontology merging](https://en.wikipedia.org/wiki/Ontology_merging): combine two ontologies by corresponding concepts and relations.
    - Ontology matching: A sub-problem of ontology alignment, namely the problem of determining whether two terms (for example two diseases) from different ontologies should be linked together or not.
- How can we integrate data from unstructured and semistructured sources such as documents or spreadsheets?
  - [Named Entity Recognition (NER)](https://en.wikipedia.org/wiki/Named-entity_recognition): the process of identifying a named "thing" in a text.
  - [Entity linking](https://en.wikipedia.org/wiki/Entity_linking): The task of associating a named entity, for example the result of a Named Entity Recognition algorithm, or the column of a spreadsheet, to a concept in an ontology. For example, the value "Mendelian Disease" is _linked_ to the concept http://purl.obolibrary.org/obo/MONDO_0003847.
  - [Relationship extraction](https://medium.com/@andreasherman/different-ways-of-doing-relation-extraction-from-text-7362b4c3169e): Once you have identified the genes and diseases in your Pubmed abstracts, you will want to understand how they related to each other. Is the gene the "basis in dysfunction of" the disease? Or just randomly co-occurs in the sentence?
  - Note: Many of the problems in this category are typically associated with the domain of Natural Language Processing rather than Semantic Web.
- How can we generate insight from semantically integrated data?
   - Knowledge Graphs and Machine Learning
     - [Knowledge Graph Embeddings](https://towardsdatascience.com/introduction-to-knowledge-graph-embedding-with-dgl-ke-77ace6fb60ef). The number one hype topic in recent years: How do you get from a graph of interrelated entities to a faithful representation in a vector space (basically numbers), so that Machine Learning algorithms can do their magic?
     - [Link predication](https://en.wikipedia.org/wiki/Link_prediction): Based on what we know, which are the best drug targets for my rare disease of interest?
   - Logical reasoning: While the research on deductive reasoning, at least the more "hard-core" [Description Logic](https://en.wikipedia.org/wiki/Description_logic) kind, seems to be a bit more quiet in recent years (maybe I am wrong here, I just see much less papers coming through my Google Scholar alerts now then I used to), there is still a lot going on in this domain: more efficient SPARQL engines, rule-based reasoning such as the recently commercialised [RDFox](https://link.springer.com/content/pdf/10.1007%2F978-3-319-25010-6_1.pdf) reasoner and many more. 
- Other research areas (not in any way exhaustive):
   - Web decentralisation and privacy:
     - [Solid](https://solidproject.org/): Solid (Social Linked Data) is a web decentralization project led by Tim Berners-Lee, with the aim of true ownership of personal data and improved privacy. "Pods" are like secure personal web servers for data from which application can request data.
     - [Shape validation](https://www.w3.org/2014/data-shapes/wiki/Main_Page): It is very difficult to validate huge Knowledge Graphs of interrelated data efficiently (by validate we can mean a lot of things, such as making sure that your cat does not accidentally end up as someone's "Mendelian Disease"). Shape languages such as Shex and SHACL are poised to solve this problem, but the research is ongoing.
   - New standards and tools: There is always someone proposing a new semantic standard for something or building a new kind of triple store, SPARQL extension or similar.
   
#### Typical Jobs of Semantic Data Engineers in the biomedical domain

It is useful to get a picture of the typical tasks a Semantic Data Engineer faces when building ontologies are Knowledge Graphs. In my experience, it is unlikely that any particular set of tools will work in all cases - most likely you will have to try and assemble the right toolchain for your use case and refine it over the lifetime of your project. The following are just a few points for consideration of tasks I regularly encountered - which may or may not overlap with the specific problems you will face.

##### Finding the right ontologies
There are no simple answers here and it very heavily depends on your use cases. We are discussing some places to look for ontologies [here](#tools-biomedical-research), but it may also be useful to simply upload the terms you are interested in to a service like [Zooma](https://www.ebi.ac.uk/spot/zooma/) and see what the terms map to at a major database provider like EBI.

##### Finding the right data sources
This is much harder still than it should have to be. Scientific databases are scattered across institutions that often do not talk to each other. Prepare for some significant work in researching the appropriate databases that could benefit your work, using Google and the scientific literature.

##### Extending existing ontologies
It is rare nowadays that you will have to develop an ontology entirely from scratch - most biomedical sub-domains will have some kind of reasonable ontology to build upon. However, there is often a great need to extend existing ontologies - usually because you have the need of representing certain concepts in much more detail, or your specific problem has not been modelled yet - think for example when how disease ontologies needed to be extended during the Coronavirus Crisis. Extending ontologies usually have two major facets:
1. If at all possible you should seek to contribute new terms, synonyms and relationships to the ontologies you seek to extend directly. Here, you can use GitHub to make issues requesting new terms, but more boldly, you can also add new terms yourself. We will teach you how to do that in one of the next weeks.
2. If the knowledge is considered out of scope for the ontology to be extended (for example because the terms are considered too detailed), then you will maintain your own "branch" of the ontology. Many tools such as the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) and [ROBOT](http://robot.obolibrary.org/) can help you maintain such a branch but the general instinct should be: 
  - Make a _public_ GitHub repo. 
  - Reach out to the developers of the main ontology
  - Stay in touch and coordinate releases

##### Mapping data into ontologies/knowledge graphs

Also sometimes more broadly referred to as "data integration", this problem involves a variety of tasks, such as:
1. _Named Entity Recognition_. If you have a set of documents, such as PubMed abstracts or clinical notes, you may have to first identify the parts of speech that refer to clinical entities.
2. _Entity Linking_: Once you have identified the biomedical entities of interest, you may want to link them to your existing knowledge graph. This process is sometimes called entity mapping or data mapping as well. Very often, this task is not fully automated. We have worked on projects where we used approaches to Entity Linking to suggest good mappings to users, which then had to confirm or reject them. It is also good to understand that not all entity linking must be vertical (i.e. between "equivalent" entities). Very often, there is no equivalent entity in your knowledge graph to map to, and here you need to decide whether to (a) create a new entity in the knowledge graph to map to or (b) map to a broader entity (for example "microphthalmia, isolated, with coloboma 5" to "Mendelian Disease"). What is more efficient / useful solely depends on your use case!

##### Build application ontologies

To make your data discoverable, it is often useful to extract a view from the ontologies you are using (for example, Gene Ontology, Disease Ontology) that only contains the terms and relationships of relevance to your data. We usually refer to this kind of ontology as an application ontology, or an ontology specific to your application, which will integrate subsets of other ontologies. This process will typically involve the following:
- Define a seed, or a set of terms you want to import from your external ontologies of interest.
- Extract relevant subsets from ontologies using this seed (for example using [ROBOT extract](http://robot.obolibrary.org/extract)).
- Combine and potentially link these subsets together.
- Frameworks such as the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) can help with this task, see for example the [Coronavirus Vocabulary](https://github.com/EBISPOT/covoc) maintained by EBI.

##### Leverage ontologies and knowledge graphs for you data analysis problems

There are many ways your semantic data can be leveraged for data analysis, but in my experience, two are particularly central:
1. _Data grouping and search_: make data about "microphthalmia, isolated, with coloboma 5" available when searching for data about "Mendelian Disease".
2. _Link prediction_: Figure out what additional knowledge is hidden in your data that can drive your research (e.g. possible new therapies or drug targets).


## Additional materials and resources
The open courses of the [Hasso Plattner Institute](https://open.hpi.de/) (HPI) offer introductions into the concepts around Linked Data, Semantic Web and Knowledge Engineering. There are three courses of relevance to this weeks topics, all of which overlap significantly.

- [Knowledge Engineering and the Web of Data](https://open.hpi.de/courses/semanticweb2015/overview): The oldest (2015), of the courses, but the most thorough when it comes to logical foundations, semantics and OWL. We will come back to this course in Weeks 4 and 5.
- [Linked Data Engineering](https://open.hpi.de/courses/semanticweb2016/overview): Overlaps a lot with the [Knowledge Engineering and the Web of Data](https://open.hpi.de/courses/semanticweb2015/overview) course, with a bit more RDF/Linked Data focus. 
- [Knowledge Graphs](https://open.hpi.de/courses/knowledgegraphs2020/overview): The most up-to-date of the three courses (2020), and will be referred to again in Week 12 of our course here.


## Contributors
- add name/ORCID here