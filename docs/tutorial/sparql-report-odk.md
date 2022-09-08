# Generating SPARQL table reports with ODK

This tutorial will teach you how to create report tables using SPARQL and the ODK. Report tables are TSV files that can be viewed by programs such as Excel or Google Sheets.

For a tutorial on how to generate reports independent of ODK please see [here]().

## Preparation

- You are [set up for executing ODK workflows](../howto/odk-setup.md)
- We assume you have a modern ODK-based repository (ODK version >= 1.2.32) set up. For a tutorial on creating a new ontology repo from scratch see [here](setting-up-project-odk.md).
- Finish the [ROBOT tutorial on queries](sparql-report-robot.md)

## Tutorial

### Adding a configuration to the ODK YAML file:

```
robot_report:
  custom_sparql_exports:
    - basic-report
    - my-cat-report
```

This will tell the ODK that you no longer wish to generate the ODK default reports (synonyms, xrefs, etc), but instead:

1. One of the custom reports (`basic-report`)
1. and a new custom report, called `my-cat-report`.

Now, we can apply these changes as usual:

```
sh run.sh make update_repo
```

### Adding the actual table report

Similar to our [ROBOT tutorial on queries](sparql-report-robot.md), let us now add a simple table report for the terms and labels in our ontology. To do that, let us safe the following file in our `src/sparql` directory (standard ODK setup), i.e. `src/sparql/my-cat-report.sparql` (you must use the same name as the one you speciefied in your ODK yaml file above):

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT ?term ?property ?value
WHERE {
  ?term a owl:Class ;
  rdfs:label ?value .
}
```

Now, let's generate our report (you have to be, as always, in `src/ontology/`):

```
sh run.sh make custom_reports
```

This will generate all custom reports you have configured in one go and save them in the `src/ontology/reports` directory. `reports/my-cat-report.tsv` looks probably something like this for you:

```
?term	?property	?value
<http://purl.obolibrary.org/obo/CATO_0000000>		"root node"@en
...
```

That is all there is. You can configure as many reports as you want, and they will all be generated with the `custom_reports` command above, or as part of your ontology releases.
