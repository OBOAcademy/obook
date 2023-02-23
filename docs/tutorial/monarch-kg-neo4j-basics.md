# Neo4j tutorial

## Running locally (your very own Monarch Graph)

The new Monarch Knowledge Graph has a more streamlined focus on the core Monarch data model, centering on Diseases, Phenotypes and Genes and the associations between them. This has the benefit of being a graph that can be build in 2 hours instead of 2 days, and that you can run locally on your laptop.

> Note: As of the writing of this tutorial, (Feb 2023), the graph is just starting to move from its initial construction phrase into real use, and so there are still bugs to find. Some of which show up in this tutorial. 

### Check out the repository

https://github.com/monarch-initiative/monarch-neo4j

### Download Data

* Download [monarch.neo4j.dump](https://data.monarchinitiative.org/monarch-kg-dev/latest/monarch-kg.neo4j.dump) from [data.monarchinitiative.org](https://data.monarchinitiative.org/monarch-kg-dev/latest/index.html) and put in the `dumps` directory

### Set up the environment file

copy dot_env_template to .env and edit the values to look like:

```
# This Environment Variable file is referenced by the docker-compose.yaml build

# Set this variable to '1' to trigger an initial loading of a Neo4j dump
DO_LOAD=1

# Name of Neo4j dump file to load, assumed to be accessed from within
# the 'dumps' internal Volume path within the Docker container
NEO4J_DUMP_FILENAME=monarch-kg.neo4j.dump
```

That should mean uncommenting DO_LOAD and NEO4j_DUMP_FILENAME

### Optional Plugin Setup

<details><summary>You may wish to install additional plugins</summary>
<p>

#### Download plugins 

* Download the [APOC plugin jar file](https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.4.0.13/apoc-4.4.0.13-all.jar) and put in the `plugins` directory

* Download, the [GDS plugin](https://graphdatascience.ninja/neo4j-graph-data-science-2.3.0.zip), unzip the download and copy jar file to the `plugins` directory

#### Environment setup

In addition to the changes above to .env, you will need to uncomment the following lines in the .env file:

```

NEO4J_apoc_export_file_enabled=true
NEO4J_apoc_import_file_enabled=true
NEO4J_apoc_import_file_use__neo4j__config=true
NEO4JLABS_PLUGINS=\[\"apoc\", \"graph-data-science\"\]

```

</p>
</details>

## Tutorials

### Monarch OBO training Tutorials

#### Querying the Monarch KG using Neo4J

<iframe width="560" height="315" src="https://www.youtube.com/embed/_Sx-1WaV4zY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Start Neo4j

On the command line, from the root of the monarch-neo4j repository you can launch the neo4j with:

```
docker-compose up
```

## Querying

### Return details for a single disease

Nodes in a cypher query are expressed with `()` and the basic form of a query is `MATCH (n) RETURN n`. To limit the results to just our disease of interest, we can restrict by a property, in this case the `id` property.

```cypher
MATCH (d {id: 'MONDO:0007038'}) RETURN d
```

This returns a single bubble, but by exploring the controls just to the left of the returned query, you can see a json or table representation of the returned node.

```json
{
  "identity": 480388,
  "labels": [
    "biolink:Disease",
    "biolink:NamedThing"
  ],
  "properties": {
    "name": "Achoo syndrome",
    "provided_by": [
      "phenio_nodes"
    ],
    "id": "MONDO:0007038",
    "category": [
      "biolink:Disease"
    ]
  },
  "elementId": "480388"
}
```

### Connections out from our disease

Clicking back to the graph view, you can expand to see direct connections out from the node by clicking on the node and then clicking on the graph icon. This will return all nodes connected to the disease by a single edge. 

> Tip: the node images may not be labeled the way you expect. Clicking on the node reveals a panel on the right, clicking on that node label at the top of the panel will reveal a pop-up that lets you pick which property is used as the caption in the graph view.

### Querying for connections out from our disease

In cypher, nodes are represented by `()` and edges are represented by `[]` in the form of `()-[]-()`, and your query is a little chance to express yourself with ascii art. To get the same results as the expanded graph view, you can query for any edge connecting to any node. Note that the query also asks for the connected node to be returned.

```cypher
MATCH (d {id: 'MONDO:0007038'})-[]-(n) RETURN d, n
```

### Expanding out further and restricting the relationship direction

It's possible to add another edge to the query to expand out further. In this case, we're adding a second edge to the query, and restricting the direction of the second edge to be outgoing. This will return all nodes connected to the disease by a single edge, and then all nodes connected to those nodes by a single outgoing edge. It's important to note that without limiting the direction of the association, this query will traverse up, and then back down the subclass tree.  

```cypher
MATCH (d {id: 'MONDO:0007038'})-[]->(n)-[]->(m) RETURN d,n,m
```

## Exploring the graph schema

Sometimes, we don't know what kind of questions to ask without seeing the shape of the data. Neo4j provides a graph representation of the schema by calling a procedure

```cypher
CALL db.schema.visualization
```

If you tug on nodes and zoom, you may find useful information, but it's not a practical way to explore the schema.

### What's connected to a gene?

We can explore the kinds of connections available for a given category of node. Using property restriction again, but this time instead of restricting by the ID, we'll restrict by the category. Also, instead of returning nodes themselves, we'll return the categories of those nodes. 

```cypher
MATCH (g:`biolink:Gene`)-[]->(n) RETURN DISTINCT labels(n)
```

> Tip: the `DISTINCT` keyword is used to remove duplicate results. In this case, we're only interested in the unique categories of nodes connected to genes.

### Also, how is it connected?

Expanding on the query above, we can also return the type of relationship connecting the gene to the node.

```cypher
MATCH (g:`biolink:Gene`)-[rel]->(n) RETURN DISTINCT type(rel), labels(n)
```

Which returns tabular data like:

```
╒════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════════╕
│"type(rel)"                                         │"labels(n)"                                                │
╞════════════════════════════════════════════════════╪═══════════════════════════════════════════════════════════╡
│"biolink:located_in"                                │["biolink:NamedThing","biolink:CellularComponent"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:part_of"                                   │["biolink:NamedThing","biolink:MacromolecularComplexMixin"]│
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within"                │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:enables"                                   │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:actively_involved_in"                      │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:colocalizes_with"                          │["biolink:NamedThing","biolink:CellularComponent"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:active_in"                                 │["biolink:NamedThing","biolink:CellularComponent"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within"                │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:actively_involved_in"                      │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:contributes_to"                            │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:orthologous_to"                            │["biolink:NamedThing","biolink:Gene"]                      │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:participates_in"                           │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:interacts_with"                            │["biolink:NamedThing","biolink:Gene"]                      │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:has_phenotype"                             │["biolink:NamedThing","biolink:GeneticInheritance"]        │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:has_phenotype"                             │["biolink:NamedThing","biolink:PhenotypicQuality"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:risk_affected_by"                          │["biolink:NamedThing","biolink:Disease"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:gene_associated_with_condition"            │["biolink:NamedThing","biolink:Disease"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:has_phenotype"                             │["biolink:NamedThing","biolink:ClinicalModifier"]          │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_positive_effect"          │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of"                          │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:risk_affected_by"                          │["biolink:NamedThing","biolink:Gene"]                      │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:gene_associated_with_condition"            │["biolink:NamedThing","biolink:Gene"]                      │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within_positive_effect"│["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:has_mode_of_inheritance"                   │["biolink:NamedThing","biolink:GeneticInheritance"]        │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_negative_effect"          │["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of"                          │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_positive_effect"          │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within_negative_effect"│["biolink:NamedThing","biolink:Occurrent"]                 │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:has_phenotype"                             │["biolink:NamedThing","biolink:PhenotypicFeature"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within_negative_effect"│["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_or_within_positive_effect"│["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing","biolink:GrossAnatomicalStructure"]  │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing","biolink:AnatomicalEntity"]          │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:acts_upstream_of_negative_effect"          │["biolink:NamedThing","biolink:Pathway"]                   │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing","biolink:Cell"]                      │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:located_in"                                │["biolink:NamedThing","biolink:MacromolecularComplexMixin"]│
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing","biolink:CellularComponent"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing","biolink:MacromolecularComplexMixin"]│
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:part_of"                                   │["biolink:NamedThing","biolink:CellularComponent"]         │
├────────────────────────────────────────────────────┼───────────────────────────────────────────────────────────┤
│"biolink:expressed_in"                              │["biolink:NamedThing"]                                     │
└────────────────────────────────────────────────────┴───────────────────────────────────────────────────────────┘

```


> Note: the DISTINCT keyword will only remove duplicate results if the entire result is the same. In this case, we're interested in the unique combinations of relationship type and node category.

### Kinds of associations between two entity types

Further constraining on the type of the connecting node, we can ask what kinds of associations exist between two entity types. For example, what kinds of associations exist between genes and diseases?

```cypher
MATCH (g:`biolink:Gene`)-[rel]->(n:`biolink:Disease`) RETURN DISTINCT type(rel)
```

```
╒════════════════════════════════════════╕
│"type(rel)"                             │
╞════════════════════════════════════════╡
│"biolink:gene_associated_with_condition"│
├────────────────────────────────────────┤
│"biolink:risk_affected_by"              │
└────────────────────────────────────────┘
```


### Diseases associated with a gene

```cypher
MATCH (g:`biolink:Gene`{id:"HGNC:1100"})-[]-(d:`biolink:Disease`) RETURN g,d
```

### Phenotypes associated with diseases associated with a gene

```cypher
MATCH (g:`biolink:Gene`{id:"HGNC:1100"})-[]->(d:`biolink:Disease`)-[]->(p:`biolink:PhenotypicFeature`) RETURN g,d,p
```

Why doesn't this return results?  This is a great opportunity to track down an unexpected problem. 

First, try a less constrained query, so that the 3rd node can be anything:

```cypher
MATCH (g:`biolink:Gene`{id:"HGNC:1100"})-[]->(d:`biolink:Disease`)-[]->(p) RETURN g,d,p
```

With a little tugging and stretching, a good picture emerges, and by clicking our phenotype bubbles, they look like they're showing as PhenotypicQuality rather than PhenotypicFeature. This is likely a bug, but a sensible alternative for this same intent might be:

```cypher
MATCH (g:`biolink:Gene`{id:"HGNC:1100"})-[]->(d:`biolink:Disease`)-[:`biolink:has_phenotype`]->(p) RETURN g,d,p
```

### Recursive traversal

Sometimes, we don't know the specific number of hops. What if we want to answer the question "What genes affect the risk for an inherited auditory system disease?" 

First, lets find out how are diseases connected to one another. Name the relationship to query for just the predicates.
```
MATCH (d:`biolink:Disease`)-[rel]-(d2:`biolink:Disease`) RETURN DISTINCT type(rel)
```

```
╒════════════════════════════════════════╕
│"type(rel)"                             │
╞════════════════════════════════════════╡
│"biolink:subclass_of"                   │
├────────────────────────────────────────┤
│"biolink:related_to"                    │
├────────────────────────────────────────┤
│"biolink:associated_with"               │
├────────────────────────────────────────┤
│"biolink:has_phenotype"                 │
├────────────────────────────────────────┤
│"biolink:gene_associated_with_condition"│
├────────────────────────────────────────┤
│"biolink:risk_affected_by"              │
└────────────────────────────────────────┘
```

(* Please ignore `biolink:gene_associated_with_condition` and `biolink:risk_affected_by` showing up here, those are due to a bug in our OMIM ingest)


We'll construct a query that fixes the super class disease, then connects at any distance to any subclass of that disease, and then brings genes that affect risk for those diseases. To avoid a big hairball graph being returned, we can return the results as a table showing the diseases and genes. 

```cypher
MATCH (d:`biolink:Disease`{id:"MONDO:0002409"})<-[:`biolink:subclass_of`*]-(d2:`biolink:Disease`)<-[`biolink:risk_affected_by`]-(g:`biolink:Gene`) RETURN d.id, d.name, d2.id, d2.name,g.symbol,g.id
```    

once you trust the query, you can also use the DISTINCT keyword again focus in on just the gene list
    
```cypher
MATCH (d:`biolink:Disease`{id:"MONDO:0002409"})<-[:`biolink:subclass_of`*]-(d2:`biolink:Disease`)<-[`biolink:risk_affected_by`]-(g:`biolink:Gene`) RETURN DISTINCT g.id
```

### Gene to Gene Associations

First, we can ask what kind of associations we have between genes.

```cypher
MATCH (g:`biolink:Gene`)-[rel]->(g2:`biolink:Gene`) RETURN DISTINCT type(rel)
```

```
╒════════════════════════════════════════╕
│"type(rel)"                             │
╞════════════════════════════════════════╡
│"biolink:orthologous_to"                │
├────────────────────────────────────────┤
│"biolink:interacts_with"                │
├────────────────────────────────────────┤
│"biolink:risk_affected_by"              │
├────────────────────────────────────────┤
│"biolink:gene_associated_with_condition"│
└────────────────────────────────────────┘
```

> Again, please ignore `biolink:gene_associated_with_condition` and `biolink:risk_affected_by`. 

Let's say that from the list above, we're super interested in the DIABLO gene, because, obviously, it has a cool name. We can find it's orthologues by querying through the `biolink:orthologous_to` relationship.

```cypher
MATCH (g {id:"HGNC:21528"})-[:`biolink:orthologous_to`]-(o:`biolink:Gene`) RETURN g,o 
```

We can then make the question more interesting, by finding phenotypes associated with these orthologues.

```cypher
MATCH (g {id:"HGNC:21528"})-[:`biolink:orthologous_to`]-(og:`biolink:Gene`)-[:`biolink:has_phenotype`]->(p) RETURN g,og,p
```

That was a dead end. What about gene expression? 

```cypher
MATCH (g {id:"HGNC:21528"})-[:`biolink:orthologous_to`]-(og:`biolink:Gene`)-[:`biolink:expressed_in`]->(a) RETURN g,og,a
```

We can add this one step further by connecting our gene expression list in UBERON terms 

```cypher
MATCH (g {id:"HGNC:21528"})-[:`biolink:orthologous_to`]-(og:`biolink:Gene`)-[:`biolink:expressed_in`]->(a)-[`biolink:subclass_of`]-(u) 
WHERE u.id STARTS WITH 'UBERON:'
RETURN distinct u.id, u.name
```

In particular, it's a nice confirmation to see that we started at the high level MONDO term "inherited auditory system disease", passed through subclass relationships to more specific diseases, connected to genes that affect risk for those diseases, focused on a single gene, and were able to find that it is expressed in the cochlea.

```
╒════════════════╤════════════════════════════════╕
│"u.id"          │"u.name"                        │
╞════════════════╪════════════════════════════════╡
│"UBERON:0000044"│"dorsal root ganglion"          │
├────────────────┼────────────────────────────────┤
│"UBERON:0000151"│"pectoral fin"                  │
├────────────────┼────────────────────────────────┤
│"UBERON:0000948"│"heart"                         │
├────────────────┼────────────────────────────────┤
│"UBERON:0000961"│"thoracic ganglion"             │
├────────────────┼────────────────────────────────┤
│"UBERON:0001017"│"central nervous system"        │
├────────────────┼────────────────────────────────┤
│"UBERON:0001555"│"digestive tract"               │
├────────────────┼────────────────────────────────┤
│"UBERON:0001675"│"trigeminal ganglion"           │
├────────────────┼────────────────────────────────┤
│"UBERON:0001700"│"geniculate ganglion"           │
├────────────────┼────────────────────────────────┤
│"UBERON:0001701"│"glossopharyngeal ganglion"     │
├────────────────┼────────────────────────────────┤
│"UBERON:0001844"│"cochlea"                       │
├────────────────┼────────────────────────────────┤
│"UBERON:0001991"│"cervical ganglion"             │
├────────────────┼────────────────────────────────┤
│"UBERON:0002107"│"liver"                         │
├────────────────┼────────────────────────────────┤
│"UBERON:0002441"│"cervicothoracic ganglion"      │
├────────────────┼────────────────────────────────┤
│"UBERON:0003060"│"pronephric duct"               │
├────────────────┼────────────────────────────────┤
│"UBERON:0003922"│"pancreatic epithelial bud"     │
├────────────────┼────────────────────────────────┤
│"UBERON:0004141"│"heart tube"                    │
├────────────────┼────────────────────────────────┤
│"UBERON:0004291"│"heart rudiment"                │
├────────────────┼────────────────────────────────┤
│"UBERON:0005426"│"lens vesicle"                  │
├────────────────┼────────────────────────────────┤
│"UBERON:0007269"│"pectoral appendage musculature"│
├────────────────┼────────────────────────────────┤
│"UBERON:0019249"│"2-cell stage embryo"           │
├────────────────┼────────────────────────────────┤
│"UBERON:0000965"│"lens of camera-type eye"       │
├────────────────┼────────────────────────────────┤
│"UBERON:0001645"│"trigeminal nerve"              │
├────────────────┼────────────────────────────────┤
│"UBERON:0003082"│"myotome"                       │
└────────────────┴────────────────────────────────┘
```
