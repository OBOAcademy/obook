# Lessons learned from troubleshooting ROBOT

### Warning
These materials are under construction and incomplete.

## Prerequisites
- Review tutorial on [Ontology pipelines with ROBOT and SPARQL](https://oboacademy.github.io/obook/lesson/ontology_pipelines/)
- Review tutorial on [Ontology Pipelines with ROBOT 2](https://oboacademy.github.io/obook/lesson/ontology_pipelines/)

### Learning objectives
- Learn common mistakes when using ROBOT and how to troubleshoot and fix them

## Lessons learned
- Protege only allows one comment on a class. If you are adding new comments to terms via ROBOT, you will get an error if a comment already exists on a term.
- If you run ROBOT and get an error, it may create a blank file. You need to discard the changes and/or open a new branch. The error with the optional “null” is when the mondo-edit file is empty.  
`Optional.get() cannot be called on an absent value`  
`Use the -vvv option to show the stack trace.`   
`Use the --help option to see usage information`     
`make: *** [mondo.Makefile:454: merge_template] Error 1`    

## Open questions
- How do we create a new ontology from scratch using ROBOT?

## Contributors
- Sabrina Toro ([ORCID](https://orcid.org/0000-0002-4142-7153))
- Nicole Vasilevsky ([ORCID](https://orcid.org/0000-0001-5208-3432))
