# Reviewing disease mappings for Biocurators and Clinicians

## Description 

This guide provides guidelines on how to rapidly review large scale efforts to create mappings between ontology classes. 

Mapping can be created using tools like OAK to generate a bunch of mapping candidates. A reviewer then needs to determines whether the mapping is correct or not. 

Refer to [Are these two entities the same? A guide.](../howto/review-disease-mappings.md) for a comprehensive guide on determining a specific mapping.

## Guidelines
1. Depending on the format of the table you are reviewing, it is recommended that you open the table in a google spreadsheet, to allow for collaborative work and to allow yourself to add notes in a new column, or add formatting or color coding.
1. Hide any columns that are not relevant, to make it easier to quickly compare the mappings. For example, in the table below, you may want to hide the mapping_justification column, mapping_tool. You can also move the columns around so the labels are next to each other. 
1. Look at the confidence score for the mapping and look at the lower confidence scores first, as these are more likely to have issues.
1. Review the label of the mappings. Note, matching on the label is not always sufficient to conclude two terms are equivalent. Ideally, reviewers should compare the definitions of each term to ensure they have the same meaning.
1. Review how the match was made. If it is a lexical match, matching on labels, it is likely the mapping is correct but this should ideally be confirmed by reviewing the definitions as mentioned above.
1. If matches are made based on shared xrefs, these should be carefully reviewed because not all mapping between terminologies are intended to be equivalent xrefs. For example: MONDO:0000509 non-syndromic intellectual disability was mapped to DOID:0081098 autosomal recessive intellectual developmental disorder 13 based on the shared xref [OMIM:613192](https://omim.org/entry/613192). The Mondo class is broader than this DO class and this is not an exact mapping.
1. Watch out for matching on acronyms. Acronyms can mean a lot of different things and sometimes the mapping tools will incorrectly match on acronyms.

## Example mappings

|subject_id   |subject_label                         |predicate_id        |object_id         |object_label                          |mapping_justification |mapping_tool|confidence |subject_match_field|object_match_field|match_string                          |comment |
|-------------|--------------------------------------|--------------------|------------------|--------------------------------------|----------------------|------------|-----------|-------------------|------------------|--------------------------------------|--------|
|ID           |                                      |A oboInOwl:hasDbXref|>A oboInOwl:source|>A sssom:object_label                 |                      |            |           |                   |                  |                                      |        |
|MONDO:0000159|bone marrow failure syndrome          |MONDO:equivalentTo  |NCIT:C165614      |Bone Marrow Failure Syndrome          |semapv:LexicalMatching|oaklib      |0.849778895|rdfs:label         |rdfs:label        |bone marrow failure syndrome          |LEXMATCH|
|MONDO:0000376|respiratory system cancer             |MONDO:equivalentTo  |NCIT:C4571        |Malignant Respiratory System Neoplasm |semapv:LexicalMatching|oaklib      |0.8        |oio:hasExactSynonym|rdfs:label        |malignant respiratory system neoplasm |LEXMATCH|
|MONDO:0000437|cerebellar ataxia                     |MONDO:equivalentTo  |NCIT:C26702       |Ataxia                                |semapv:LexicalMatching|oaklib      |0.8        |oio:hasExactSynonym|rdfs:label        |ataxia                                |LEXMATCH|
|MONDO:0000541|jejunal adenocarcinoma                |MONDO:equivalentTo  |NCIT:C181158      |Jejunal Adenocarcinoma                |semapv:LexicalMatching|oaklib      |0.849778895|rdfs:label         |rdfs:label        |jejunal adenocarcinoma                |LEXMATCH|
|MONDO:0000543|ovarian melanoma                      |MONDO:equivalentTo  |NCIT:C178441      |Ovarian Melanoma                      |semapv:LexicalMatching|oaklib      |0.849778895|rdfs:label         |rdfs:label        |ovarian melanoma                      |LEXMATCH|
|MONDO:0000665|apraxia                               |MONDO:equivalentTo  |NCIT:C180557      |Apraxia                               |semapv:LexicalMatching|oaklib      |0.849778895|rdfs:label         |rdfs:label        |apraxia                               |LEXMATCH|
|MONDO:0000705|Clostridium difficile colitis         |MONDO:equivalentTo  |NCIT:C180523      |Clostridium difficile Infection       |semapv:LexicalMatching|oaklib      |0.8        |oio:hasExactSynonym|rdfs:label        |clostridium difficile infection       |LEXMATCH|
|MONDO:0000736|dyschromatosis universalis hereditaria|MONDO:equivalentTo  |NCIT:C173131      |Dyschromatosis Universalis Hereditaria|semapv:LexicalMatching|oaklib      |0.849778895|rdfs:label         |rdfs:label        |dyschromatosis universalis hereditaria|LEXMATCH|
