# Ontology Contribution

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
- How to use GitHub
  - [GitHub workflows](#gh-workflows)
  - [Branch vs Fork](#branch)
  - [How to create GitHub Issues](#issues)
- [Understand basic Open Source etiquette](#etiquette)
- [Reading READMEs](readme)
- [Understand basics of ontology development workflows](workflow)
  - [Browsing and Searching an ontology in Protege](#browsing)
- [Use GitHub: make pull requests](#pr)
- [Understand ontology design patterns](pattern)
- [Use templates: ROBOT, DOSDP](template)
- [Basics of OWL](owl)

## Tutorials
- in person or video (link videos here as they become available)

## Additional materials and resources

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)


## Use GitHub

<a name="gh-workflows"></a> 
### GitHub workflows

GitHub - distributed version control (Git) + social media for geeks who like to build code/documented collaboratively.

A Git repo consists of a set of branches each with a complete history of all changes ever made to the files and directories. This is true for a local copy you check out to your computer from GitHub or for a copy (fork) you make on GitHub.

![image](https://user-images.githubusercontent.com/6722114/115820759-59267500-a3b6-11eb-8452-b44404ce7aa7.png)

A Git repo typically has a master or main branch that is not directly editing.  Changes are made by creating a branch from Master (complete copy of the Master + its history).  

<a name="branch"></a> 
### Branch vs Fork

You can copy (fork) any GitHub repo to some other location on GitHub without having to ask permission from the owners.  If you modify some files in that repo, e.g. to fix a bug in some code, or a typo in a document, you can then suggest to the owners (via a Pull Request) that they adopt (merge) you your changes back into their repo.

If you have permission from the owners, you can instead make a new branch. For this training, we gave you access to the repository. See the [Appendix](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/appendix.md) for instructions on how to make a fork.

<a name="issues"></a> 
### Create GitHub Issues

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

<a name="etiquette"></a> 
## Basic Open Source etiquette

- Keep in mind that open source ontology repositories on GitHub are public and open to all. 
- Be respectful in your requests and comments.
- Do not include any private information.
- GitHub sends notifications to your email, and you can respond via your email client. Keep in mind, the responses are posted publicly. Be sure to delete your email signature that includes any personal information, like your email address or phone number.
- Many ontologies have limited resources and personnel for development and maintenance. Please be patient with your requests.
- If your ticket/request has been unanswered for a long period of time, feel free to kindly check in by commenting on the ticket. 
- Including a deadline or priority on the ticket can help the ontology curators with triaging tickets. 

<a name="readme"></a> 
## Reading READMEs

A README is a text file that introduces and explains a project. It is intended for _everyone_, not just the software or ontology developers. Ideally, the README file will include detailed information about the ontology, how to get started with using any of the files, license information and other details. The README is usually on the front page of the GitHub repository.

<a name="workflow"></a> 
## Basics of ontology development workflows

### Ontology development workflows

The steps below describe how to make changes to an ontology.

1. Go to the GitHub repository for your ontology, and clone the repository. The example below describes how to clone the Mondo Disease Ontology repo, but this can be applied to any ontology that is stored in GitHub.

#### Clone the Mondo repo

1.  Open the [Mondo GitHub repository](https://github.com/monarch-initiative/mondo)
2.  Click Code

 ![image](https://user-images.githubusercontent.com/6722114/116610830-801b0480-a8ea-11eb-8567-9da0c1159954.png)

3. Click 'Open with GitHub Desktop'

![image](https://user-images.githubusercontent.com/6722114/115820985-c3d7b080-a3b6-11eb-8131-7b9c33cc294d.png)

4. You will be given an option as to where to save the repository. I have a folder called 'git' where I save all of my local repos.
5. This will open GitHub Desktop and the repo should start downloading. This could take some time depending on how big the file is and how much memory your computer has.

#### Create a branch using GitHub Desktop
3. Click the little arrow in Current Branch
4. Click New Branch
5. Give your branch a name: training-initials (ie `training-NV`)

![image](https://user-images.githubusercontent.com/6722114/115821352-7ad42c00-a3b7-11eb-97e0-b02611eb77e6.png)

#### Open the Ontology edit file in Protege

1. Open Protege
2. Go to: File -> Open
3. Navigate to [ontology-name]/src/ontology/[ontology-name]-edit.obo and open this file in Protege. For example: mondo/src/ontology/mondo-edit.obo 
4. _Note: all ontologies that use the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit) will have the 'edit' files stored in the same folder path: src/ontology/[ontology-name]-edit.owl (or [ontology-name]-edit.obo)_

<a name="browsing"></a> 
### Browsing and Searching an ontology in Protege

The instructions below are using the Mondo Disease Ontology as an example, but this can be applied to any ontology.

#### Open the Mondo in Protégé

_Note: Windows users should open Protege using run.bat_

1.  Navigate to where you downloaded the repository and open the mondo-edit.obo file (src/ontology/mondo-edit.obo)
2.  When you open Protege, you will be on the Active Ontology tab
3.  Note the Ontology IRI field. The IRI is used to identify the ontology on the Web.

![image](https://user-images.githubusercontent.com/6722114/115821407-9b03eb00-a3b7-11eb-8dd2-7eb0eb9593eb.png)

#### The Protégé UI

The Protégé interface follows a basic paradigm of Tabs and Panels. By default, Protégé launches with the main tabs seen below. The layout of tabs and panels is configurable by the user. The Tab list will have slight differences from version to version, and depending on your configuration. It will also reflect your customizations.

To customize your view, go to the Window tab on the toolbar and select Views. Here you can customize which panels you see in each tab. In the tabs view, you can select which tabs you will see. You will commonly want to see the Entities tab, which has the Classes tab and the Object Properties tab.

![image](https://user-images.githubusercontent.com/6722114/115821442-a9520700-a3b7-11eb-9710-cc85471f133b.png)

Note: if you open a new ontology while viewing your current ontology, Protégé will ask you if you'd like to open it in a new window.  **_For most normal usage you should answer no._** This will open in a new window.

The panel in the center is the ontology annotations panel. This panel contains basic metadata about the ontology, such as the authors, a short description and license information.

![image](https://user-images.githubusercontent.com/6722114/115821747-34cb9800-a3b8-11eb-9ec4-302ed3fcd222.png)

#### Running the reasoner

Before browsing  or searching an ontology, it is useful to run an OWL reasoner first.  This ensures that you can view the full, intended classification and allows you to run queries.  Navigate to the query menu, and run the ELK reasoner:

![image](https://user-images.githubusercontent.com/6722114/115822558-9b04ea80-a3b9-11eb-922b-c4c908fd99cc.png)

#### Entities tab

You will see various tabs along the top of the screen. Each tab provides a different perspective on the ontology. 
For the purposes of this tutorial, we care mostly about the Entities tab, the DL query tab and the search tool.  OWL Entities include Classes (which we are focussed on editing in this tutorial), relations (OWL Object Properties) and Annotation Properties (terms like, 'definition' and 'label' which we use to annotate OWL entities.
Select the Entities tab and then the Classes sub-tab.  Now choose the inferred view (as shown below).

![image](https://user-images.githubusercontent.com/6722114/115822595-a9530680-a3b9-11eb-8797-b60964733067.png)

The Entities tab is split into two halves. The left-hand side provides a suite of panels for selecting various entities in your ontology. When a particular entity is selected the panels on the right-hand side display information about that entity. The entities panel is context specific, so if you have a class selected (like Thing) then the panels on the right are aimed at editing classes. The panels on the right are customizable. Based on prior use you may see new panes or alternate arrangements.
You should see the class OWL:Thing.  You could start browsing from here, but the upper level view of the ontology is too abstract for our purposes. To find something more interesting to look at we need to search or query.

#### Searching in Protege

You can search for any entity using the search bar on the right:

![image](https://user-images.githubusercontent.com/6722114/115822673-c8ea2f00-a3b9-11eb-9dca-dfe3d3bfe72a.png)

The search window will open on top of your Protege pane, we recommend resizing it and moving it to the side of the main window so you can view together.  

![image](https://user-images.githubusercontent.com/6722114/115822725-dacbd200-a3b9-11eb-96de-5b727f931a71.png)

Here's an example search for 'COVID-19':
![image](https://user-images.githubusercontent.com/6722114/115822742-e28b7680-a3b9-11eb-8d28-1046833b2f4d.png)

It shows results found in display names, definitions, synonyms and more.  The default results list is truncated.  To see full results check the 'Show all results option'. You may need to resize the box to show all results.
Double clicking on a result, displays details about it in the entities tab, e.g. 

![image](https://user-images.githubusercontent.com/6722114/115822767-f040fc00-a3b9-11eb-8f90-5b1cc9a8775f.png)

In the Entities, tab, you can browse related types, opening/closing branches and clicking on terms to see details on the right. In the default layout, annotations on a term are displayed in the top panel and logical assertions in the 'Description' panel at the bottom.

Try to find these specific classes:
- 'congenital heart disease'
- 'Kindler syndrome'
- 'kidney failure'

Note - a cool feature in the search tool in Protege is you can search on partial string matching. For example, if you want to search for ‘down syndrome’, you could search on a partial string: ‘do synd’. 

- Try searching for ‘br car and see what kind of results are returned.
- **Question:** The search will also search on synonyms. Try searching for ‘shingles’ and see what results are returned. Were you able to find the term?

**Note** - if the search is slow, you can uncheck the box ‘Search in annotation values. Try this and search for a term and note if the search is faster. Then search for ‘shingles’ again and note what results you get.

<a name="pr"></a> 
## Use GitHub: make pull requests

### Committing, pushing and making pull requests

1.  Changes made to the ontology can be viewed in GitHub Desktop.

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

<a name="pattern"></a> 
## Ontology design patterns

<a name="template"></a> 
## Use templates: ROBOT, DOSDP

<a name="owl"></a> 
## Basics of OWL