# Tutorial: How to add custom quality checks with ODK

This tutorial explains adding quality checks not included in the [ROBOT Report](http://robot.obolibrary.org/report_queries/).

## Prerequisites

You have completed the tutorials:

1. [Getting started with your own repo](setting-up-project-odk.md)
1. [20 minute complete walk-through](odk-tutorial-2.md)


## Custom Quality Checks

1. Write the SPARQL query to detect the error you want to check. For example, check for 

```sparql

```

2. Save the SPARQL query in the `src/sparql` folder and name it `[violation name]-violation.sparql`. In the case of the tutorial, `check-violation.sparql`

3. Add the check to the ODK config file. In the [previous tutorial](setting-up-project-odk.md), this is located at `~/cato/src/ontology/cato-odk.yaml`. Inside `robot_report`, add `custom_sparql_checks`

```yaml
robot_report:
  use_labels: TRUE
  fail_on: ERROR
  custom_profile: TRUE
  report_on:
    - edit
  custom_sparql_checks:
    - violation-name
```

4. Update the repository. After adding the custom SPARQL check, you need to update your pipeline to take this check when testing the ontology.

```bash
sh run.sh make update_repo
```

5. Test the check. You can run the checks and verify the expected result.

```bash
sh run.sh make sparql_test

PASS Rule ../sparql/violation-name-violation.sparql: 0 violation(s)
PASS Rule ../sparql/owldef-self-reference-violation.sparql: 0 violation(s)
```

The custom checks will run whenever creating a new Pull Request, as detailed [here](odk-tutorial-2.md#integration-testing).

## Custom checks available in ODK

There are several checks already available in the ODK. If you'd like to add them, add the validation name in your ODK config file.

1. `owldef-self-reference`: verify if the term uses its term as equivalent
1. `redundant-subClassOf`: verify if there are redundant subclasses between three classes
1. `taxon-range`: verify if the annotations `present_in_taxon` or `never_in_taxon` always use classes from [NCBITaxon](https://www.ebi.ac.uk/ols/ontologies/ncbitaxon)
1. `iri-range`: verify if the value for the annotations `never_in_taxon`, `present_in_taxon`, `foaf:depicted_by`, `oboInOwl:inSubset` and `dcterms:contributor` are not an IRI
1. `iri-range-advanced`: same as `iri-range` plus check for `rdfs:seeAlso` annotation
1. `label-with-iri`: verify if there is IRI in the label
1. `multiple-replaced_by`: verify if an obsolete term has multiple `replaced_by` terms
1. `term-tracker-uri`: verify if the value for the annotation [term_tracker_item](http://purl.obolibrary.org/obo/IAO_0000233) is not URI
1. `illegal-date`: verify if the value for the annotations `dcterms:date`, `dcterms:issued` and `dcterms:created` are of type `xds:date` and use the pattern `YYYY-MM-DD`