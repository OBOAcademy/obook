# Named Entity Standardization

<a href="https://oboacademy.github.io/obook/reference/obook-maturity-indicator/"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2FOBOAcademy%2Fobook%2Fmaster%2Fdocs%2Fresources%2Fobook-badge-development.json" /></a>

Named entity standardization (NES) is the process of identifying the preferred ontology (or database) term
for a concept from many equivalent concepts. This process typically relies on the existence of high quality
semantic mappings such as equivalence relationships and some usage of inference tools.

The algorithm for NES is:

1. Generate equivalence classes, e.g. using semantic mappings from ontologies, databases,
   and [Biomappings](https://github.com/biopragmatics/biomappings)
2. Apply inference and reasoning, e.g., such as chaining rules
3. Apply priority rules (often, a ranked list in terms of prefixes) to identify the preferred term for each equivalent
   class
4. Generate a surjective mapping (i.e., means many keys can point to the same value) that can be used to map any given
   entity to its preferred entity
5. Apply this mapping to data, such as the results from [named entity recognition (NER)](named-entity-recognition.md)
   and [named entity normalization (NEN)](named-entity-normalization.md).

## NES Tools

- [Semantic Mapping Reasoning Assembler (SeMRA)](https://github.com/biopragmatics/semra)
- [Node Normalizer](https://github.com/TranslatorSRI/NodeNormalization)
