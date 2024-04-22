## Synonym validation

### Basic validation

#### The same synonym cannot be an exact synonym of two distinct concepts

- The most fundamental of all synonym checks: if the synonym is _exact_, the assumption is that no two terms can have the same synonym.
- Implemented in the form of the [duplicate_exact_synonym](https://robot.obolibrary.org/report_queries/duplicate_exact_synonym) check implemented in ROBOT report.

!!! warning

    Some exact synonyms are not globally unique. For example, the acronym "ASD" is an exact synonym of the concept representing "Atrial septal defect" and "Autism Spectrum Disorder".


#### The same synonym cannot be an exact synonym and a label at the same time

- Implemented in the form of the [duplicate_label_synonym](https://robot.obolibrary.org/report_queries/duplicate_label_synonym) check implemented in ROBOT report.
- This check has a long history of controversy and confusion. In general, we cannot expect this assumption to hold for various reason:
    - For historical reasons, many ontologies avoid attaching synonym metadata and provenance to the primary label of a class. For example, the Mondo ontology captures the preferred labels of various major nomenclature organisations. Instead of capturing which organisations prefer the label on the primary label, they are captured as "exact syonyms", even though the two often co-incide.
    - It is often considered more convenient to be able to expect _all_ exact synonyms to be available via "oboInOwl:hasExactSynonym", 
