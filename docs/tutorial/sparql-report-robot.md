# Generating SPARQL table reports with ROBOT

## Preparation

- You should be able to run ROBOT.

## Overview:

Creating table outputs from your ontology helps with many issues, for example during ontology curation (it is often easier to look at tables of related ontology terms rather than a hierarchy), for data aggregation (you want to know how many synonyms there are, and which) and simply to share "a list of all terms with labels". There are two major tools to help here:

- [ROBOT export](http://robot.obolibrary.org/export): Exporting _standardised_ tables for typical use cases, like labels, definitions and similar. For details, please look at the documentation which should provide all the information for producing table reports.
- [ROBOT query](http://robot.obolibrary.org/query): Generating reports using SPARQL. This is the focus of the tutorial here.

## Download test ontology

Download [`example.owl`](robot_tutorial_qc/example.owl), or get it via the command line:

```
curl https://raw.githubusercontent.com/OBOAcademy/obook/master/docs/tutorial/robot_tutorial_qc/example.owl > example.owl
```

Let us ensure we are using the same ROBOT version:

```
robot --version
```

We see:

```
ROBOT version 1.8.3
```

## Generating a simple report

Very frequently, we wish need to create summary tables (for a more detailed motivation see [here](sparql.md)).

Here, lets generate a simple report table by specifying a query:

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?term ?property ?value
WHERE {
  ?term rdfs:label ?value .
}
```

Let us safe the query as `labels.sparql` in our working directory.

Let's now generate the report:

```
robot query -i example.owl --query labels.sparql labels.tsv
```

When looking at labels.tsv (in a text editor, or Excel, or whatever table editor you prefer), we notice that some properties are included in our list and decide to change that by restricting the results to classes:

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT ?term ?property ?value
WHERE {
  ?term a owl:Class ;
  rdfs:label ?value .
}
```

Now, when running the `robot query` command again, we see only the terms we want.

Note that you could have achieved all this with a simple [ROBOT export](http://robot.obolibrary.org/export) command. However, there are many cool ways you can tweak your reports when you learn how to build them manually during SPARQL. Your only limit is essentially SPARQL itself, which gives you access too most things in your ontology, aside from perhaps complex logical axioms.
