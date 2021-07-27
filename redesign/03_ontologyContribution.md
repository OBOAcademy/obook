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

![createbranch](https://user-images.githubusercontent.com/6722114/127195758-3ade012a-5788-49b5-850f-32edfe4c9b92.png)
![name-branch](https://user-images.githubusercontent.com/6722114/127195892-b099bbfe-2a1e-4ff3-b4f8-b1487417d738.png)

#### Open the Ontology edit file in Protege

1. Open Protege
2. Go to: File -> Open
3. Navigate to [ontology-name]/src/ontology/[ontology-name]-edit.obo and open this file in Protege. For example: mondo/src/ontology/mondo-edit.obo 
4. _Note: all ontologies that use the [Ontology Development Kit (ODK)](https://github.com/INCATools/ontology-development-kit) will have the 'edit' files stored in the same folder path: src/ontology/[ontology-name]-edit.owl (or [ontology-name]-edit.obo)_

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
