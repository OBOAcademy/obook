# The Semantic OBO Engineer's Toolbox

**Essentials**

- [Protégé](https://protege.stanford.edu/)
    - [DL Query Tab](https://protegewiki.stanford.edu/wiki/DLQueryTab)
- [ROBOT](http://robot.obolibrary.org)
- [OBO Dashboard](http://dashboard.obofoundry.org/): OBO-wide quality control monitor for OBO ontologies.

**Automation**

- [GNU Make](https://www.gnu.org/software/make/)
- [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit)
- [DROID](https://github.com/ontodev/droid): DROID is a web-based interface for working with `make`, managed by `git`.


**Text editors:**

- [Kakoune](https://kakoune.org/) text/code editor
- [Sublime](https://www.sublimetext.com/)
- [Atom](https://atom.io/)

**SPARQL query tool:**

- [Yasgui](https://yasgui.triply.cc/#) 
- [ROBOT query](http://robot.obolibrary.org/query)

**Templating systems**

- [DOSDP](https://incatools.github.io/dead_simple_owl_design_patterns/)
- [ROBOT template](http://robot.obolibrary.org/template)

**Ontology Mappings**

- [SSSOM and sssom-py](https://mapping-commons.github.io/sssom-py/index.html#): Toolkit and framework for managing mappings across and beyond ontologies.

**Where to find ontologies and terms: Term browsers and ontology repositories**

- [OLS](https://www.ebi.ac.uk/ols/index): The boss of the current term browsers out there. While the code base is a bit dated, it still gives access to a wide range of relevant open biomedical ontology terms. Note, while being a bit painful, it is possible to [set up your own OLS](https://github.com/EBISPOT/ontotools-docker-config) (for your organisation) which only contains those terms/ontologies that are relevant for your work.
- [Ontobee](http://www.ontobee.org/): The default term browser for OBO term purls. For example, click on http://purl.obolibrary.org/obo/OBI_0000070. This will redirect you directly to Ontobee, to show you the terms location in the hierarchy. In practice, there is no particular reason why you would favour Ontobee over OLS for example - I just sometimes prefer the way Ontobee presents annotations and "uses" by other ontologies, so I use both.
- [AberOWL](http://aber-owl.net/#/): Another ontology repository and semantic search engine. Some ontologies such as [PhenomeNet](http://aber-owl.net/ontology/PhenomeNET/) can only be found on AberOWL, however, I personally prefer OLS.
- [identifiers.org](https://identifiers.org/): A centralised registry for identifiers used in the life sciences. This is one of the tools that bridge the gap between CURIEs and URLs, but it does not cover (OBO) ontologies very well, and if so, is not aware of the proper URI prefixes (see for example [here](https://identifiers.org/resolve?query=HP:0000001), and HP term resolution that does not list the proper persistent URL of the HP identifier (http://purl.obolibrary.org/obo/HP_0000001)). Identifiers.org has mainly good coverage for databases/resources that use CURIE type identifiers. But: you can enter any ID you find in your data and it will tell you what it is associated with.
- [OBO Foundry Ontology Library](http://obofoundry.org/). The OBO Foundry works with other repositories and term browsers such as OLS, Ontobee and BioPortal. For example, OLS directly reads the OBO Foundry registry metadata, and automatically loads new ontologies added to the OBO Foundry Ontology Library.
- [BioPortal](https://bioportal.bioontology.org/)
    - [CPT Story](https://www.bioontology.org/why-bioportal-no-longer-offers-the-current-procedural-terminology-cpt/). The Current Procedural Terminology was the by far most highly accessed Terminology on Bioportal - for many years. Due to license concerns, it had to be withdrawn from the repository. This story serves a cautionary tale of using terminologies with non-open or non-transparent licensing schemes.
- [AgroPortal](http://agroportal.lirmm.fr/): Like BioPortal, but focussed on the Agronomy domain.
- [Linked Open Data Vocabularies (LOV)](https://lov.linkeddata.es/dataset/lov/): Lists the most important vocabularies in the Linked Data space, such as [Dublin Core](https://dublincore.org/), [SKOS](https://www.w3.org/TR/skos-reference/) and [Friend-of-a-Friend](http://xmlns.com/foaf/spec/) (FOAF). 

### Nico's top 10 tools for the Semantic OBO Engineer's Toolbox

1. [ROBOT](http://robot.obolibrary.org)
2. [Protégé](https://protege.stanford.edu/)
3. Term browsers ([OLS](https://www.ebi.ac.uk/ols/index), [Ontobee](http://www.ontobee.org/))
4. [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit)
5. SPARQL (e.g. [ROBOT query](http://robot.obolibrary.org/query) and [Yasgui](https://yasgui.triply.cc/#))
6. [GNU Make](https://www.gnu.org/software/make/)
7. Text editor workflows (i.e. [Atom](https://atom.io/), Sublime, VIM): a bit of regex
8. Basic Shell scripting and pipelining
9. From tables to ontologies: [DOSDP templates](https://incatools.github.io/dead_simple_owl_design_patterns/) and [ROBOT templates](http://robot.obolibrary.org/template)
10. [GitHub Actions](https://docs.github.com/en/actions)


**Other tools in my toolbox**

These are a bit less essential than the above, but I consider them still tremendously useful.

- [Cogs](https://github.com/ontodev/cogs) (experimental) for automatically synchronising your spreadsheets with Google Sheets.
- Basic [Dockerfile development](https://docs.docker.com/get-started/02_our_app/): This can help you automate processes that go beyond usual ODK day-to-day business, such as automated mapping tools, graph machine learning, NLP etc.
- [GitHub](https://github.com/) community management and git version control: Learn how to effectively manage your contributors, issue requests and code reviews. Also get your git commands straight - these can be life savers!
- [Basics in python scripting](https://docs.python.org/3/tutorial/): This is always useful, and python is our go-to language for most of automation nowadays - this used to be Java. Most of the Java heavy lifting is done in ROBOT now!
- [SSSOM and sssom-py](https://mapping-commons.github.io/sssom-py/index.html#): Toolkit and framework for managing mappings between ontologies.
- [DROID](https://github.com/ontodev/droid): DROID is a web-based interface for working with `make`, managed by `git`.
- [OBO Dashboard](http://dashboard.obofoundry.org/): OBO-wide quality control monitor for OBO ontologies.