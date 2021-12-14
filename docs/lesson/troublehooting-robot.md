# Lessons learned from troubleshooting ROBOT

## Prerequisites
- Review tutorial on [Ontology pipelines with ROBOT and SPARQL](https://oboacademy.github.io/obook/lesson/ontology_pipelines/)
- Review tutorial on [Ontology Pipelines with ROBOT 2](https://oboacademy.github.io/obook/lesson/ontology_pipelines/)

### Learning objectives
Learn common mistakes when using ROBOT and how to troubleshoot and fix them.

## Lessons learned
#### Copying-pasting (especially in google docs) can introduce **unexpected format changes** in row 2 of the template: 
  - Note that these format changes are not always visible. 
  - The most common typos are:
    - introduction of space in cells 
    - single quotes are changed into apostrophes
  - These errors are most commonly reported as "MANCHESTER PARSE ERROR"

#### Restrictions for the **first 2 rows of a ROBOT template**: 
  - In the same column, it is OK to have a header string (row #1) with no template string (row #2).
    - the information in the column is useful to curators (e.g. term labels) but will be ignored by ROBOT. 
<img src="https://user-images.githubusercontent.com/6722114/146070142-783046bb-bf39-49fb-8df8-a6ba1ae58889.png" width=25% height=25%>

  - In the same column, if there is a template string (row #2), there MUST be a header string (row #1) 
    - if the row #1 is missing, the error will be reported as: COLUMN MISMATCH ERROR the template string in column 1 must have a corresponding header in table "tmp/merge_template.tsv” 
<img src="https://user-images.githubusercontent.com/6722114/146069799-3beb5e51-28d0-41d1-88c4-f5953fe5c2b2.png" width=25% height=25%>

#### The content of the template break some **OBO or Protege rules**
  - for example, Protege only allows one comment on a class. If you are adding new comments to terms via ROBOT, you will get an error if a comment already exists on a term.
    - error will be reported as: OBO STRUCTURE ERROR Ontology does not conform to OBO structure rules: multiple comment tags not allowed. 
  - Note: If you run ROBOT and get an error, it may create a blank file. You need to discard the changes and/or open a new branch. The error with the optional “null” is when the mondo-edit file is empty.  
`Optional.get() cannot be called on an absent value`  
`Use the -vvv option to show the stack trace.`   
`Use the --help option to see usage information`     
`make: *** [mondo.Makefile:454: merge_template] Error 1`    

#### **New ID prefix**: 
  - ROBOT template can be used to add axioms containing terms (and IDs) from other ontologies which were recently imported
  - The ID prefix is not recognized by ROBOT, and the error is reported as MANCHESTER PARSE ERROR
  - Resolution: the ontology Makefile should be updated to include the prefix in the merge_template. 
  - Note: If you run ROBOT and get an error, it may create a blank file. You need to discard the changes and/or open a new branch. 

## Example templates

- Example templates from Mondo are available [here](https://github.com/monarch-initiative/mondo/tree/master/src/templates)
- Example templates from OBI are available [here](https://github.com/obi-ontology/obi/tree/master/src/ontology/templates)

## Contributors
- Sabrina Toro ([ORCID](https://orcid.org/0000-0002-4142-7153))
- Nicole Vasilevsky ([ORCID](https://orcid.org/0000-0001-5208-3432))
