# Practical example

The Children's hospital of Philadelphia (CHOP) uses the [Experimental Factor Ontology (EFO)](https://www.ebi.ac.uk/efo/) to integrate data across a variety of sources and now seeks to integrate data annotated with [Mondo](https://mondo.monarchinitiative.org/) and the [National Cancer Institute Thesaurus (NCIt)](https://ncithesaurus.nci.nih.gov/ncitbrowser/). To achieve this, the EFO team decides to clean up the **Neoplasm** branch of EFO in such a way that the classification is aligned with Mondo (their preferred terminology for classifying neoplasms), which by itself is well aligned with the [neoplasm branch of NCIt](https://www.ebi.ac.uk/ols/ontologies/ncit/terms?iri=http%3A%2F%2Fpurl.obolibrary.org%2Fobo%2FNCIT_C3262). The EFO team hires you as a Semantic Engineering consultant to align the neoplasm terms of EFO and Mondo. Concretely, they want you to determine, for every term in the EFO neoplasm branch, the **corresponding equivalent term** in Mondo. After some scheming, you decide you will tackle this problem in a series of 4 steps:

1. Identifying trustworthy mappings between EFO and Mondo that you can re-use
1. Merge the all trustworthy mappings you could find into a single file
1. Apply various automated mapping techniques to map the rest
1. Review the automated mappings
1. Request terms where there are verifiably not suitable mappings and you believe their should be
1. Prepare the final reference mapping

## Identifying trustworthy sources of mappings

Despite all progress in terms of FAIR and Open Data, it is pretty hard to find up-to-date, complete and trustworthy mappings - let alone in a standardised format. Despite efforts such as the [Simple Standard for Sharing Ontology Mappings (SSSOM)](https://github.com/mapping-commons/SSSOM/blob/master/SSSOM.md) standard.

After some search, you find two mappings which appear ok to you: The official [EFO-Mondo mappings](https://github.com/EBISPOT/efo/blob/master/src/ontology/components/mondo_efo_mappings.tsv) as curated by the EFO team, and some more experimental looking [Mondo-EFO mappings](https://github.com/monarch-initiative/mondo/tree/sssom-rewrite/src/ontology/mappings) as curated by the Mondo team. Both seem ok, and you have contacted the editors of Mondo and EFO respectively to enquire about their trustworthiness. Both teams seem to be confident in their mappings.

## Merge the available mappings into a single set

You will then continue on to download and integrate the mappings in the usual way by

1. Writing a Makefile
2. Defining goals for downloading your mapping sets
3. Write a script that merges the existing mappings into a single reference mapping
4. Determine the entities in EFO that are unmapped

Please refer to the practical project associated with this lesson for an example.

## Apply various automated mapping techniques to determine the rest of the mappings

Now that you have a reference mapping and you know which terms are currently unmapped, you need to think about how to deal with the rest.

In our example scenario, it turned out that only three EFO terms did not have a corresponding mapping into Mondo:

```
tumoral calcinosis, hyperphosphatemic, familial, 2
tumoral calcinosis, hyperphosphatemic, familial, 3
Waldenstrom macroglobulinemia
```

The most obvious path to perform the mapping - and the least error prone - is to go and manually add the respective mappings. In our case, this is easy enough, and _very often this is the best course of action_. In our experience, the reliance on automated tools in semantic engineering pipelines is usually exaggerated - especially when it comes to mappings. You could find the corresponding Mondo ids simply by searching [Mondo on OLS](https://www.ebi.ac.uk/ols/ontologies/mondo).

However, for the sake of this course, we will suggest a few ways to automatically map the EFO entities to their Mondo counterparts.

1. Performing some light-weight string matching. A nice overview can be found [here](https://www.datacamp.com/community/tutorials/fuzzy-string-python).
1. Use a Web Service to suggest appropriate matches. One specialsied system for this purpose is [Zooma](https://www.ebi.ac.uk/spot/zooma/). Go ahead and add the three missing terms into the search box and see what comes up.
1. Using a full fledged Ontology Matcher such as [Agreement Maker Light](https://github.com/AgreementMakerLight/AML-Project) (for a full list see [here](mappings.md)).

For the sake of this tutorial we will use the Zooma Web Service to obtain the mappings. An alternative would be to try to use a string similarity metrics such as the `Levenshtein` distance between labels in EFO and labels in Mondo - and then perform a manual review of the resulting high similarity results. In this tutorial, for example, the Levenshtein distance (or rather, similarity) between "Apple Inc." and "apple Inc" is roughly `0.95` or 95%.

# Review the automated mappings

For high stake mappings, i.e. mappings that are used in clinical diagnostics, it is always advisable to perform a manual review. It makes sense to perceive "automated mappings" such as the ones above always as "suggested mappings" with some level of confidence - only a human expert should be able to "promote" a suggested mapping to a proper mapping.

In our case, we are actually happy with the suggested mappings, so we can go ahead and finalise the our EFO-Mondo cancer mapping.

# Request terms where missing

In many cases, you will find that there is no suitable mapping in the ontology you try to map to. In many cases there should be! It is a crucial part of open science to contribute terms to the ontologies where they are missing, and we have prepared an entire set of exercises to that effect (see [here](README.md)).

# Prepare the final reference mapping

Thinking about how to deliver your mapping is a crucial part of your role as Semantic Engineer - one that is usually very neglected. We consider at least two things:

1. The ontologies change, and the mapping needs to change with them. Therefore we deliver the `Makefile` we built along with our `finalised mapping` so that our clients, whether they are external or internal, can always refresh their mappings in light of changes!
2. Mappings should be FAIR - that is they should provide sufficient metadata to enable their users to decide how to use them. We recommend wrapping your mapping in a format such as the [Simple Standard for Sharing Ontology Mappings (SSSOM)](https://github.com/mapping-commons/SSSOM/blob/master/SSSOM.md) and add metadata such as:
   - The version of your mapping table!
   - The version of the ontologies you have imported
   - Add yourself as the creator, so people know this for future reference.
   - Indicate that the mappings have been `HumanCurated` and you deem them trustworthy.
   - Say that your mappings are semantically air-tight equivalence mappings which increases there re-usability a lot.
   - You should add a description as well - it helps!
   - See [here for an example](https://github.com/monarch-initiative/mondo/blob/sssom-rewrite/src/ontology/mappings/mondo_exactmatch_doid.sssom.tsv).
