### Setup

# We keep all our intermediate files in a build directory
# These never get committed to GitHub
build:
	mkdir -p build


### Hints

# $@ = target (output)
# $< = first dependency
# $^ = list of all dependencies (does not include order-only)
# % = wildcard
# $(VAR) = reference a variable named VAR
# | = separate order-only prereqs in dependency list
#     These do not cause a target to get rebuilt if the timestamp changes, it basically only checks that it exists
#     ... so using order-only prereqs is perfect when you have a directory as a dependency, for example 'build'


### Main Process

all: my_ontology.owl
test: build/report.html


# 1. Create modules in the build/ directory from the templates in the templates/ directory
#    We have two templates, 'templates/disease.tsv' and 'templates/assay.tsv' but we should try and use patterns so we don't repeat ourselves!
#    The outputs should be build/disease_module.owl and build/assay_module.owl


# 2. Create one command by chaining together ROBOT commands to do the following:
#    1. Merge the modules together into one file (output: build/merged.owl)
#       Hint: $(eval INPUTS := $(foreach I,$^,--input $(I)))
#    2. Reason over the file


# 3. Annotate the file with an ontology IRI, a version IRI, and the following annotations (final output: my_ontology.owl):
#    - dc11:title
#    - dc11:description
#    - dc:license


# 4. Create 'build/report.html' by running ROBOT report over the finalized file
#    This is our test to make sure everything looks good before we release