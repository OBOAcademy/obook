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
        runoak -i wikidata: descendants wikidata:Q8492 -p i,p -o juice_wiki.ttl -O rdf
        robot convert -i juice_wiki.ttl  -o juice_wiki.owl
    ```
    - The last step is merging the two subsets using `ROBOT`
    ```
        robot merge -i fruit_juice_food_foodon.owl -i juice_wiki.owl -o foodon_wiki.owl
    ```
3. #### Generate the matches
   - We first run `oak`'s `lexmatch` command to generate lexical matches between the contents of the merged file.
    ```
        runoak -i sqlite:foodon_wiki.owl lexmatch -o foodon_wiki_lexmatch.tsv
    ```
    This will generate an SSSOM tsv file with the mapped contents.

    - Next we map them with a set of rules `matcher_rules.yaml`
    ```
        runoak -i sqlite:foodon_wiki.owl lexmatch -R matcher_rules.yaml -o foodon_wiki_lexmatch_with_rules.tsv 
    ```
    This will also generate an SSSOM tsv file with the mapped contents but you'll notice a few more matches than the previous output.

4. #### Curate the matches

    If you look carefully through the matched files, you'll notice that manual intervention is definitely required for the matches to be accurate. For e.g. `orange juice [wikidata:Q219059]` and `orange juice (unpasteurized) [FOODON:00001277]` may not be considered as `skos:exactMatch`. 


