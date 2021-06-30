# Knowledge Graphs and Ontologies

## Knowledge Graphs in the context of Semantic ETL

## Two families

There are two basic families of knowledge graphs that are used extensively in the biomedical domain: RDF-style knowledge graphs and so called "Labelled Property Graphs".

Plugins like [neosemantics](https://neo4j.com/labs/neosemantics/) can bridge the GAP between the two by allowing neo4j users to directly import RDF (and even some limited OWL). It is, however, not uncommon to build your own pipelines that import data into Neo4J. [NCATS Translator](https://ncats.nih.gov/translator), and the [Monarch Initiative](https://monarchinitiative.org/), for example, are collaborating to build a simple table-based representation of Knowledge Graphs called [Knowledge Graph Exchange (KGX)](https://github.com/biolink/kgx)

## The role of ontologies in the context of knowledge graphs

1. Data cleaning: From global identifiers to semantic schema constraint checking
2. Semantic glue: Concepts in ontologies can simply be included into the knowledge graph to connect and enrich your data
3. Data augmentation:
   - Logic-based classification of data
   - Application of inference rules to uncover implicit links in your data


### Data cleaning: From global identifiers to semantic schema constraint checking

All realistic data is messy and faulty. Data cleaning is the one of the, if not the, most important part of the job of the Data Scientist and Data Engineer. [Data cleaning has many aspects to it](), but two are of particular importance when considering the role of ontologies: 
- Harmonising data values to a set of integrated controlled vocabularies and data types. We have discussed this during the past weeks of the course: resolving (mapping) references to genes, phenotypes and diseases to the same ontology or controlled vocabulary identifiers, for example mapping all mentions of `Alzheimer's Disease` in our dataset to `MONDO:0004975`. Another aspect of reconciliation could involve harmonising numeric data values, both in terms of data types and unit conversion. Unit ontologies can help here (see [here](https://www.youtube.com/watch?v=bVw4H6FqOgM) for a promotional video of unit ontologies on youtube).
- Making sure that the data does not violate semantic schema constraints: you want your data to be logically consistent with the semantic constraints you specified as part of the ontology. We will discuss this issue in more detail in the following.


#### Checking semantic schema constraints

A lot has been written about checking schema constraints, for example [SQL constraints](https://www.w3schools.com/sql/sql_constraints.asp). Semantic constraints are not restricted to the kind of semantic representations we have covered as part of this course (RDF, OWL), but this is what we are focusing on in here. Think about a genealogy database. You may want to specify the following semantic constraint: every individual has exactly 1 biological mother. An OWL, you can express this as follows:

```
FunctionalObjectProperty(<http://w3id.org/obook/has_mother>)
SubClassOf(<http://w3id.org/obook/Person> ObjectSomeValuesFrom(<http://w3id.org/obook/has_mother> <http://w3id.org/obook/Person>))
```

Adding these two axioms has two benefits:
1) If we accidentally add a person that is declared to have two mothers, the reasoner will tell us
2) If we query for all people with mothers, we get _everyone_ in the database - not just the ones that have known mothers in our database

There are many kinds of semantic constraints:
- You should not be a Person and a Country at the same time: `DisjointClasses(<http://w3id.org/obook/Country> <http://w3id.org/obook/Person>)`
- The place you are born in must be a country: `ObjectPropertyRange(<http://w3id.org/obook/born_in> <http://w3id.org/obook/Country>)`
- If you love someone, they will love you back: `SymmetricObjectProperty(<http://w3id.org/obook/loves>)`
- If you have a mother, you must be a person: `ObjectPropertyDomain(<http://w3id.org/obook/has_mother> <http://w3id.org/obook/Person>)`

OWL is great in certain kinds of semantic constraints, especially when we are talking about class expressions. [Uberon](https://github.com/obophenotype/uberon) for example has dozens of semantic constraints, including taxon constrains (this anatomical entity is only observed in _mus musculus_), or "the nose, when part of Tetrapoda taxon, is part of the respiratory system" (`nose and ('part of' some Tetrapoda) SubClassOf 'part of' some 'respiratory system'`). See also screenshot below. 

![Uberon constraints](./img/uberon_constraints.png)

Note that there are three phases of the Semantic ETL process where semantic schema constraint checking plays a big role:
- During data ingest: You want to make sure that if you ingest a source, it does not contain contradicting data. Do not assume that the source data is already cleaned to perfection!
- During data integration: When combining multiple external and internal sources, you want to ensure that that they are mutually consistent. For example, one source may claim that a disease has the basis for its dysfunction solely in one gene, while another source claims that it has the basis for its dysfunction in another. If you need your graph to be a source of truth, it is a good idea to review such cases - and then perhaps decide that the contradiction is acceptable.
- During predictive data analysis: You may have used Machine Learning models to infer new relationships in your ontology, 


- Enterprise Knowledge Graphs
- Shape Validation
- Graph Embeddings
- The advent of neurosymbolic architectures

Reconciliation, fusion, alignment

- Some RDF databases can efficiently enforce the semantics of the ontology through reasoning and consistency checking
