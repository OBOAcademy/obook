# Learning Outcomes for Critical Path Tutorial

1. Understand the value of URIs as global identifiers and the potential shortcomings.
2. Having a basic picture of the flagship efforts of the Semantic Web.
3. Being aware of some of the central Semantic Web applications in the biomedical domain.
4. Having a cursory understanding of how linked data can help to power your Critical Path data analysis problems.


# Interesting Case Studies to talk about:

1. The Experimental Factor Ontology: from controlled vocabulary to integrated application ontology driving drug target identification.
1. From barely structured data via data dictionaries to semantic data integration:
   - International HundredK+ Cohorts Consortium (IHCC) data harmonization case study: How to get from messy, individual data dictionaries for COHORT data to an integrated resource for browsing and grouping.
   - The EJPRD story:
     - Registry level integration using a [semantic metadata model](https://github.com/ejp-rd-vp/resource-metadata-schema)
     - [Common data elements](https://github.com/ejp-rd-vp/CDE-semantic-model) in rare disease registration.

## EFO case study
 1. Build controlled vocabulary
 2. Look a bit at the [anatomy of a term](https://www.ebi.ac.uk/ols/ontologies/efo/terms?short_form=EFO_1000036)
 3. So what happens now? 
     1. The story of scientific database curation
     2. The [integrator hub](https://docs.targetvalidation.org/data-sources/data-sources) with the killer use case comes along
     3. Now the vocabulary is getting “forced” onto other databases that want to be part (and have to be part)
     4. The number of terms needed shoot up exponentially - external ontologies need two be integrated
         1. Uberon
         2. [Mondo](https://mondo.readthedocs.io/)
             1. Why Mondo and not DO?
         3. Finally: better, more specialised hierarchies
         4. Its hard to re-use. (Measurement story)
     5. Output data of integrator hub can now be integrated even higher (e.g. disease to gene networks)
     6. Individual sources can also be integrated individually
 7. Stories like this happen all the time: The SCDO story
    1. First started building a vocab
    2. Then using ROBOT
    3. Then linking OBO terms
    4. Then applying for OBO membership
    5. Then using OBO purls and re-using OBO terms
    6. More to come


## IHCC story
1. Cohort data are scattered and there is no easy way to group data across cohorts
2. Even just finding the right cohort can be difficult 
   1. Data dictionaries are often just spreadsheets on someones computer
   2. Data dictionaries do not have rich metadata (you dont know data dictionary category or value pertains to a disease)
3. What to do:
   1. Build controlled vocabulary
   2. Map data dictionaries to a controlled vocabulary
   3. Build ontological model from controlled terms rich enough to group the data for the use cases at hand
   4. Design a process that makes the above scalable
4. Show [examples](https://github.com/IHCC-cohorts/data-harmonization/tree/master/data)
5. So now, we want enable the discovery of data across these cohorts.
   1. Build [GECKO](https://www.ebi.ac.uk/ols/ontologies/gecko)
   2. Assign data dictionary elements to IDs and [publish as "Linked Data"](https://github.com/IHCC-cohorts/data-harmonization/tree/master/data_dictionaries) ([browse here](https://registry.ihccglobal.app/ontologies/elsabrasil))
   3. Build mapping pipeline
       1. Check example [google sheet](https://docs.google.com/spreadsheets/d/1obJtqFUqTvL7DbdqX-la0V_oufr03YAlwmmL_q6X6oA/edit?ts=60803666#gid=1648962796)
       2. Link IDs to ontology terms
6. These links can now [be used to group the metadata](https://atlas.ihccglobal.org/) for identifying cohorts

## EJPRD story
1. Rare disease registries are scattered across the web and there is no easy way to search across all
2. EJPRD is developing two metadata schemas:
   1. On Registry level, they are building the [metadata model](https://github.com/EBISPOT/ejprd-metadata-models) which is reusing some standard vocabularies such as dcat. There is not that much "semantics" here - it really is a metadata model
   2. On Record level, they are building the [Clinical Data Elements (CDE) Semantic Model](https://github.com/ejp-rd-vp/CDE-semantic-model), see for example the [core model](https://github.com/ejp-rd-vp/CDE-semantic-model/wiki/Core-model-SIO).
3. The idea is that registries publish their metadata (and eventually data) as linked data that can be easily queried using the above models. One of the most major problems is the size of the project and competing voices ("If its not RDF its not FAIR"), but also the sheer scale of the technical issue: many of the so called registries are essentially excel spreadsheets on an FTP server.


