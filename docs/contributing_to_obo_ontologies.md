# Contributing to OBO ontologies

## Prerequisites
Participants will need to have access to the following resources and tools prior to the training:
- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)
- **Protege** - Install Protege 5.5, download it [here](https://protege.stanford.edu/)
- **[Install ELK 0.5](/redesign/installElk0.5.md)** 
- **Install GitHub Desktop** Please make sure you have some kind of git client installed on your machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

## Preparation
- Review tutorial on [Ontology Term Use](/redesign/01_ontologyTermUse.md)

## What is delivered as part of the course

**Description:** How to contribute terms to existing ontologies.

### Learning objectives
- [Use GitHub: create issues](#issues)
- [Use GitHub: make pull requests](#pr)
- [Understand basic Open Source etiquette](#etiquette)
- [Reading READMEs](readme)
- [Understand basics of ontology development workflows](workflow)
- [Understand ontology design patterns](pattern)
- [Use templates: ROBOT, DOSDP](template)
- [Basics of OWL](owl)

## Tutorials
- in person or video (link videos here as they become available)

## Additional materials and resources

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)

<a name="issues"></a> 
## Use GitHub: create issues

1. Go to GitHub tracker for the ontology where you'd like to create an issue
1. Select New issue
1. Pick appropriate template (if applicable)
1. Fill in the information that is requested on the template below each header
1. For a new term request, please include:
	1. A definition in the proper format
	1. Sources/cross references for synonyms
	1. Your ORCID
	1. Add any additional comments at the end
1. If you use a template, an ontology curator may automatically be assigned.

See [this example video](https://drive.google.com/file/d/14g9y1nmCmRTkPB1fa6y_jIW3lHyFV4-g/view?resourcekey): creating a new term request to the Mondo Disease Ontology

<a name="pr"></a> 
## Use GitHub: make pull requests

### Committing, pushing and making pull requests

1.  Review: Changes made to the ontology can be viewed in GitHub Desktop.

2.  Before committing, check the diff. Examples of a diff are pasted below. Large diffs are a sign that something went wrong. In this case, do not commit the changes and ask the ontology editors for help instead.

Example 1:

![](https://lh4.googleusercontent.com/dBtjnSflSSf85x1wO8lNFhqbjy4hx-ubSQe7UuGl7AimU5JqIWxez0TZIffqoI0j0Uey-ucWMJSp8EEu6AfGE5XOsGsh07K1H2gBzmbY1xoNFXlTfxoO13yC7zczajOZjPuDroEv)

1.  Commit: Add a meaningful message in the Commit field in the lower left, for example: add new class MONDO:0001012 episodic angioedema with eosinophilia

NOTE: You can use the word 'fixes' or 'closes' in the description of the commit message, followed by the corresponding ticket number (in the format #1234) - these are magic words in GitHub; when used in combination with the ticket number, it will automatically close the ticket. Learn more on this GitHub Help Documentation page about [Closing issues via commit messages](https://help.github.com/en/articles/closing-issues-using-keywords).

1.  Note: 'Fixes' and "Closes' are case-insensitive.

2.  If you don't want to close the ticket, just refer to the ticket # without the word 'Fixes' or use 'Adresses'. The commit will be associated with the correct ticket but the ticket will remain open. NOTE: It is also possible to type a longer message than allowed when using the '-m' argument; to do this, skip the -m, and a vi window (on mac) will open in which an unlimited description may be typed.

1.  Click Commit to [branch]. This will save the changes to the cl-edit.owl file. 

2.  Push: To incorporate the changes into the remote repository, click Publish branch.

### Make a Pull Request

1.  Click: Create Pull Request in GitHub Desktop

2.  This will automatically open GitHub Desktop 

3.  Click the green button 'Create pull request'

4.  You may now add comments to your pull request. 

5.  The CL editors team will review your PR and either ask for changes or merge it.

6.  The changes will be available in the next release.

<a name="etiquette"></a> 
## Basic Open Source etiquette

<a name="readme"></a> 
## Reading READMEs

<a name="workflow"></a> 
## Basics of ontology development workflows

<a name="pattern"></a> 
## Ontology design patterns

<a name="template"></a> 
## Use templates: ROBOT, DOSDP

<a name="owl"></a> 
## Basics of OWL