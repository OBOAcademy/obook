# Basic SPARQL commands useful for OBO Engineers

## Basic SELECT query

A basic SELECT query contains a set of prefixes, a SELECT clause and a WHERE clause.

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?term ?value
WHERE {
  ?term rdfs:label ?value .
}
```

### Prefixes

Prefixes allow you to specify shortcuts. For example, instead of using the prefixes above, you could have simply said:

```
SELECT ?term ?value
WHERE {
  ?term <http://www.w3.org/2000/01/rdf-schema#label> ?value .
}
```

Without the prefix. It means the exact same thing. But it looks nicer. Some people even go as far as adding entire entities into the prefix header:


```
PREFIX label: <http://www.w3.org/2000/01/rdf-schema#label>

SELECT ?term ?value
WHERE {
  ?term label: ?value .
}
```

This query is, again, the same as the ones above, but even more concise.

### SELECT clause

The SELECT clause defines what you part of you query you want to show, for example, as a table.

```
SELECT ?term ?value
```

means: "return" or "show" whatever you find for the variable `?term` and the variable `?value`.

There are other cool things you can do in the SELECT clause:

- Maths. You can count.