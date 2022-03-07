# Basic SPARQL for OBO Engineers

In this tutorial we introduce SPARQL, with a particular spin on how we use it across OBO ontologies. Following this tutorial should give you a sense of how we use SPARQL across OBO, without going too much into technical details. You can find concrete tutorials on how to generate reports or QC checks with ROBOT and ODK towards the end of this page.

## Preparation

- [Watch Linked Data Engineering: Querying RDF with SPARQL](https://www.youtube.com/watch?v=eWgglavS_VE&list=PLoOmvuyo5UAfY6jb46jCpMoqb-dbVewxg&index=25&ab_channel=OpenHPITutorials)
<iframe width="560" height="315" src="https://www.youtube.com/embed/eWgglavS_VE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
- Complete [Running Basic SPARQL Queries](https://medium.com/virtuoso-blog/dbpedia-basic-queries-bc1ac172cc09) tutorial (~45 minutes - 1 hour)

## SPARQL tools for OBO Engineers

- [RENCI Ubergraph Endpoint](https://api.triplydb.com/s/PHnGm2l5t): Many key OBO ontologies are loaded here with lots of materialised inferences ([docs](https://github.com/INCATools/ubergraph/)).
- [Ontobee SPARQL endpoint](http://www.ontobee.org/sparql): Useful to run queries across all OBO Foundry ontologies.
- [Yasgui](https://yasgui.triply.cc/): Yasgui is a simple and beautiful front-end for SPARQL endpoints which can be used not only to query, but also to share queries with others. For example [this simple SPARQL query](https://api.triplydb.com/s/r36KJ3x-D) runs across the RENCI Ubergraph Endpoint.
- [GTF](https://sparql.gtf.fyi): A UI that allows one to run SPARQL queries on TTL files on the web, or upload them. Looks like its based on Yasgui, as it shares the same share functionality.
- [ROBOT query](http://robot.obolibrary.org/query): ROBOT method to generate TSV reports from SPARQL queries, and applying data transformations (`--update`). ROBOT uses [Jena](https://jena.apache.org/tutorials/sparql.html) internally to execute SPARQL queries.
- [ROBOT verify](http://robot.obolibrary.org/verify): ROBOT method to run SPARQL QC queries. If the query returns a result, the QC test fails.
- [ROBOT report](http://robot.obolibrary.org/report): ROBOT report is a more powerful approach to running OBO QC queries. The default OBO report which ships with ROBOT can be customised by changing the error level, removing a test entirely and even extending the report to custom (SPARQL) checks. Robot report can generate beautiful HTML reports which are easy to read.

## SPARQL in the OBO-sphere

SPARQL has many uses in the OBO-sphere, but the following in particular:

1. Quality control checking
2. Creating summary tables for ontologies
3. Sophisticated data transformations in ontology pipelines

We will discuss each of these in the following and give examples. An informal discussion of SPARQL in OBO can be followed here:

<iframe src="https://drive.google.com/file/d/1dueong-Du3WPPRvpYoHeFIau-_4F_6Hg/preview" width="640" height="480" allow="autoplay"></iframe>

### Quality control checking

For us, ROBOT + SPARQL were a game changer for our quality control (QC) pipelines. This is how it works. First, we encode the error in the form of a SPARQL query (we sometimes call this "anti-pattern", i.e. an undesirable (anti-) representation). For example, the following check simply looks for entities that [have more than one definition](http://robot.obolibrary.org/report_queries/multiple_definitions):

```
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  VALUES ?property { obo:IAO_0000115
                     obo:IAO_0000600 }
  ?entity ?property ?value .
  ?entity ?property ?value2 .
  FILTER (?value != ?value2)
  FILTER NOT EXISTS { ?entity owl:deprecated true }
  FILTER (!isBlank(?entity))
}
ORDER BY ?entity
```

This is a typical workflow. Think of an ontology editor working on an ontology. Often, that curator notices that the same problem happens repeatedly and tell us, the Ontology Pipeline Developer, that they would like a check to prevent the error. We then capture the erroneous situation as a SPARQL query. Then, we add it to our [ontology repository](https://github.com/monarch-initiative/mondo/tree/master/src/sparql/qc), and execute it with ROBOT report or ROBOT verify (see above) in our CI pipelines, usually based on GitHub actions or Travis. Note that the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) provides a built-in framework for for such queries build on ROBOT verify and report. 

### Creating summary tables for ontologies

Many times, we need to create tabular reports of our ontologies to share with stakeholders or to help with internal reviews, e.g.:

- create lists of ontology terms with their definitions and labels
- create summaries of ontologies, like aggregate statistics

Sometimes using [Yasgui](https://yasgui.triply.cc/), for example in conjunction with the RENCI Ubergraph Endpoint, is enough, but often, using ROBOT query is the better choice, especially if you want to make sure the right version of the ontology is used (Ubergraph occasionally is out of date).

Using ROBOT in conjunction with a Workflows Automation system like Github actions helps with generating up-to-date reports. [Here is an example](https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/diff.yaml) of a GitHub action that generates a few reports with ROBOT and pushes them back to the repository.

#### A note for Data Scientists

In many cases we are asked how to best "load an ontology" into a python notebook or similar. Very often the answer is that it is best to first _extract_ the content of the ontology into a table form, and then load it using a CSV reader like `pandas`. In this scenario, the workflow for interacting with ontologies is:

1. Define the information you want in the form of a SPARQL query.
1. Extract the the information as a TSV table using ROBOT query.
1. Load the information into your notebook.

If combined with for example a Makefile, you can always ensure that the report generation process is fully reproducible as well.

### Sophisticated data transformations in ontology pipelines

Lastly, we use ROBOT query to implement complex ontology transformation processes. For example the following complex query transforms related synonyms to exact synonyms if some complex condition is met:

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
  ?term oboInOwl:hasRelatedSynonym ?related .
  ?relax a owl:Axiom ;
       owl:annotatedSource ?term ;
       owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
       owl:annotatedTarget ?related ;
       oboInOwl:hasDbXref ?xref2 .
}

INSERT {
  ?relax a owl:Axiom ;
       owl:annotatedSource ?term ;
       owl:annotatedProperty oboInOwl:hasExactSynonym ;
       owl:annotatedTarget ?related ;
       oboInOwl:hasDbXref ?xref2 .
}
WHERE 
{ 
  { 
    ?term oboInOwl:hasRelatedSynonym ?related ;
      oboInOwl:hasExactSynonym ?exact ;
      a owl:Class .
      ?exax a owl:Axiom ;
           owl:annotatedSource ?term ;
           owl:annotatedProperty oboInOwl:hasExactSynonym ;
           owl:annotatedTarget ?exact ;
           oboInOwl:hasDbXref ?xref1 .
      ?relax a owl:Axiom ;
           owl:annotatedSource ?term ;
           owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
           owl:annotatedTarget ?related ;
           oboInOwl:hasDbXref ?xref2 .
    
    FILTER (str(?related)=str(?exact))
    FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
  }
}
```

This can be a very useful tool for bulk editing the ontology, in particular where it is difficult or impossible to achieve the same using regular expressions or other forms of "replacement"-techniques. Here are [some example](https://github.com/monarch-initiative/mondo/tree/master/src/sparql/update) queries we collected to do such mass operations in Mondo.

### Related tutorials

- [QC checks with ROBOT](robot-tutorial-qc.md)
- [Generating SPARQL table reports with ROBOT](sparql-report-robot.md)
- [Generating SPARQL table reports with ODK](sparql-report-odk.md)
