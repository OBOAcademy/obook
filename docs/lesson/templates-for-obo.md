# Templating systems for OBO ontologies: a deep dive

Ontologies are notoriously hard to edit. This makes it a very high burden to edit ontologies for anyone but a select few. However, many of the contents of ontologies are actually best edited by domain experts with often little or known ontological training - editing labels and synonyms, curating definitions, adding references to publications and many more. Furthermore, if we simply remove the burden of writing OWL axioms, editors with very little ontology training can actually curate even logical content: for example, if we want to describe that a class is restricted to a certain taxon (also known as taxon-restriction), the editor is often capable to select the appropriate taxon for a term (say, a "mouse heart" is restricted to the taxon of _Mus musculus_), but maybe they would not know how to "add that restriction to the ontology".

Tables are great (for a deep dive into tables and triples see [here](../reference/tables-and-triples.md)). Scientists in particular _love tables_, and, even more importantly, can be trained easily to edit data in spreadsheet tools, such as Google Sheets or Microsoft Excel.

Ontology templating systems, such as [DOSDP templates](../reference/glossary.md), [ROBOT templates](../reference/glossary.md) and [Reasonable Ontology Templates (OTTR)](../reference/glossary.md) allow separating the raw data in the ontology (labels, synonyms, related ontological entities, descriptions, cross-references and other metadata) from the OWL language patterns that are used to manifest them in the ontology. There are three main ingredients to a templating system:

1. A way to capture the data. In all the systems we care about, these are tables, usually manifested as spreadsheets in Excel or Google Sheets.
2. A way to capture the template. In ROBOT templates the templates are captured in a header row of the same table that captures the data, in DOSDP templates the templates are captured in a separate YAML file and in OTTR typically the templates are serialised as and RDF-graph in a format like RDF/XML or Turtle.
3. A toolkit that can combine the data and the template to generate OWL axioms and annotations. ROBOT templates can be compiled to OWL using [ROBOT](../reference/glossary.md), DOSDP templates can be compiled using [DOSDP tools](../reference/glossary.md) and [OTTR templates](../reference/glossary.md) using [Lutra](../reference/glossary.md).

In OBO we are currently mostly concerned with ROBOT templates and DOSDP templates. Before moving on, we recommend to complete a basic tutorial in both:

- [ROBOT template tutorial](../tutorial/robot-tutorial-1.md)
- [DOSDP template tutorial](../tutorial/dosdp-template.md)

## ROBOT template vs DOSDP template

