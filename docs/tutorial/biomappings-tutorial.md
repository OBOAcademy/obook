# Curating Semantic Mappings with Biomappings

Background:

1. There are lots of partially overlapping ontologies and semantic spaces
2. Many resources curate semantic mappings, but they are often incomplete

Mappings provided by first party resources are often incomplete
Predicted mappings usually don't get persisted
Need curation tool for predicted mappings
Need to re-incorporate/contribute curations upstream
Ontology Alignment Evaluation Initiative has used the same task of aligning the Foundational Model of Anatomy Ontology
and SNOMED-CT for more than 15 years (see Bodenreider and Zhang (2006) and Wang and Hu (2022)). We could be done with
this and move on!
Need to do this all in an open code / open data / open infrastructure (O3) way

![Biomappings Curation Cycle](https://raw.githubusercontent.com/biopragmatics/biomappings/master/docs/img/biomappings-curation-cycle.svg)

## Running Biomappings

## Predicting Mappings

The Biomappings workflow is generic and allows for any mapping prediction workflow to be used.
In this section, we will predict lexical mappings using [Gilda](https://github.com/gyorilab/gilda).
This approach is fast, simple, and interpretable since it relies on the labels and synonyms for
concepts appearing in ontologies and other controlled vocabularies (e.g., MeSH). It takes
the following steps:

1. Index labels and synonyms from entities in various controlled vocabularies (e.g., MeSH, ChEBI)
2. Filter out concepts that have mappings in primary source or third-party mappings in Biomappings
3. Perform all-by-all comparison of indexes for each controlled vocabulary
4. Filter out mappings that have been previously marked as incorrect (e.g.,
   avoid [zombie mappings](https://doi.org/10.32388/DYZ5J3))

### Clone the Repository

1. Fork the [upstream Biomappings repository](https://github.com/biopragmatics/biomappings)
2. Clone your fork, make a branch, and install it. Note that we're including the `web` and `gilda` extras, so we can run
   the curation interface locally as well as get all the tools we need for generating predictions.

   ```shell
   git clone https://github.com/<your namespace>/biomappings
   cd biomappings
   git checkout -b tutorial
   python -m pip install -e .[web,gilda]
   ```
3. Go into the `scripts/` directory

   ```shell
   cd scripts/
   ```
4. Make a Python file for predictions. In this example, we're going to generate mappings between the ChEBI ontology and
   Medical Subject Headings (MeSH).

   ```shell
   touch generate_chebi_mesh_example.py
   ```

### Preparing the Mapping Script

Biomappings has a lot of first-party support for Gilda prediction workflows, so generating mappings
can be quite easy using a pre-defined workflow. Open your newly created `generate_chebi_mesh_example.py`
in your favorite editor and add the following four lines:

```python
# generate_chebi_mesh_example.py

from biomappings.gilda_utils import append_gilda_predictions
from biomappings.utils import get_script_url

provenance = get_script_url(__file__)
append_gilda_predictions("chebi", "mesh", provenance=provenance)
```

All generated mappings in Biomapping should point to the script that generated
them. `provenance = get_script_url(__file__)` is a sneaky function that uses `__file__` to get the name of the
current file and `get_script_url()` to generate a URI, assuming that this is in the `scripts/` directory of the
Biomapping repository.

The hard work is done by `append_gilda_predictions("chebi", "mesh", provenance=provenance)`. Under the hood, this
does the following:

1. Looks up the names and synonyms for concepts in ChEBI and MeSH using [PyOBO](https://github.com/pyobo/pyobo), a
   unified interface for accessing ontologies and non-ontology controlled vocabularies (such as MeSH)
2. Runs the algorithm described above
3. Appends the predictions on to the local predictions TSV file

### Finishing Up

Execute the script from your command line and the predictions will be added to your local Biomappings cache.

```shell
python generate_chebi_mesh_example.py
```

This is a good time to review the changes and make a commit using

```shell
git add src/biomappings/resources/predictions.tsv
git commit -m "Add predictions from ChEBI to MeSH"
git push
```

Finally, you can run the web curation interface like normal and search for your new predictions to curate!

```shell
biomappings web
```
