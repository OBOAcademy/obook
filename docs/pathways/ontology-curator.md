# Ontology Curator Pathway

There is no one single accepted methodology for building ontologies in the OBO-World. We can distinguish at least two major schools of ontology curation

- GO-style ontology curation
- OBI-style ontology curation

Note that there are many more variants, probably as many as there are ontologies. Both schools differ only in _how_ they curate their ontologies - the final product is always an ontology in accordance with [OBO Principles](http://dashboard.obofoundry.org/). These are some of the main differences of the two schools:

| | GO-style | OBI-style |
| ----- | -------- | --------- |
| Edit format |  Historically developed in OBO format | Developed in an OWL format |
| Annotation properties | Many annotation properties from the oboInOwl namespace, for example for synonyms and provenance. | Many annotation properties from the IAO namespace. |
| Upper Ontology | Hesitant alignment with BFO, often uncommitted. | Strong alignment with BFO. |
| Logic | Tend do be simple existential restrictions (`some`), ontologies in OWL 2 EL. No class expression nesting. | Tend to use a lot more expressive logic, including `only` and `not`. Class expression nesting can be more complex. |

There are a lot of processes happening that are bringing these schools together, sharing best practices (GitHub, documentation) and reconciling metadata conventions and annotation properties in the [OBO Metadata Ontology (OMO)](https://github.com/information-artifact-ontology/ontology-metadata/). The Upper Level alignment is now done by members of both schools through the [Core Ontology for Biology and Biomedicine (COB)](https://github.com/OBOFoundry/COB). While these processes are ongoing, we decided to curate separate pathways for both schools:

- [Pathway for GO-style ontology curation](ontology-curator-go-style.md)
- [Pathway for OBI-style ontology curation](ontology-curator-obi-style.md)