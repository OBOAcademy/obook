# Standardizing Prefixes, CURIEs, and URIs with the `curies` package

Uniform resource identifiers (URIs) and compact URIs (CURIEs) have become the predominant syntaxes for identifying
concepts in linked data applications. Therefore, efficient, faultless, and idiomatic conversion between them is a
crucial low-level utility whose need is ubiquitous across many codebases.

The quick version is 1) instantiate a "converter" object and 2) use it to expand and compress URIs like in

```python
import curies

# Get a converter
converter = curies.get_obofoundry_converter()

>> > converter.compress("http://purl.obolibrary.org/obo/CHEBI_1")
'CHEBI:1'

>> > converter.expand("CHEBI:1")
'http://purl.obolibrary.org/obo/CHEBI_1'
```

## Data Structures

### Prefix Maps

A prefix map is a bijective mapping (i.e., no duplicate keys, no duplicate values) between CURIE prefixes and URI
prefixes
Found in semantic web applications like XML, RDF, SPARQL, and OWL

Example Prefix Map:

```json
{
  "CHEBI": "http://purl.obolibrary.org/obo/CHEBI_",
  "MONDO": "http://purl.obolibrary.org/obo/MONDO_",
  "GO": "http://purl.obolibrary.org/obo/GO_"
}
```

### Extended Prefix Maps

Standard prefix maps and JSON-LD context have several shortcomings because they don't handle synonyms for CURIE prefixes
nor URI prefixes. Therefore, we need a new format that can:

- include an arbitrary set of prefixes for CURIE prefixes and URI prefixes
- denote what's the preferred CURIE prefix and URI prefix
- use a simple format that can be encoded in JSON, YAML, etc.

The extended prefix map (EPM) is a new format to support this. Here's a short example that only has one record:

```json
[
  {
    "prefix": "CHEBI",
    "uri_prefix": "http://purl.obolibrary.org/obo/CHEBI_",
    "prefix_synonyms": [
      "chebi",
      ...
    ],
    "uri_prefix_synonyms": [
      "https://identifiers.org/chebi:"
    ]
  }
]
```

## Loading a Context

There are several ways to load a converter:

1. From a pre-defined context, like the OBO Foundry, Bioregistry, Monarch, or others
2. From a prefix map

    ```python
    
    import curies
    
    prefix_map = {
        "CHEBI": "http://purl.obolibrary.org/obo/CHEBI_",
    }
    converter = curies.load_prefix_map(prefix_map)
    ```

