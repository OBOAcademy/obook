# A tutorial for using CPONT with synthetic data in Neo4J

This is a self-paced tutorial for exploring the C-Path Knowledge Graph in Neo4J. 

## Neo4j version used

This tutorial was tested with Neo4J Desktop 1.4.15 and a database instance version 4.1.0, APOC 4.1.0.1, neosemantics 4.1.0.1 and Graph Data Science Library 1.3.0.

<a id="preparation"></a>

## Preparation

1. Follow the [Neo4J Set Up instructions](../howto/set-up-neo4j.md). We assume you have created the uri uniqueness constraint and have initialised an empty graph config as per the last part of these instructions (`CALL n10s.graphconfig.init()`). _Additionally, you will have to have the APOC library installed, which is a very important library for basic Graph Operations_.
1. If your database is not empty, you can empty it by
    1. Running `MATCH (n) DETACH DELETE n`
    1. Re-initialise the graph config: `CALL n10s.graphconfig.init()`
1. We assume you have [run the CPONT build pipeline locally on your machine](../cpont-editors.md#kg-synth).

## Tutorial

We assume the database you are working on is empty, with initialised graph config, [see above](#preparation).

Before we start, we will tell Neo4J to not concern itself with qualified names. This ensures that the relationships in particular have nicely readable names like `exactMatch` rather than qualified names like `skos_exactMatch`. Note that we don't recommend this setting in general (as it could lead to multiple different relations like skos:exactMatch or semapv:exactMatch having the same label), but for the sake of this tutorial, it makes everything a bit more readable.

```
CALL n10s.graphconfig.set({ handleVocabUris: "IGNORE" });
```

Next, we will import the raw data.

If you are in a Unix machine (Mac, Linux), importing your data will look something like this.

```
CALL n10s.rdf.import.fetch("file:///Users/matentzn/knocean/critical-path-ontology/src/ontology/tmp/kg.ttl", "Turtle");
```

On Windows, it will look something like this:

```
CALL n10s.rdf.import.fetch("file:///C:/Users/dolson/git/critical-path-ontology/src/ontology/tmp/kg.ttl", "Turtle");
```

Next, we will tag our nodes, so we can visualise them more nicely:

```
MATCH (a:Resource) WHERE EXISTS(a.node_label) WITH a, a.node_label as node_label
CALL apoc.create.addLabels(a, [node_label]) YIELD node
RETURN count(a) as count
```

You can now see additional labels in the `Node labels` section on the left, such as `Disease` and `AnatomicalEntity`. Note that you need the `APOC` library installed to run this query, because there is no built-in way that allows us to dynamically set node labels in Neo4J. This query takes advantage of a preprocessing step in the cpont.Makefile (`tmp/kg.ttl`) which _sets an annotation property to every single class in the graph_ based on whether they are children of one of our ontological base classes. You can try out the new tags by clicking on them, for example `AnatomicalEntity`:


![Neo4J](../images/neo4j_anatomicalentity.png)


### A first query and managing the display

Now, lets take a look at an example node in our graph:

```
MATCH (n:person)-[:person_id]-(c:condition_occurrence)-[:condition_source_concept_id]-(s:Resource)<-[:narrowMatch|:closeMatch|:exactMatch]-(d)-[:subClassOf*]->(disease { uri: "http://purl.obolibrary.org/obo/MONDO_0000001" })
return n,c,s,d LIMIT 1
```

This query will return to us a single person which had a recorded condition that corresponded to a `Disease`. This is exactly what is happening:

Every `()-[]-()` expression conforms to a link, or relation, (`-[]-`) between two nodes (`()`). We always use the `MATCH` keyword to "match" a graph pattern (the `(node)-[relation]-(node)`) to our knowledge graph. For now, think of `MATCH` as analogous to `SELECT` in SQL or SPARQL.

The expression 

```
MATCH (n:person)-[:person_id]-(c:condition_occurrence)
```

- matches a node `n` (n is like a variable name `?n` in SPARQL) with a specific label `person` (remember, a bit earlier in the tutorial we looked for nodes with the label `AnatomicalEntity`)
- to another node `c` with a label `condition_occurrence`
- via a relation `person_id`. Note that the fact this relation is called `person_id` is pretty confusing, unless you are deeply familiar with the OMOP datamodel: `person_id` is a "column" (feature) of the `condition_occurrence` table.

The query then continues:

```
...
(c:condition_occurrence)-[:condition_source_concept_id]-(s:Resource)<-[:narrowMatch|:closeMatch|:exactMatch]-(d)-[:subClassOf*]->(disease { uri: "http://purl.obolibrary.org/obo/MONDO_0000001" })
...
```

To:

- match the `condition_occurrence` `c` to a `Resource` s via the relation `condition_source_concept_id`
- and then looks for a node `d` which is connected to `s` via a skos mapping relation
- `d` furthermore should be a subclass of `http://purl.obolibrary.org/obo/MONDO_0000001` (the "disease or disorder" class in Mondo). Note that the `{ property: value}` notation is how you match node properties, such as a persons name, or their address, rather than a relation.

Note the `*` symbol in the `-[:subClassOf*]->` relation. It means that we want to _traverse_ all `subClassOf` edges, rather then just a single one. This is one of the key advantages graph databases have over SQL. Mimicking the same in SQL would require `recursive joins` over potentially enormous tables. The `->` symbol in the graph pattern denotes the direction of the relation: we only want to look for subclasses of "disease or disorder", not superclasses (i.e. not the reverse).

The last part of the query

```
...
return n,c,s,d LIMIT 1
```

Simply says: return the nodes n, c, s and d (and their interrelations), and only return _a single node_.

We are not going to go into more detail on how Neo4J works as part of this training - the goal is to learn how to navigate CPONT. If you are interested in a more in depth introduction, we refer you to the absolutely great neo4j [GraphAcademy](https://graphacademy.neo4j.com/).

Note that your display may be different from mine. If you want to play with colouring the nodes a bit: 

1. click on one of them
2. click on one of the labels in the Overview panel on the right
3. a colour panel will pop up. This also allows you to change the size of the node and, _most importantly_, select the property which you want to use for _rendering the label_ of the node. 

![Neo4J](../images/neo4j_colours.png)

Let us now look at the result of the query:

![Neo4J](../images/neo4j_firstperson.png)

What we can see here is some person (named `person 30`, as they are generated synthetically) and their connection to a disorder, `depressive disorder`, via a number of relationships (the ones you chose in your query above).

What you see here is more or less what you have in your raw data: a person, a condition occurrence and the related condition. If you want to remind yourself what the condition is, click on the condition (the node linked from from the condition occurrence) and simply click on the `uri` in the `Node properties` on the right-hand panel.

The goal of the remaining tutorial is to find out _what else we know_ when including the semantics provided by CPONT.

### Exploring CPONT

As a first pass of trying to understand what other connections we have in CPONT, let us "unfold" the `depressive disorder` node by clicking on it, and then clicking the graph symbol in the emerging grey circle around the node.

![Neo4J](../images/neo4j_depressive.png)

A ton of connections emerge. Unfortunately for us, the display is extremely chaotic. This is a good time to remember that knowledge graphs are _not_ neat and nice structures like SQL tables, TSV files, or similar "rectangular" or "tabular" representations. They reflect the chaotic relationships of biology, and here, despite what seems like chaos, we only see a fraction of the mess in biology and medicine - as we add more and more sources to enrich our knowledge graph, the mess will only grow. This is why we rely on graph analysis and exploration to harvest insight from the graph structure, and _not the graph itself_.
During exploration ("getting a sense of what is there"), querying is going to be our best weapon, so this is what we will use moving forward.

Let's try to get a more restricted sense of the graph we just looked at.

```
MATCH (n:person)-[:person_id]-(c:condition_occurrence)-[:condition_source_concept_id]-(s:Resource)<-[:narrowMatch|:closeMatch|:exactMatch]-(d)-[:subClassOf*]->(disease { uri: "http://purl.obolibrary.org/obo/MONDO_0000001" })
MATCH (d)-[]-(a:AnatomicalEntity)-[:BFO_0000050]->(a2:AnatomicalEntity)
return n,c,s,d,a,a2 LIMIT 1
```

![Neo4J](../images/neo4j_query2_simple.png)


### Graph similarity

Graphs are an excellent tool to determine the similarity between two conditions, assays or even patients. The basic idea is that if two entities are related to similar sets of entities (diseases, assays, etc), then they must be more similar.

Let us look at a simple example based on the anatomical entities in the knowledge graph first. To compute the semantic similarity of two anatomical entities, we need to:

1. define a _projection_ of the graph we wish to take into account for similarity. A projection is essentially a definition of the part of your graph you wish to use for the similarity computation.
2. compute similarity between all nodes in the projection defined above.

Let us first create a projection:

```
CALL gds.graph.create('anatomy','AnatomicalEntity',
{ 
  subClassOf:{orientation: 'NATURAL'},
  BFO_0000050:{orientation: 'REVERSE'}
}
)
```
_Note: if your version of Graph Data Science Library is 2.0.* or higher, replace `gds.graph.create` with `gds.graph.project` in the above command._

Unpacking this command is out of scope for this tutorial, but if you are interested in understanding it in more detail, you may want to pause and watch the following explainer:

<iframe width="560" height="315" src="https://www.youtube.com/embed/qWZLgBIN1V4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Next, we need to compute the similarities between all nodes:

```
CALL gds.nodeSimilarity.stream('anatomy', {degreeCutoff: 40})
YIELD node1, node2, similarity
RETURN gds.util.asNode(node1).label As Anatomy1, gds.util.asNode(node2).label As Anatomy2, similarity
ORDER BY similarity DESCENDING
```

The higher the degreeCutoff, the better and the more precise the similarity results will be. Again, we will not unpack the command here (it is not necessary to understand the core message of this tutorial), but refer the interested reader to the following explainer:

<iframe width="560" height="315" src="https://www.youtube.com/embed/B1a3b5x1BOU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

![Neo4J](../images/neo4j_similarity1.png)

As you can see, you get a 3 column table in return: the two diseases that are compared, and the similarity between them. For illustration, let us try to unpack one of the examples:

```
MATCH (n:AnatomicalEntity {label: 'renal glomerulus'})-[:subClassOf|:BFO_0000050]->(a)
MATCH (n2:AnatomicalEntity {label: 'glomerular capsule'})-[:subClassOf|:BFO_0000050]->(a)
return n, n2, a
LIMIT 10
```

Note that because of the huge number of connections, we have to put a limit on the display here:

![Neo4J](../images/neo4j_similarity2.png)

The picture is not very easily interpretable - feel free to run the query and play a bit with the graph by dragging and dropping nodes around to get a better sense of it. The main point is that this graph contains the nodes and relationships (or a subset of them) that are _common_ to both `renal glomerulus` and `glomerular capsule`. This kind of analysis can be run between and across all kinds of entities in the graph. A detailed exploration is out of scope here.

