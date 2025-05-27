# Using the Delphi method to bring domain knowledge into ontologies

## Overview
Ontologies are meant to be underpinned by domain knowledge, but there are huge cognitive and technical barriers to contributing directly to ontologies. Many domain experts do not have knowledge of logical axioms, OWL, URIs or Github, yet still have much to contribute to ontology development.

Enter the [Delphi method](https://en.wikipedia.org/wiki/Delphi_method) - a widely-used social science methodology designed to help experts reach consensus. Broadly, the method involves soliciting predictions or knowledge from groups of experts, synthesizing that, then presenting it back to those same experts in an anonymized form and conducting revisions. Rinse and repeat for as long as necessary.

The process works a little differently when applied to ontologies.

Typically ontology researchers will ask participants to review an ontology based on design criteria using a survey and rate terms on a Likert scale. These surveys can be simple, such as asking the experts to rate their level of agreement with the term and its definition, and provide suggestions to update inadequate terms ([Hassan and Mat Nayan 2021](http://link.springer.com/10.1007/978-3-030-66501-2_5)). 

The process can also handle more complex input. For example, Holsapple and Joshi ([2002](https://dl.acm.org/doi/10.1145/503124.503147)) asked participants to rate the comprehensiveness, correctness, conciseness, clarity and utility of an ontology and to provide suggestions for improvement where they felt it fell short of those criteria. The improvements were then integrated into the ontology and a revised version was created and presented again to the experts (called a "round" in the Delphi process).

This guide will walk through the steps of conducting a Delphi method review of an ontology or its parts starting with developing an anchor ontology, followed by selecting a sample, determining your criteria, and executing the study.

We will talk through this process using the example of an ontology of ecological interventions being developed as part of the Environment Ontology ([ENVO](https://github.com/EnvironmentOntology/envo/)).

## Study preparation
### Anchor ontology
Unless you're paying experts, the survey needs to be scoped to ensure that it doesn't take participants too much time to review the ontology. This can be tricky since many ontologies have thousands of terms. 

You might be developing a project ontology or a modification of a domain ontology. In the case of a project ontology, it may be small enough that the whole ontology can be the "anchor ontology." 

The basic idea here is that you select a subset of terms on which you want feedback. Technically speaking, this can be extracted from the ontology using [ROBOT](https://robot.obolibrary.org/) or [RDFLib](https://github.com/RDFLib/pyrdfa3).

**For example:** We wish to solicit feedback from domain experts specifically on our ecological intervention terms. Those all are subclasses of [active ecosystem management process](http://purl.obolibrary.org/obo/ENVO_01001170) (`ENVO:01001170`), so we can consider that to be our anchor ontology.
### Sample selection
"Purposive sampling" is typically used in the Delphi process, which means that you find a group of experts who have the relevant knowledge to comment on the terms. This contrasts with random sampling, which attempts to get a representative sample of a population. 

Typical sample sizes in the published research range from 4 to 79 experts, with an average of 24.

**For example:** We created a list of academics (n = 15) and practitioners (n = 15) with expertise in restoration ecology. We also used [snowball sampling](https://en.wikipedia.org/wiki/Snowball_sampling) to find participants not part of our professional networks.
### Survey design
Once you have your anchor ontology, it's time to solicit feedback and do revisions. The Delphi process is an iterative one. Each round should involve changes to the anchor ontology which are then subsequently presented back to the experts.

Ontology terms and definitions may be a bit obtuse for domain experts not familiar with Aristotelian definitions, axioms, and so on. It may be beneficial to design an "interpretation layer" where the definitions are made more readable. You could also consider clustering the terms (e.g. we include "planting process" and all of its subclasses as one "term" in our survey). 

Typically you would use a [Likert scale](https://en.wikipedia.org/wiki/Likert_scale) to allow people to rate each term according to certain criteria. The criteria you select are crucial. [Raad and Cruz (2015)](https://www.scitepress.org/PublishedPapers/2015/55910/pdf/index.html) present a good list of criteria in their open access paper. Here are the criteria that may be relevant to ask domain experts about:
- **Accuracy** - Are the definitions, descriptions and properties correct?
- **Conciseness** - Does the ontology include extraneous elements?
- **Clarity** - How clear are the ontology term labels and definitions?
- **Completeness** - Is the domain of interest covered by this ontology?

Each item should have a Likert rating and an open textbox for respondents to suggest changes to the ontology.

There are three additional criteria that may best be evaluated by the ontology mechanic responsible for the project:
- **Adaptability** - Can the ontology fulfill its anticipated tasks?
- **Computational efficiency** - How well does the reasoner work with the ontology?
- **Consistency** - Does the ontology have any contradictions?

Each iteration of the ontology should also run the reasoner and quality control tools (e.g. [ROBOT report](https://robot.obolibrary.org/report); [OntOlogy Pitfall Scanner!](https://oops.linkeddata.es/))

**For example:** Here is one section of our survey that shows the cluster of terms under "mechanical vegetation removal process" and the rating + textbox:

![[../images/delphi_racoon_example.jpg]]
#### Automated survey creation
It is entirely possible to automate the survey creation process by piping your OWL file into a Python script which will then feed it into a jinja2 template and spit out a CSV that can be imported into survey software. 

There is an example of this approach implemented in Python that creates surveys for [REDCap](https://project-redcap.org/) in [this repository](https://github.com/timalamenciak/paperDelphiOntology/blob/main/owl2delphi.py). There are a number of options for automating this step, including using the open source survey platform [LimeSurvey](https://www.limesurvey.org/) or combining [Airtables](https://www.airtable.com/) with [Fillout](https://www.fillout.com/airtable).
## Revision and review process (rounds)

The survey above should change for each round of the Delphi process. Typically the Delphi process continues until consensus is reached. Consensus may mean that there are no changes to be made, or that people agree within a certain range.

You as the researcher and ontology mechanic get to decide where that cut-off is. 

## Final ontology

After you are satisfied with the consensus received, you can release the ontology in the wild. You may also choose to indicate that specific terms have gone through this Delphi process. There is not a standard annotation property for this, but it can be included as a comment on the term.