Ontologies, especially in the biomedical domain, are complex and, while growing in size, increasingly hard to manage for their curators. In this section, we will look at some of the key differences of two popular templating systems in the OBO domain: Dead Simple Ontology Design Patterns (DOSDPs) and ROBOT templates. We will not cover the rationale for templates in general in much depth (the interested reader should check [ontology design patterns](http://ontologydesignpatterns.org/wiki/Main_Page) and [Reasonable Ontology Templates (OTTR): Motivation and Overview](https://vimeo.com/413131235), which pertains to a different system, but applies none-the-less in general), and focus on making it easier for developers to pick the right templating approach for their particular use case. We will first discuss in detail representational differences, before we go through the functional ones and delineate use cases.

### Structural differences, formats and tools

#### DOSDP templates: structure and format

DOSDP separates data and templates into two files: a yaml file which defines the template, and a TSV file which holds the data. Lets look at s example.

**The template: abnormalAnatomicalEntity**

```
pattern_name: abnormalAnatomicalEntity
pattern_iri: http://purl.obolibrary.org/obo/upheno/patterns/abnormalAnatomicalEntity.yaml
description: "Any unspecified abnormality of an anatomical entity."

contributors:
  - https://orcid.org/0000-0002-9900-7880
  - https://orcid.org/0000-0001-9076-6015
  - https://orcid.org/0000-0003-4148-4606
  - https://orcid.org/0000-0002-3528-5267

classes:
  quality: PATO:0000001
  abnormal: PATO:0000460
  anatomical entity: UBERON:0001062

relations:
  inheres_in_part_of: RO:0002314
  has_modifier: RO:0002573
  has_part: BFO:0000051

annotationProperties:
  exact_synonym: oio:hasExactSynonym

vars:
  anatomical_entity: "'anatomical entity'"

name:
  text: "abnormal %s"
  vars:
   - anatomical_entity

annotations:
  - annotationProperty: exact_synonym
    text: "abnormality of %s"
    vars:
     - anatomical_entity

def:
  text: "Abnormality of %s."
  vars:
    - anatomical_entity

equivalentTo:
  text: "'has_part' some ('quality' and ('inheres_in_part_of' some %s) and ('has_modifier' some 'abnormal'))"
  vars:
    - anatomical_entity
```

**The data: abnormalAnatomicalEntity.tsv**

| defined_class | defined_class_label              | anatomical_entity | anatomical_entity_label |
| ------------- | -------------------------------- | ----------------- | ----------------------- |
| HP:0040286    | Abnormal axial muscle morphology | UBERON:0003897    | axial muscle            |
| HP:0011297    | Abnormal digit morphology        | UBERON:0002544    | digit                   |

#### ROBOT templates: structure and format

ROBOT encodes both the template and the data in the same TSV; after the table header, the second row basically encodes the entire template logic, and the data follows in table row 3.

| ID         | Label                            | EQ                                                                                                    | Anatomy Label |
| ---------- | -------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------- |
| ID         | LABEL                            | EC 'has_part' some ('quality' and ('inheres_in_part_of' some %) and ('has_modifier' some 'abnormal')) |               |
| HP:0040286 | Abnormal axial muscle morphology | UBERON:0003897                                                                                        | axial muscle  |
| HP:0011297 | Abnormal digit morphology        | UBERON:0002544                                                                                        | digit         |

Note that for the `Anatomy Label` we deliberately left the second row empty, which instructs the ROBOT template _tool_ to _completely ignore this column_.

### A discussion on the main differences

#### Ontology Engineering perspective

From an ontology engineering perspective, the essence of the difference between DOSDP and ROBOT templates could be captured as follows:

```
DOSDP templates are more about generating annotations and axioms, while ROBOT templates are more about curating annotations and axioms.
```

`Curating annotations and axioms` means that an editor, or ontology curator, manually enters the labels, synonyms, definitions and so forth into the spreadsheet.

`Generating axioms` in the sense of this section means that we try to automatically generate labels, synonyms, definitions and so forth based on the related logical entities in the patterns. E.g., using the example template above, the label "abnormal kidney" would automatically be generated when the Uberon term for kidney is supplied.

While both ROBOT and DOSDP can be used for "curation" of annotation of axioms, DOSDP seeks to apply generation rules to automatically generate synonyms, labels, definitions and so forth while for ROBOT template seeks to collect manually curated information in an easy-to-use table which is then compiled into OWL. In other words:

- the average DOSDP user will not write their own labels, definitions and synonyms - they will want those to be generated automatically from a set of simple rules;
- the average ROBOT template user will not want automatically generated definitions, labels and synonyms - they will want to capture their own.

#### Sharing and Re-use

However, there is another dimension in which both approaches differ widely: sharing and re-use. DOSDPs by far the most important feature is that it allows a community of developers to rally around a modelling problem, debate and establish consensus; for example, a pattern can be used to say: this is how we model abnormal anatomical entities. Consensus can be made explicit by "signing off" on the pattern (e.g. by adding your ORCId to the list of contributors), and due to the template/data separation, the template can be simply imported using its IRI (for example http://purl.obolibrary.org/obo/upheno/patterns/abnormalAnatomicalEntity.yaml) and re-used by everyone. Furthermore, additional metadata fields including textual descriptions, and more recently "examples", make DOSDP template files comparatively easy to understand, even by a less technically inclined editor.

ROBOT templates on the other hand do not lend themselves to community debates in the same way; first of all, they are typically supplied including all data merged in; secondly, they do not provide additional metadata fields that could, for example, conveniently be used to represent a sign off (you could, of course, add the ORCId's into a non-functional column, or as a pipe-separated string into a cell in the first or second row; but its obvious that this would be quite clunky) or a textual description. A yaml file is much easier for a human to read and understand then the header of a TSV file, especially when the template becomes quite large.

However, there is a flipside to the strict separation of data and templates. One is that DOSDP templates are really hard to change. Once, for example, a particular variable name was chosen, renaming the variable will require an excessive community-wide action to rename columns in all associated spreadsheets - which requires them all to be known beforehand (which is not always the case). You don't have such a problem with ROBOT templates; if you change a column name, or a template string, everything will continue to work without any additional coordination.

#### Summary

Both ROBOT templates and DOSDP templates are widely used. The [author](https://github.com/matentzn) of this page uses both in most of the projects he is involved in, because of their different strengths and capabilities. You can use the following rules of thumb to inform your choice:

Consider ROBOT templates if your emphasis is on

1. manually curating labels, definitions, synonyms and axioms or other annotations
2. managing your templates in the spreadsheet itself is a concern for you (this is often the case, for example, when turning an existing data table into a ROBOT template ad hoc)

Consider DOSDP templates if your emphasis is on

2. re-use, community-wide implementation of the same templates and community discussion, you should consider DOSDP templates
3. automatically generating labels, definitions, synonyms from rules in the pattern.

#### Detour: Concerns with Managing Tables

There is a nice debate going on which questions the use of tables in ontology curation altogether. There are many nuances in this debate, but I want to stylise it here as two schools of thoughts (there are probably hundreds in between, but this makes it easier to follow): The one school (let's call them Tablosceptics) claims that using tables introduces a certain degree of fragility into the development process due to a number of factors, including:

1. losing the immediateness of QC feedback; Table-based development, so the Tablosceptics, encourages lazy editing (adding stuff to a template and then not reviewing the consequence properly, which we will discuss in more depth later).
2. losing track of the ID space (in a multi-table world, it becomes increasingly hard to manage IDs, making sure they are not double used etc) and 3) encouraging bad design (relying more on assertion than inference).

They prefer to use tools like [Protege](../reference/glossary.md) that show the curator immediately the consequences of their actions, like reasoning errors (unintended equivalent classes, unsatisfiable classes and other unintended inferences). The Tablophile school of thought responds to these accusations in essence with "tools"; they say that tables are essentially a convenient matrix to input the data (which in turns opens ontology curation to a much wider range of people), and it is up to the tools to ensure that QC is run, hierarchies are being presented for review and weird ID space clashes are flagged up. Furthermore, they say, having a controlled input matrix will actually decrease the number of faulty annotations or axioms (which is evidenced by the large number of wrongful annotation assertions across OBO foundry ontologies I see every day as part of my work). At first sight, both template systems are affected equally by the war of the Tablosceptics and the Tablophile. Indeed, in my on practice, the ID space issue is really problematic when we manage 100s and more templates, and so far, I have not seen a nice and clear solution that ensures that no ID used twice unless it is so intended and respects ID spaces which are often semi-formally assigned to individual curators of an ontology.

Generally in this course we do not want to take a 100% stance. The [author](https://github.com/matentzn) of this page believes that the advantage of using tables and involving many more people in the development process outweighs any concerns, but tooling is required that can provide more immediate feedback when such tables such as the ones presented here are curated at scale.
