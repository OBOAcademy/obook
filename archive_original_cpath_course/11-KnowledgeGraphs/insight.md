# Using Knowledge Graphs to generate insight

In general, we consider "generating insight" to be the process of uncovering non-obvious links between the entities of your knowledge graph: identifying a previously unknown drug target for a disease; finding possible genetic underpinnings of a phenotype.

There are (at least) four levels of inference that we care about in our domain, possibly more:

1. Deductive reasoning: Applying the semantics "rules" in the ontology to make implicit knowledge explicit using a reasoner.
2. Semantic similarity: Using the graph structure to determine similar nodes. For our domain this comes in two major flavours:
   1. Term-based similarity. For example, we can say that two phenotypes are similar if
      - they are associated with similar biological processes and anatomical entities, or
      - they share the same or similar parents in the ontology (they could both be, say, lung diseases)
   2. Profile-based similarity. For example this set of phenotypes is somehow similar to this other set of phenotypes.
3. Link prediction using Machine Learning: There are many architectures, such as:
   1. _Graph/word embeddings + ML_: Translating the graph structure (and potentially the terminological content) into a vector representation that can be used by regular Machine Learning algorithms such as Random Forests and SVMs.
   2. _Graph Neural Networks_: Training a Neural Network from the graph structure that can predict relationships.

## Deductive reasoning

Given the semantics rules, or axioms, in the ontology, we can deduce certain things about our data. For example,
you can sat that if you love someone, they will love you back: `SymmetricObjectProperty(<http://w3id.org/obook/loves>)`. So a reasoner could simply look for triples of the form `:a <http://w3id.org/obook/loves> :b` and add the, albeit optimistic, assertion to the knowledge graph that `:b <http://w3id.org/obook/loves> :a`. There are many more such rules that can be applied, such as the inverse rule: `InverseProperty(<http://w3id.org/obook/part_of>, <http://w3id.org/obook/has_part>)`, so if you know from your data that `:a <http://w3id.org/obook/part_of> :b`, then you can add the assertion `:b <http://w3id.org/obook/has_part> :a`. The main downside with deductive reasoning is that they are generally not always scalable - but many open and commercial tools are now emerging (like RDFox) that are set to change the game a bit here.

## Semantic similarity

There are many approaches that be be used to determine "similar" nodes in a graph based on the structure of the graph alone. For example, you can compare two phenotypes with each other by simply determining the overlap of the associated gene sets, using an algorithm such as the Jaccard algorithm. Another, more OWL-ly way of determining semantic similarity is to look at the set of common subsumers (superclasses) and compare these, again with Jaccard. Or we can use another measure of semantic similarity, called information content, which is a measure of probability for a specific concept (such as a disease) to appear in a knowledge graph. The [Wikipedia](https://en.wikipedia.org/wiki/Semantic_similarity) article gives a good list of measures to start from.

One very interesting application of semantic similarity is "profile matching", for example "phenotypic profile matching". Rather than comparing a single two phenotypes with each other using a term-based measure such as the ones described above, we compare sets of phenotypes, a so called phenotypic profiles, to other sets of phenotypes. "Phenotypic profiles" are a convenient way to describe the sum-total of a persons phenotypic presentation. Matching phenotypic profiles, which often makes use of term-based similarity measures, is a great way to identify, for example, patients that have similar phenotypic profiles, even if no single phenotype is exactly the same (awesome!), or identifying candidate diseases with known phenotypic profiles for a patient and their phenotypic profile. The Monarch Initiative makes extensive use of [phenotypic profile matching](https://monarchinitiative.org/analyze/phenotypes).

## Link prediction using Machine Learning

Machine Learning (ML) based approaches, in contrast to the _deductive_ reasoning approaches described above, are considered "inductive", which means that rather than deducing knowledge logically from existing knowledge, they _learn_ new knowledge from the examples provided in the data. So for example, if your knowledge graph contains many examples of patients with "Alzheimer's disease" that exhibit cardiovascular phenotypes, it may learn from that that other patients with that same disease may also exhibit cardiovascular phenotypes. Or the other way around, patients that exhibit a bunch of cardiovascular phenotypes may be associated with "Alzheimer's disease". Furthermore, the "embeddings", vector-representations of our knowledge graphs are all by themselves super useful because they have a built-in notion of similarity (essentially closeness in vector-space, such as cosine similarity).

This area is _hot_. There is a ton of work going on in this area, and while beyond the limits of this course, totally worth checking out. The OBO Semantic Engineer should be aware of the following frameworks and resources in the knowledge graph space (just selection, there are many more):

- [Ampligraph](https://github.com/Accenture/AmpliGraph): Open source library based on TensorFlow that predicts links between concepts in a knowledge graph.
- [PyKEEN](https://github.com/pykeen/pykeen): PyKEEN (Python KnowlEdge EmbeddiNgs) is a Python package designed to train and evaluate knowledge graph embedding models
- [Knowledge Graph Embeddings Tutorial: From Theory to Practice](https://www.youtube.com/watch?v=gX_KHaU8ChI): A nice tutorial explaining Knowledge Graph Embeddings in depth. Generally search Youtube, there are many nice tutorials nowadays we have not even looked at.
- [A Survey on Knowledge Graphs: Representation, Acquisition and Applications](https://arxiv.org/abs/2002.00388): Good Survey Paper to start your journey!

## Discussion

Given the huge momentum of Machine Learning and Knowledge Graphs at the moment, one may wonder whether the time of deductive reasoning and semantic similarity has come. Deductive reasoning does not scale very well to large knowledge graphs, and deductive reasoning usually does not all by itself yield any ground-breaking insights. Semantic Similarity seem to be just a bit weaker than say embedding similarity, because of the way you have to manually construct the sets you want to compare. However, there is one huge plus these approaches have over inductive ML-based approaches: They are explainable. Explainability means, that given a prediction (such as a new relationship between a patient and a disease), you can fully or almost fully recover _how this prediction was made_. ML-based approaches are mostly considered black-box, so you will only ever be able to approximate the explanation - which may not be good enough in life and death scenarios such as healthcare.
