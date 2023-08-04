## Effective ChatGPT prompts for ontology development

For a basic tutorial on how to leverage ChatGPT for ontology development see [here](../tutorial/chatgpt-ontology-curation.md).


### Act as a mapping API

I want you to act as a REST API, which takes natural language searches a an input and returns an SSSOM mapping in valid JSON in a codeblock, no comments,  no additional text. An example of a valid mapping is 

{
      "subject_id": "a:something",
      "predicate_id": "rdfs:subClassOf",
      "object_id": "b:something",
      "mapping_justification": "semapv:LexicalMatching",
      "subject_label": "XXXXX",
      "subject_category": "biolink:AnatomicalEntity",
      "object_label": "xxxxxx",
      "object_category": "biolink:AnatomicalEntity",
      "subject_source": "a:example",
      "object_source": "b:example",
      "mapping_tool": "rdf_matcher",
      "confidence": 0.8,
      "subject_match_field": [
        "rdfs:label"
      ],
      "object_match_field": [
        "rdfs:label"
      ],
      "match_string": [
        "xxxxx"
      ],
      "comment": "mock data"
    }

As a first task, I want you to return a suitable mapping for MONDO:0004975 in ICD 10 CM.

