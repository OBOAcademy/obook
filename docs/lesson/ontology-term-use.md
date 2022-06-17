# Using Ontologies and Ontology Terms

### Warning
These materials are under construction and may be incomplete.

## Prerequisites
- Sign up for a free [GitHub](https://github.com/join) account

## Preparation
- None

## What is delivered as part of the course

**Description:** Using ontology terms for annotations and structuring data.

### Learning objectives
1. [Explain why ontologies are useful](#explain)
2. [Find good ontologies: ontology repositories, OBO](#find)
3. [Find terms using ontology browsers](#repo)
4. [Assess ontologies for use: license, quality](#assess)
5. [Map local terminology to ontology terms](#map)
6. [Identify missing terms](#missing)
7. [Make term requests to existing ontologies](#request)
8. [Understand the differences between IRIs, CURIEs, and labels](#iri)

## Tutorials
- None

## Additional materials and resources
- [How select and request terms from ontologies](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) - Blog post by Chris Mungall
- [Guidelines for writing definitions in Ontologies (paper)](https://philpapers.org/archive/SEPGFW.pdf)
- [OntoTips](https://douroucouli.wordpress.com/category/tutorials/) - A guide by Chris Mungall covering various aspects of ontology engineering.

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)

<a name="explain"></a> 
## 1. Why ontologies are useful

Ontologies provide a logical classification of information in a particular domain or subject area. Ontologies can be used for data annotations, for structuring disparate data types, classifying information, for inferencing and reasoning across data and computational analyses.

### Difference between a terminology and an ontology

#### Terminology
A terminology is a collection of terms; a term can have a definition and synonyms.

#### Ontology
An ontology contains a formal classification of terminology in a domain that provides textual and machine readable definitions, and defines the relationships between terms. An ontology is a terminology, but a terminology is not (necessarily) an ontology.

<a name="find"></a> 
## 2. Finding good ontologies

Numerous ontologies exist. Some recommended sources to find community developed, high quality and frequently used ontologies are listed below.

- [OBO Foundry](http://obofoundry.org/). Read more [below](#repo) 
- [The Ontology Lookup Service (OLS)](https://www.ebi.ac.uk/ols/ontologies). The OLS contains over 200 ontologies.
- [BioPortal](https://bioportal.bioontology.org/). BioPortal aggregates almost 900 biomedical ontologies, and provides a search interface to look up terms. It is a popular repository for ontologies, but as only a fraction of the ontologies are reviewed by the OBO Foundry, you should carefully review any ontologies found on BioPortal before committing to use them.
- [Ontobee](http://www.ontobee.org/). Ontobee indexes all 200+ OBO Foundry ontologies and is the default browser for OBO: For example, when you click http://purl.obolibrary.org/obo/IAO_0000112, you will be redirected to the a page in the Ontobee browser that describes the annotation property `example of usage`.

<a name="repo"></a> 
## 3. Ontology repositories

### OBO Foundry

The [OBO Foundry](http://obofoundry.org/) is a community of ontology developers that are committed to developing a library of ontologies that are open, interoperable ontologies, logically well-formed and scientifically accurate. OBO Foundry participants follow and contribute to the development of an evolving set of [principles](http://obofoundry.org/principles/fp-000-summary.html) including open use, collaborative development, non-overlapping and strictly-scoped content, and common syntax and relations, based on ontology models that work well, such as the [Gene Ontology (GO)](http://geneontology.org/).

The OBO Foundry is overseen by an [Operations Committee](http://obofoundry.org/docs/OperationsCommittee.html) with Editorial, Technical and Outreach working groups.

### Find terms using ontology browsers
Various ontology browsers are available, we recommend using one of the ontology browsers listed below.

- Find terms:
  - [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index)
  - [BioPortal](https://bioportal.bioontology.org/)
  - [Ontobee](http://www.ontobee.org/)

<a name="assess"></a> 
## 4. Assessing ontologies for use

Some considerations for determining which ontologies to use include the license and quality of the ontology.

### License

Licenses define how an ontology can legally be used or reused. One requirement for OBO Foundry Ontologies is that they are open, meaning that the ontologies are openly and freely available for use with acknowledgement and without alteration. OBO ontologies are required to be released under a Creative Commons [CC-BY license version 3.0 or later](https://creativecommons.org/licenses/by/3.0/), OR released into the public domain under [CC0](https://creativecommons.org/publicdomain/zero/1.0/). The license should be clearly stated in the ontology file.

### Quality

Some criteria that can be applied to determine the quality of an ontology include:

- **Is there an ontology tracker to report issues?** All open ontologies should have some form of an issue tracker to report bugs, make new term requests or request other changes to the ontology. Many ontologies use GitHub to track their issues. 
- **Is it currently active?** Are there a large number of open tickets on the ontology tracker that have not been commented on or otherwise addressed? Are the tickets very old, have been sitting for years?
- **Commmunity involvement** On the issue tracker, is there evidence of community involvement, such as issues and comments from outside community members?
- **Scientifically sound** Does the ontology accurately represent the domain in a scientifically sound way?

### How to determine which is the right ontology to use?

- There are multiple ontologies that exist, start by selecting the appropriate ontology, then search and restrict your search to that ontology.
- Recommend using ontologies that are open and interoperable. Focusing on OBO foundry ontologies are a good place to start
- Make informed decision about which ontology to use
- Maybe the ontology you want to use does not have the term you want, so [make a term request to that ontology](#request)

<a name="map"></a> 
## 5. Mapping local terminology to ontology terms

Data can mapped to ontology terms manually, using spreadsheets, or via curation tools such as:

- [Zooma](https://bio.tools/zooma)
- [BioPortal Annotator](https://bioportal.bioontology.org/annotator)
- [Canto](http://gmod.org/wiki/Canto) - a web-based literature curation tools
- [Textpresso](http://www.textpresso.org/celegans/) - designed for C. elegans curation
- [OntoBrowser](https://opensource.nibr.com/projects/ontobrowser) - an online collaborative curation tool

<a name="missing"></a> 
## 6. Identifying missing terms

The figure below by [Chris Mungall](https://bids.berkeley.edu/people/chris-mungall) on his blog post on [How to select and request terms from ontologies
](https://douroucouli.wordpress.com/2021/07/03/how-select-and-request-terms-from-ontologies/) describes a workflow on searching for identifying missing terms from an ontology. 

![term search and request workflow](https://lh5.googleusercontent.com/gpGaVX6N85gdQkBP5aZORh3G_oA1B71Hf9P2Pobl0InlAY2P7U7XWkH1iv8rsQpJtOuW2bazkhYsSOxfFGod15TvMg21gOYLAv1mcVHxkAqQHPucBm6Su-tl2IWgJXFKwd9L2xbd)

<a name="request"></a> 
## 7. Make term requests to existing ontologies

See separate lesson on [Making term requests to existing ontologies]().

<a name="iri"></a> 
## 8. Differences between IRIs, CURIEs, and labels

#### URI 
A uniform resource identifier (URI) is a string of characters used to identify a name or a resource. 

#### URL
A URL is a URI that, in addition to identifying a network-homed resource, specifies the means of acting upon or obtaining the representation.

A URL such as this one: 

https://github.com/obophenotype/uberon/blob/master/uberon_edit.obo

has three main parts:
1. Protocol, e.g. https
2. Host, e.g. github.com
3. Path, e.g. /obophenotype/uberon/blob/master/uberon_edit.obo

The protocol tells you how to get the resource. Common protocols for web pages are http (HyperText Transfer Protocol) and https (HTTP Secure). 
The host is the name of the server to contact (the where), which can be a numeric IP address, but is more often a domain name. 
The path is the name of the resource on that server (the what), here the Uberon anatomy ontology file.


#### IRI
A Internationalized Resource Identifiers (IRI) is an internet protocol standard that allows permitted characters from a wide range of scripts. While URIs are limited to a subset of the ASCII character set, IRIs may contain characters from the Universal Character Set (Unicode/ISO 10646), including Chinese or Japanese kanji, Korean, Cyrillic characters, and so forth. It is defined by [RFC 3987](https://datatracker.ietf.org/doc/html/rfc3987).

More information is available [here](https://www.w3.org/International/articles/idn-and-iri/).

#### CURIEs
A Compact URI (CURIE) consists of a prefix and a suffix, where the prefix stands in place of a longer base IRI. 

By converting the prefix and appending the suffix we get back to full IRI. For example, if we define the obo prefix to stand in place of the IRI as:
http://purl.obolibrary.org/obo/, then the CURIE 
obo:UBERON_0002280 
can be expanded to 
http://purl.obolibrary.org/obo/UBERON_0002280, which is the UBERON Anatomy term for ‘otolith’. 
Any file that contains CURIEs need to 
define the prefixes in the file header.

#### Label

A label is the textual, human readable name that is given to a term, class property or instance in an ontology.  