3. From an _extended_ prefix map. This is the preferred format since it supports synonyms for CURIE prefixes and URI
   prefixes. See [here](https://curies.readthedocs.io/en/latest/tutorial.html#loading-extended-prefix-maps).
4. From a JSON-LD context

A more details on each of these can be
found [here](https://curies.readthedocs.io/en/latest/tutorial.html#loading-a-context).

## Chaining and Merging

`curies` implements a faultless chain operation curies.chain() that is configurable for case sensitivity and fully
considers all synonyms.

`curies.chain()` prioritizes based on the order given. Therefore, if two prefix maps having the same prefix but
different URI prefixes are given, the first is retained. The second is retained as a synonym

```python
import curies

c1 = curies.load_prefix_map({"GO": "http://purl.obolibrary.org/obo/GO_"})
c2 = curies.load_prefix_map({"GO": "https://identifiers.org/go:"})
converter = curies.chain([c1, c2])

>> > converter.expand("GO:1234567")
'http://purl.obolibrary.org/obo/GO_1234567'
>> > converter.compress("http://purl.obolibrary.org/obo/GO_1234567")
'GO:1234567'
>> > converter.compress("https://identifiers.org/go:1234567")
'GO:1234567'
```

Chain is the perfect tool if you want to override parts of an existing extended prefix map. For example, if you want to
use most of the Bioregistry, but you would like to specify a custom URI prefix (e.g., using Identifiers.org), you can do
the following

```python
import curies

overrides = curies.load_prefix_map({"pubmed": "https://identifiers.org/pubmed:"})
bioregistry_converter = curies.get_bioregistry_converter()
converter = curies.chain([overrides, bioregistry_converter])

>> > converter.expand("pubmed:1234")
'https://identifiers.org/pubmed:1234'
```

More information can be found [here](https://curies.readthedocs.io/en/latest/tutorial.html#chaining-and-merging).

## Reconciliation

Reconciliation is the high-level process of modifying an (extended) prefix map with domain-specific rules. This is
important as it allows for building on existing (extended) prefix maps without having to start from scratch. Further,
storing the rules to transform an existing prefix map allows for high-level discussion about the differences and their
reasons.

As a specific example, the Bioregistry uses `snomedct` as a preferred prefix for the Systematized Nomenclature of
Medicine - Clinical Terms (SNOMED-CT). The OBO Foundry community prefers to use `SCTID` as the preferred prefix for this
resource. Rather than maintaining a different extended prefix map than the Bioregistry, the OBO Foundry community could
enumerate its preferred modifications to the base (extended) prefix map, then create its prefix map by transforming the
Bioregistry’s.

Similarly, a consumer of the OBO Foundry prefix map who’s implementing a resolver might want to override the URI prefix
associated with the Ontology of Vaccine Adverse Events (OVAE) to point towards the Ontology Lookup Service instead of
the default OntoBee.

There are two operations that are useful for transforming an existing (extended) prefix map:

1. Remapping is when a given CURIE prefix or URI prefix is replaced with another. See `curies.remap_curie_prefixes()`
   and `curies.remap_uri_prefixes()`.
2. Rewiring is when the correspondence between a CURIE prefix and URI prefix is updated. See `curies.rewire()`.

### Simple CURIE Remapping

If we start with the following extended prefix map,

```json
[
  {
    "prefix": "a",
    "uri_prefix": "https://example.org/a/",
    "prefix_synonyms": [
      "a1"
    ]
  },
  {
    "prefix": "b",
    "uri_prefix": "https://example.org/b/"
  }
]
```

we can apply the remapping `{"a": "a1"}` to get:

```json
[
  {
    "prefix": "a1",
    "uri_prefix": "https://example.org/a/",
    "prefix_synonyms": [
      "a"
    ]
  },
  {
    "prefix": "b",
    "uri_prefix": "https://example.org/b/"
  }
]
```

Notice that the old prefix is retained as a synonym.

### Transitive CURIE REmapping

There’s a special case of CURIE prefix remapping where one prefix is supposed to overwrite another. For example, in the
Bioregistry, the Gene Expression Omnibus is given the prefix geo and the Geographical Entity Ontology is given the
prefix `geogeo`. OBO Foundry users will want to rename the Gene Expression Omnibus record to something else
like `ncbi.geo`and rename `geogeo` to `geo`. Taken by themselves, these two operations would not accomplish the desired
results:

1. Remapping with `{"geo": "ncbi.geo"}` would retain geo as a CURIE prefix synonym
2. Remapping with `{"geogeo": "geo"}` would not change the mapping as geo is already part of a different record.

The curies.remap_curie_prefixes() implements special logic to identify scenarios where two (or more) remappings are
dependent (we’re calling these transitive remappings) and apply them in the expected way. Therefore, we see the
following:

```python
from curies import Converter, Record, remap_curie_prefixes

converter = Converter([
    Record(prefix="geo", uri_prefix="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc="),
    Record(prefix="geogeo", uri_prefix="http://purl.obolibrary.org/obo/GEO_"),
])
remapping = {"geo": "ncbi.geo", "geogeo": "geo"}
converter = remap_curie_prefixes(converter, curie_remapping)

>> > converter.records
[
    Record(
        prefix="geo",
        prefix_synonyms=["geogeo"],
        uri_prefix="http://purl.obolibrary.org/obo/GEO_",
    ),
    Record(
        prefix="ncbi.geo",
        uri_prefix="https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=",
    ),
]
```

`geogeo` is maintained as a CURIE prefix synonym for the Geographical Entity Ontology’s record. Synonyms of Gene
Expression Omnibus would also be retained.

More information about reconciliation can be found [here](https://curies.readthedocs.io/en/latest/reconciliation.html).

## Further Reading

A full tutorial for the `curies` package lives [here](https://curies.readthedocs.io/en/latest/tutorial.html).
