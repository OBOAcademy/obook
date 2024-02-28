# Other Resources

Here's a collection of links about the Open Biological and Biomedical Ontologies (OBO),
and related topics.

If you're completely new to OBO,
I suggest starting with [Ontologies 101](https://github.com/OHSUBD2K/BDK14-Ontologies-101):

- [Unit 1: Controlled Vocabularies, Ontologies, and Data Linking](https://github.com/OHSUBD2K/BDK14-Ontologies-101/blob/master/BDK14-1.pptx) (PowerPoint Slides)
- [Unit 2: An Introduction to OWL](https://github.com/OHSUBD2K/BDK14-Ontologies-101/blob/master/BDK14-2.pptx) (Powerpoint Slides)
- [Unit 3: Ontology Community](https://github.com/OHSUBD2K/BDK14-Ontologies-101/blob/master/BDK14-3.pptx) (Powerpoint Slides)
- [BDK14 Ontologies 101 repository](https://github.com/OHSUBD2K/BDK14-Ontologies-101)

If you're new to scientific computing more generally,
then I strongly recommend [Software Carpentry](https://software-carpentry.org),
which provides a set of very pragmatic introductions to
the Unix command line, git, Python, Make,
and other tools widely used by OBO developers.

## Open Biological and Biomedical Ontologies

OBO is a community of people collaborating on open source ontologies for science.
We have a set of shared principles and best practises
to help people and data work together effectively.

- [OBO Foundry Homepage](http://obofoundry.org)
- [The OBO Foundry: coordinated evolution of ontologies to support biomedical data integration](https://www.nature.com/articles/nbt1346) (journal article)
- [OBO Discuss](https://groups.google.com/forum/#!forum/obo-discuss) mailing list

## Services

Here is a very incomplete list of some excellent services
to help you find an use OBO terms and ontologies.

- EMBL-EBI
  - [OLS: Ontology Lookup Service](https://www.ebi.ac.uk/ols/index)
    is an excellent ontology browser and search service
  - [OxO](https://www.ebi.ac.uk/spot/oxo/)
    shows mappings between ontologies and terms
  - [Zooma](https://www.ebi.ac.uk/spot/zooma/)
    for mapping free text to ontology terms
- Onto-Animals
  - [Ontobee](http://www.ontobee.org)
    is an ontology browser
  - [Ontofox](http://ontofox.hegroup.org)
    is an ontology extraction tool
- [Bioportal](http://bioportal.bioontology.org)
  provides ontology browsing, search, mapping, etc.
- [Bioregistry](https://bioregistry.io)
  provides metadata for ontologies and other semantic resources

## Tools

This is the suite of open source software that most OBO developers use.

- [OBO Tools](https://groups.google.com/forum/#!forum/obo-tools) mailing list
- [GitHub](https://github.com)
  is where most OBO projects are hosted
  and what we use to manage code, issues, etc.
  - [GitHub tutorial](https://guides.github.com/activities/hello-world/)
- [Protégé](https://protege.stanford.edu)
  is a graphical user interface for editing OWL ontologies. (Java)
- [ROBOT](http://robot.obolibrary.org)
  is a command-line tool for automating ontology tasks. (Java)
  - [ROBOT tutorial](https://github.com/ontodev/robot-tutorial)
  - [ROBOT: A Tool for Automating Ontology Workflows](https://link.springer.com/article/10.1186/s12859-019-3002-3) (journal article)
  - [ENVO ROBOT Template and Merge Workflow](https://github.com/EnvironmentOntology/envo/wiki/ENVO-Robot-template-and-merge-workflow)
- [DOS-DP](https://github.com/INCATools/dead_simple_owl_design_patterns)
  is a command-line tool for working with ontology design patterns. (Python)
- [ODK: Ontology Development Kit](https://github.com/INCATools/ontology-development-kit)
  is a collection of tools for building and maintaining an OBO project. (Docker)
  - [OBO Tools and Workflows](https://docs.google.com/presentation/d/1Qc5Y7mJtDtNcmxugGJptZvRA3fPzaJmsZsxztwaAgC8/edit) (Google Slides)
    A good overview of technical and advanced topics of OBO practises,
    including the Ontology Development Kit.
- [OWLAPI](https://github.com/owlcs/owlapi)
  is a Java library for working with ontologies,
  and is the foundation for Protégé and ROBOT.
- [`curies`](https://github.com/cthoyt/curies) is a Python library for working with prefix maps
  and extended prefix maps and converting between CURIEs and URIs.
- [OBO PURL System](https://github.com/OBOFoundry/purl.obolibrary.org)
  is used to redirect OBO terms from their IRIs to the right resource
  - [String of PURLs – frugal migration and maintenance of persistent identifiers](https://content.iospress.com/articles/data-science/ds190022) (journal article)

## Technical

This section is for technical reference, not beginners.

OBO projects use Semantic Web and Linked Data technologies:

- [W3C Semantic Web overview](https://www.w3.org/standards/semanticweb/)
- [Search for W3C data standards](https://www.w3.org/TR/?tag=data)
- [W3C Data on the Web Best Practices](https://www.w3.org/TR/dwbp/)

These standards form layers:

1. [IRI: Internationalized Resource Identifiers](https://tools.ietf.org/html/rfc3987)
   are a superset of the familiar URLs used to locate resources on the web.
   Every ontology term has a globally unique IRI.
2. RDF: Resource Description Format
   is a standard for combining IRIs into subject-predicate-object "triples"
   that make a statement about some thing.
   Sets of triples form a graph (i.e. network),
   and graphs can easily be merged to form larger graphs.
   SPARQL is the language for querying RDF graphs.
   - [RDF 1.1 Primer](http://www.w3.org/TR/rdf11-primer/)
   - [SPARQL 1.1 Overview](http://www.w3.org/TR/sparql11-overview/)
3. RDFS: [RDF Schema 1.1](http://www.w3.org/TR/rdf-schema/)
   extends RDF with classes, hierarchies, and other features.
4. XSD: [W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes](http://www.w3.org/TR/xmlschema11-2/)
   is the common standard for datatypes in RDF
5. OWL: Web Ontology Language
   extends RDF and RDFS to provide more powerful logic
   - [OWL 2 Web Ontology Language Primer (Second Edition)](http://www.w3.org/TR/owl2-primer/)

Other useful resources on technical topics:

- [Monkeying around with OWL](https://douroucouli.wordpress.com)
  Chris Mungall's blog, mostly on technical topics for ontologies.
