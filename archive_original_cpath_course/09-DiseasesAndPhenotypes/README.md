# Week 09: Diseases and Phenotypes

**First Instructor:** Nico Matentzoglu  
**Second Instructor:** Nicole Vasilevsky

## Description
We are introducing the landscape of disease and phenotype ontologies, and sketch some of the ways they can be used to add value to your analysis.

## Learning Outcomes:
- be aware of major disease and phenotype ontologies that are available
- be able to decide which phenotype or disease ontology to use for different use cases
- understand how to leverage disease and phenotype ontologies for advanced data analytics
- have a basic understanding of how to integrate other data

## Preparation
1. This week, the preparation will consist only of installing software and running some scripts to prepare for the lesson. It is possible that this takes you only 30 minutes - but odds are, that there issues along the way that need to be ironed out. In summary, we want you to install Jupyter notebooks and python 3 to run mapping analyses. 
1. Install [anaconda](https://docs.anaconda.com/anaconda/install/windows/)
  - In most circumstances, on Windows, you should use the the 64-Bit installer
1. Clone [the coursework repository](https://github.com/cpathtutorial/mapping_course) on your machine
1. Start your Anaconda prompt (it looks like a terminal, CMD window), navigate to the directory (`cd .../mapping_course`) and run `odk.bat make all` (Windows), or `make all` (Unix)
1. Now we need to install our python dependencies, so we run `pip install -r requirements.txt`
1. Once the above has finished, we open the Anaconda Navigator, and start Jupyter Notebooks (Click on the `Launch` button)
1. In the Jupyter Tree in your Browser, navigate to the place you have cloned your `mapping_course` repo and open the notebook called `cpath_data_analysis.ipynb`
1. Once open, click on `Cell+Run cells` in the menu and hope that it works.
1. Spend some time reading through the notebook to get a cursory understanding of what is happening - we will discuss this in more depth in the next course.
  
## Topics
- [Overview of phenotype and disease ontologies](ontologylandscape.md)
- [Practical example](example.md)

## New Material
- [Landscape of ontologies](ontologylandscape.md) - Nicole
- What is the difference between phenotype and disease ontologies? - Nicole and Nico
- Map internal disease codes to ontology terms - Nico
- Grouping disease data with the ontology hierarchy - Nico

## Semantic Engineer Toolbox
  - Python libraries 
    - pandas
    - rdflib
