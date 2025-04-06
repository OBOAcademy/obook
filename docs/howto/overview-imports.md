# How to import terms from another ontology - an overview

## Contributors

- Tim Alamenciak (@timalamenciak)
- Philip Strömert (@StroemPhi)

## Summary:

This is a guide on how to **import terms** from one ontology to another. The OBO Foundry emphasizes reuse between ontologies, yet reusing terms is a very complex process with a lot of caveats and technical nuance.

This how-to is an addition to some of the more technical tutorials, which can be considered post-requisites:
- [Update Imports Workflow](https://oboacademy.github.io/obook/howto/update-import/?h=import)
- [Managing Dynamic Imports with the Ontology Development Kit](https://oboacademy.github.io/obook/howto/update-import/?h=import)
- [Dealing with huge ontologies in your import chain](https://oboacademy.github.io/obook/howto/deal-with-large-ontologies/?h=import)
- ODK documentation - [Manage your ODK Repository](https://obofoundry.org/COB/odk-workflows/RepoManagement/)

## To import or create?

Here's the scene: You need a new term in your ontology, and a similar term exists in another OBO Foundry ontology. In theory, since BFO is at the root of all OBO Foundry ontologies, they are interopable. In practice, there are more things to consider.

Ontologies are intraconnected beasts. Fully axiomatized ontologies contain lots of orthogonal (i.e. across branches) connections. This means that if you import a term with an axiom that relies on a term in another tree, there may be a need to import the entire other tree, which would be dozens of terms, then the axioms for those terms, which would also be dozens of terms.

It gets out of hand quickly.

There is a major caveat for all of this: Your decision on import process depends on whether you are working on a domain ontology or a [project ontology](../tutorial/project-ontology-development/). If you are working on a domain ontology, there is a strict requirement to maintain logical validity. The domain ontology itself may have already developed import workflows that suit it. If you are working on a project ontology, you have more freedom to decide how you import terms.

There are a few questions you can ask yourself to help make this decision:
1. Is the definition and place in the hierarchy suitable for your ontology?
2. Do all of the axioms reflect the meaning of the term as you intend it?

![A flowchart describing how to decide in which manner a term should be imported](ImportFlow.png)

## SLME - aka Full firehose import

Our example: You are making an ontology that has measurements and so you need to import some kind of a tree under which to classify those measurement types. The [measurement datum](http://purl.obolibrary.org/obo/IAO_0000109) (IAO:0000109) class is a good one. You can assign subclasses to an imported class, but you can't change the axioms and description. That should be fine in this case.

You would use an approach called Syntactic Locality Module Extractor (SLME) which takes a term as a "seed" and extracts all the things related to it. This means it will pull all axioms and superclasses attached to the term. 

You have a choice between using [ROBOT](https://robot.obolibrary.org/) directly or through ODK to do this. ROBOT is a commandline tool whereas ODK is a set of automated methods to manage ontologies. 

There is documentation on how to use [ROBOT merge](https://robot.obolibrary.org/extract) to import terms if you are manually constructing your ontology. Note that some users have reported ROBOT will zealously extract terms unrelated to the seed - you may use `filter` and `remove` to prune the resulting tree.

You can also add the term to your ontology's import process using ODK - see [Manage your ODK Repository for more technical details](https://obofoundry.org/COB/odk-workflows/RepoManagement/).

## MIREOT - aka Partial import

Our example: You are working on an environmental ontology for which you need a class `forest`. The well-developed environment ontology (ENVO) has such a class - [forest](http://purl.obolibrary.org/obo/ENVO_01001243) (ENVO:01001243). You do not need its axioms (e.g. that it is *part of* forest canopy or *has participant* forest fire) and the superclass structure is compatible with your ontology.

In this case you would use an approach called Minimum Information for Referencing External OnTologies ([MIREOT](https://journals.sagepub.com/doi/abs/10.3233/AO-2011-0087)). Again, you have a choice between ROBOT and ODK.

There is documentation on the [ROBOT extract page](https://robot.obolibrary.org/extract) for using that tool. You can find documentation on the [ODK site](https://obofoundry.org/COB/odk-workflows/RepoManagement/) for how to import terms in this way - see **Customise an import**.

### Corner case: Adding axioms

There may be a case when you have imported a term using SLME or MIREOT where you find a need to add an axiom. If that happens, the best practice is to try to make an issue or PR with the originating ontology to get the axiom added. 

If more urgent action is required, or there are difficulties with that process, a less preferrable but viable alternative is to add an annotation property **on the new axiom** that clearly states the axiom has been added in your ontology and is not in the original ontology.

## SSSOM - aka Referential import

Our example: a term has been proposed for inclusion in ENVO with the label `mowing process`. It is proposed as a subclass of `mechanical ecosystem management process` which is a subclass of `active ecosystem management process`. It's clear from this hierarchy that mowing is an act of managing some ecosystem.

There exists a term for mowing in AGRO — [mowing process](http://purl.obolibrary.org/obo/AGRO_00000220) (AGRO:00000220).

In this case, the meanings of the term are substantially different. In AGRO, mowing is classified as pest management, but in ecosystem management it can be used to reset the successional state of an ecosystem, which is decidedly not pest management. But there are connections - people are effectively doing the same thing: cutting plants off at the ground.

Here, the proper approach is to mint your own term and use [Simple Standard for Sharing Ontological Mappings](https://mapping-commons.github.io/sssom/) (SSSOM) to link it with AGRO. A SSSOM file accompanies your ontology and provides matchings with other ontologies. There are five basic levels of precision: `exact`, `close`, `broad`, `narrow` or `related`. Details can be found on the SSSOM doc page [How to use mapping predicates](https://mapping-commons.github.io/sssom/mapping-predicates/).

The level of precision comes down to use-case and how much "noise" is acceptable. What is noise? Consider if we had two knowledge graph nodes - `mowing process (AGRO)` and `mowing process(ENVO)`. Let's pretend that we ask the computer to merge everything that is related with `skos:exactMatch` and now we have one node called `mowing process`, but we do not know if that is a conservation-focused mowing process or pest control-focused. That lack of clarity is "noise." 

If we wanted those terms to remain separate, we could label them as `skos:closeMatch` which may not allow them to be merged.

This is just meant to be an introduction - there is a much more fulsome treatment in the [SSSOM documentation](https://mapping-commons.github.io/sssom/mapping-predicates/).