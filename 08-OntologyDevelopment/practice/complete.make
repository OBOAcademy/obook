### Setup

# We keep all our intermediate files in a build directory
# These never get committed to GitHub
build:
	mkdir -p build


### Main Process

all: my_ontology.owl
test: build/report.html

# 1. Create modules in the build/ directory from the templates in the templates/ directory
#    We have two templates, 'templates/disease.tsv' and 'templates/assay.tsv' but we should try and use patterns so we don't repeat ourselves!
#    The outputs should be build/disease_module.owl and build/assay_module.owl

MODULES = build/disease_module.owl build/assay_module.owl

build/%_module.owl: templates/%.tsv | build
	robot template --template $< --output $@


# 2. Create one command by chaining together ROBOT commands to do the following (output: build/my_ontology.owl):
#    1. Merge the modules together into one file
#    2. Reason over the file

build/my_ontology.owl: $(MODULES)
	$(eval INPUTS := $(foreach I,$^,--input $(I)))
	robot merge $(INPUTS) reason --output $@


# 3. Annotate the file with an ontology IRI, a version IRI, and the following annotations (final output: my_ontology.owl):
#    - dc11:title
#    - dc11:description
#    - dc:license

my_ontology.owl: build/my_ontology.owl
	robot annotate --input $< \
	  --ontology-iri http://example.com/my_ontology.owl \
	  --version-iri http://example.com/my_ontology/2021-06-03/my_ontology.owl \
	  --annotation dc11:title "My Ontology" \
	  --annotation dc11:description "An example ontology generated using Make" \
	  --link-annotation dc:license https://creativecommons.org/licenses/by/4.0/ \
	  --output $@


# 5. Create 'build/report.html' by running ROBOT report over the finalized file
#    This is our test to make sure everything looks good before we release
build/report.html: my_ontology.owl
	robot report --input $< --labels true --output $@
