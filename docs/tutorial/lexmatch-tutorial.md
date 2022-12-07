# Practical introduction to OAK Lexmatch

In this tutorial, we will learn to use a very basic lexical matching tool (OAK Lexmatch). The goal is not only to enable the learner to design their own matching pipelines, but also to to think about how they fit into their mapping efforts.

## Pre-requisites

- [Introduction to mapping curation with SSSOM](../explanation/semantic-matching.md)
- [ROBOT tutorial (extract)](../tutorial/robot-tutorial-1/#extract)
- [ROBOT tutorial (merge)](../tutorial/robot-tutorial-2/#merge)


## Tutorial

- [Setting up OAK, preparing the ontology](#prepare): You will learn how to install OAK into a new Python environment, and create a simple `Makefile` to prepare your input ontology with ROBOT.
- [Introduction to lexical matching with OAK lexmatch](#run):  You will run lexmatch on the input and learn to interpret the results.

<a id="prepare"></a>

### Setting up OAK, preparing the ontology
 - Setting up `oak` is described in its [documentation](https://incatools.github.io/ontology-access-kit/intro/tutorial01.html).

```
    pip install oaklib
```
 - If you're using ODK docker image, `oaklib` should already be installed.

<a id="run"></a>

### Introduction to lexical matching with OAK lexmatch

Method:

1. #### Download `FOODON` ontology.
    ```
        wget http://purl.obolibrary.org/obo/foodon.owl
    ```
2. #### Extract ontology subsets and merge.
   - In this step, we extract everything between `fruit juice food product` as the `upper-term` and fruit juices (`apple juice`, `orange juice` and `grapefruit juice`) as the `lower-term` of the `FOODON` subset.
    ```
        robot extract --method MIREOT --input foodon.owl --upper-term "FOODON:00001140" --lower-term "FOODON:00001277" --lower-term "FOODON:00001059" --lower-term "FOODON:03306174 " --output fruit_juice_food_foodon.owl
    ```
    - In this step, we get descendants of `juice` from `wikidata` using `oak`, store it in a `ttl` file and using `ROBOT` convert it into an `owl` file.
    ```
        runoak -i wikidata: descendants wikidata:Q8492 -p i,p -o juice_wd.ttl -O rdf
        robot convert -i juice_wd.ttl  -o juice_wd.owl
    ```
    - The last step is merging the two subsets using `ROBOT`
    ```
        robot merge -i fruit_juice_food_foodon.owl -i juice_wd.owl -o foodon_wd.owl
    ```
3. #### Generate the matches
   - We first run `oak`'s `lexmatch` command to generate lexical matches between the contents of the merged file.
    ```
        runoak -i sqlite:foodon_wd.owl lexmatch -o foodon_wd_lexmatch.tsv
    ```
    This will generate an SSSOM tsv file with the mapped contents as shown below:
```
# curie_map:
#   FOODON: http://purl.obolibrary.org/obo/FOODON_
#   owl: http://www.w3.org/2002/07/owl#
#   rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
#   rdfs: http://www.w3.org/2000/01/rdf-schema#
#   semapv: https://w3id.org/semapv/
#   skos: http://www.w3.org/2004/02/skos/core#
#   sssom: https://w3id.org/sssom/
#   wikidata: http://www.wikidata.org/entity/
# license: https://w3id.org/sssom/license/unspecified
# mapping_set_id: https://w3id.org/sssom/mappings/091390a2-6f64-436d-b2d1-309045ff150c
```
| subject_id         | subject_label    | predicate_id    | object_id          | object_label     | mapping_justification  | mapping_tool | confidence | subject_match_field | object_match_field | match_string     |
|--------------------|------------------|-----------------|--------------------|------------------|------------------------|--------------|------------|---------------------|--------------------|------------------|
| FOODON:00001059    | apple juice      | skos:closeMatch | wikidata:Q618355   | apple juice      | semapv:LexicalMatching | oaklib       | 0.5        | rdfs:label          | rdfs:label         | apple juice      |
| FOODON:00001059    | apple juice      | skos:closeMatch | wikidata:Q618355   | apple juice      | semapv:LexicalMatching | oaklib       | 0.5        | oio:hasExactSynonym | rdfs:label         | apple juice      |
| FOODON:03301103    | orange juice     | skos:closeMatch | wikidata:Q219059   | orange juice     | semapv:LexicalMatching | oaklib       | 0.5        | rdfs:label          | rdfs:label         | orange juice     |
| FOODON:03306174    | grapefruit juice | skos:closeMatch | wikidata:Q1138468  | grapefruit juice | semapv:LexicalMatching | oaklib       | 0.5        | rdfs:label          | rdfs:label         | grapefruit juice |
| wikidata:Q15823640 | cherry juice     | skos:closeMatch | wikidata:Q62030277 | cherry juice     | semapv:LexicalMatching | oaklib       | 0.5        | rdfs:label          | rdfs:label         | cherry juice     |
| wikidata:Q18201657 | must             | skos:closeMatch | wikidata:Q278818   | must             | semapv:LexicalMatching | oaklib       | 0.5        | rdfs:label          | rdfs:label         | must             |

  - Next we map them with a set of rules `matcher_rules.yaml`
  ```
      runoak -i sqlite:foodon_wd.owl lexmatch -R matcher_rules.yaml -o foodon_wd_lexmatch_with_rules.tsv 
  ```
  This will also generate an SSSOM tsv file with the mapped contents but you'll notice a few more matches than the previous output as seen below:
```
# curie_map:
#   FOODON: http://purl.obolibrary.org/obo/FOODON_
#   IAO: http://purl.obolibrary.org/obo/IAO_
#   owl: http://www.w3.org/2002/07/owl#
#   rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
#   rdfs: http://www.w3.org/2000/01/rdf-schema#
#   semapv: https://w3id.org/semapv/
#   skos: http://www.w3.org/2004/02/skos/core#
#   sssom: https://w3id.org/sssom/
#   wikidata: http://www.wikidata.org/entity/
# license: https://w3id.org/sssom/license/unspecified
# mapping_set_id: https://w3id.org/sssom/mappings/6b9c727f-9fdc-4a78-bbda-a107b403e3a9
```
| subject_id         | subject_label                | predicate_id    | object_id          | object_label                 | mapping_justification  | mapping_tool | confidence         | subject_match_field | object_match_field | match_string         | subject_preprocessing               | object_preprocessing                |
|--------------------|------------------------------|-----------------|--------------------|------------------------------|------------------------|--------------|--------------------|---------------------|--------------------|----------------------|-------------------------------------|-------------------------------------|
| FOODON:00001001    | orange juice (liquid)        | skos:exactMatch | FOODON:00001277    | orange juice (unpasteurized) | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         | semapv:RegularExpressionReplacement | semapv:RegularExpressionReplacement |
| FOODON:00001001    | orange juice (liquid)        | skos:exactMatch | FOODON:03301103    | orange juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         | semapv:RegularExpressionReplacement |                                     |
| FOODON:00001001    | orange juice (liquid)        | skos:exactMatch | wikidata:Q219059   | orange juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         | semapv:RegularExpressionReplacement |                                     |
| FOODON:00001059    | apple juice                  | skos:exactMatch | wikidata:Q618355   | apple juice                  | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | apple juice          |                                     |                                     |
| FOODON:00001059    | apple juice                  | skos:exactMatch | wikidata:Q618355   | apple juice                  | semapv:LexicalMatching | oaklib       | 0.8                | oio:hasExactSynonym | rdfs:label         | apple juice          |                                     |                                     |
| FOODON:00001277    | orange juice (unpasteurized) | skos:exactMatch | FOODON:03301103    | orange juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         | semapv:RegularExpressionReplacement |                                     |
| FOODON:00001277    | orange juice (unpasteurized) | skos:exactMatch | wikidata:Q219059   | orange juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         | semapv:RegularExpressionReplacement |                                     |
| FOODON:00002403    | food material                | skos:exactMatch | FOODON:03430109    | food (liquid, low viscosity) | semapv:LexicalMatching | oaklib       | 0.8                | oio:hasExactSynonym | rdfs:label         | food                 | semapv:RegularExpressionReplacement |                                     |
| FOODON:00002403    | food material                | skos:exactMatch | FOODON:03430130    | food (liquid)                | semapv:LexicalMatching | oaklib       | 0.8                | oio:hasExactSynonym | rdfs:label         | food                 | semapv:RegularExpressionReplacement |                                     |
| FOODON:03301103    | orange juice                 | skos:exactMatch | wikidata:Q219059   | orange juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | orange juice         |                                     |                                     |
| FOODON:03306174    | grapefruit juice             | skos:exactMatch | wikidata:Q1138468  | grapefruit juice             | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | grapefruit juice     |                                     |                                     |
| FOODON:03430109    | food (liquid, low viscosity) | skos:exactMatch | FOODON:03430130    | food (liquid)                | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | food                 | semapv:RegularExpressionReplacement | semapv:RegularExpressionReplacement |
| IAO:0000601        | has associated axiom(nl)     | skos:exactMatch | IAO:0000602        | has associated axiom(fol)    | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | has associated axiom | semapv:RegularExpressionReplacement | semapv:RegularExpressionReplacement |
| wikidata:Q15823640 | cherry juice                 | skos:exactMatch | wikidata:Q62030277 | cherry juice                 | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | cherry juice         |                                     |                                     |
| wikidata:Q18201657 | must                         | skos:exactMatch | wikidata:Q278818   | must                         | semapv:LexicalMatching | oaklib       | 0.8497788951776651 | rdfs:label          | rdfs:label         | must                 |                                     |                                     |
4. #### Curate the matches

    If you look carefully through the matched files, you'll notice that manual intervention is definitely required for the matches to be accurate. For e.g. `orange juice [wikidata:Q219059]` and `orange juice (unpasteurized) [FOODON:00001277]` may not be considered as `skos:exactMatch`. 


