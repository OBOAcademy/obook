# Templating systems for OBO ontologies: a deep dive



## ROBOT template vs DOSDP template

Ontologies, especially in the biomedical domain, are complex and, while growing in size, increasingly hard to manage for their curators. In this article, we will look at some of the key differences of two popular templating systems: Dead Simple Ontology Design Patterns (DOSDPs) and ROBOT templates. We will not cover the rationale for templates in general in much depth (the interested reader should check x and y), and focus on making it easier for developers to pick the right templating approach for their particular use case. We will first discuss in detail representational differences, before we go through the functional ones and delineate use cases. In the very end of this 
Structural differences, formats and tools
DOSDP separates data and templates into two files: a yaml file which defines the template, and a TSV file which holds the data. Example:

The template: abnormalAnatomicalEntity
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




The data: abnormalAnatomicalEntity.tsv
defined_class
defined_class_label
anatomical_entity
anatomical_entity_label
http://purl.obolibrary.org/obo/HP_0040286
Abnormal axial muscle morphology
http://purl.obolibrary.org/obo/UBERON_0003897
axial muscle
http://purl.obolibrary.org/obo/HP_0011297
Abnormal digit morphology
http://purl.obolibrary.org/obo/UBERON_0002544
digit


ROBOT encodes both the template and the data in the same TSV; after the table header, the second row basically encodes the entire template logic, and the data follows in table row 3. Example:



If I had to capture the essence of the difference between DOSDP and ROBOT template with my ontology engineering hat on, I would probably say: “DOSDP is more about generating data and axioms, while ROBOT template is more about curating data and axioms.” This is not to say that ROBOT template does not generate, or DOSDP cannot be used in curation, but I think the essence of the difference lies in the fact that DOSDP seeks to apply generation rules to automatically generate synonyms, labels, definitions and so forth while ROBOT template seeks to collect manually curated information in an easy-to-use table which is then compiled into OWL. In other words: the average DOSDP user will not write their own labels, definitions and synonyms - they will want those to be generated automatically from a set of simple rules; the average ROBOT template user will not want automatically generated definitions, labels and synonyms - they will want to capture their own. However, there is another dimension in which both approaches differ widely: sharing and re-use. DOSDPs by far the most important feature is that it allows a community of developers to rally around a modelling problem, debate and establish consensus; for example, a pattern can be used to say: this is how we model abnormal anatomical entities. Consensus can be made explicit by “signing off” on the pattern (adding your orcid to the list of contributors), and due to the template/data separation, the template can be simply imported using its IRI (for example http://purl.obolibrary.org/obo/upheno/patterns/abnormalAnatomicalEntity.yaml) and re-used by everyone. Furthermore, additional metadata fields including textual descriptions, and more recently “examples”, make DOSDP template files simply very easy to understand. ROBOT templates on the other hand do not lend themselves to community debates in the same way; first of all, they are typically supplied including all data merged in; secondly, they do not provide additional metadata fields that could, for example, conveniently be used to represent a sign off (you could, of course, add the orcids into a non-functional column, or as a pipe-separated string into a cell in the first or second row; but its obvious that this would be quite clunky) or a textual description. A yaml file is much easier for a human to read and understand then the header of a tsv file, especially when the template becomes quite large. However, there is a flipside to the strict separation of data and templates. One is that DOSDP templates are really hard to change. Once, for example, a particular variable name was chosen, renaming the variable will require an excessive community-wide action to rename columns in all associated spreadsheets - which requires them all to be known beforehand (which is not always the case). You don't have such a problem with ROBOT templates; if you change a column name, or a template string, everything will continue to work without any additional coordination. 

Compare expressivity;

The war of the Tablosceptics and the Tablophile
We are now getting to the most contentious debate on the matter of template based ontology development: the fragility of the tables themselves. There is a nice debate going on (to which I have not much more to contribute other than contrasting their arguments as I see them) which questions the use of tables in ontology curation altogether. There are many nuances in this debate, but I want to stylise it here as two schools of thoughts (there are probably hundreds in between, but this makes it easier to follow): The one school (let's call them Tablosceptics) claims that using tables introduces a certain degree of fragility into the development process due to a number of factors, including: 1) losing the immediateness of QC feedback; Table-based development, so the Tablosceptics, encourages lazy editing (adding stuff to a template and then not reviewing the consequence properly, which we will discuss in more depth later). 2) losing track of the ID space (in a multi-table world, it becomes increasingly hard to manage IDs, making sure they are not double used etc) and 3) encouraging bad design (relying more on assertion than inference). The Tablophile school of thought responds to these accusations in essence with “tools”; they say that tables are essentially a convenient matrix to input the data (which in turns opens ontology curation to a much wider range of people), and it is up to the tools to ensure that QC is run, hierarchies are being presented for review and weird ID space clashes are flagged up. Furthermore, they say, having a controlled input matrix will actually decrease the number of faulty annotations or axioms (which is evidenced by the large number of wrongful annotation assertions across OBO foundry ontologies I see every day as part of my work). At first sight, both template systems are affected equally by the war of the Tablosceptics and the Tablophile. Indeed, in my on practice, the ID space issue is really problematic when we manage 100s and more templates, and so far, I have not seen a nice and clear solution that ensures that no ID used twice unless it is so intended and respects ID spaces which are often semi-formally assigned to individual curators of an ontology (I may be allowed to use IDs in the range of 100-999, say).
Summary



DOSDP
ROBOT template
Format
Data and template are separate: template in a yaml file, data in a TSV file
Data and template are combined in the same TSV file: the template is encoded in the second row after the header row, and the 
data as rows after the third row.
Tools
ROBOT
dosdp-tools
Operation: tsv2owl
ROBOT template
DOSDP generate
Using strings
No
Yes









