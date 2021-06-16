# Practical example

_Note_: the content of this section is currently [private](https://github.com/cpathtutorial/mapping_course) due to some questions we need to iron out around the source data.

The practical example covers the following questions:

1. How to load your data into a Jupyter notebook and provide some basic links to ontology terms
2. Use these ontology terms for some basic ontology-powered analysis
3. Link up external data to provide additional links


# Additional Task:

1. Add [Mondo-OMIM mappings](https://raw.githubusercontent.com/monarch-initiative/mondo/sssom-rewrite/src/ontology/mappings/mondo_exactmatch_omim.sssom.tsv) to Makefile and an run the respective `make` command to obtain the data.
2. Load Mondo-OMIM mappings into notebook - consider leading comments and show them, mention SSSOM
3. Load HPOA mappings into notebook - consider table headers
4. Merge HPOA with Mondo/OMIM mappings
5. Subset the HPOA dataframe to only contain records relevant to us