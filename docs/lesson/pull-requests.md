# Pull Requests

## Prerequisites
Participants will need to have access to the following resources and tools prior to the training:  
- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)  
- **Protege** - Install Protege 5.5, download it [here](https://protege.stanford.edu/)  
- **Install GitHub Desktop** Please make sure you have some kind of git client installed on your machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)  

## Preparation
- Review tutorial on [Contributing to Ontologies](contributing-to-obo-ontologies.md)

## What is delivered as part of the course

**Description:** How to create and manage pull requests to ontology files in GitHub.

### Learning objectives

- [How to create a really good pull request](#good-pr)
- [How to find a reviewer for your pull request in an open source environment](#reviewer)
- [How to review a pull request](#review)
- [How to change a pull request in response to review](#change)
- [How to update from master](#update)
- [Resolve conflicts on branch](#conflict)


## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)

## General tips
- Commit early, commit often
- Write detailed commit messages

<a name="good-pr"></a> 
## How to create a really good pull request

<a name="reviewer"></a> 
## How to find a reviewer for your pull request in an open source environment

<a name="review"></a> 
## How to review a pull request

<a name="change"></a> 
## How to change a pull request in response to review

<a name="update"></a> 
## How to update from master

<a name="conflict"></a> 
## Resolve conflicts on branch

Conflicts arise when edits are made on two separate branches to the same line in a file. ([reference](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts#:~:text=A%20conflict%20arises%20when%20two,to%20help%20resolve%20merge%20conflicts)). When editing an ontology file (owl file or obo file), conflicts often arise when adding new terms to an ontology file on separate branches, or when there are a lot of open pull requests.

Conflicts in ontology files can be fixed either on the command line or using GitHub Desktop. In this lesson, we describe how to fix conflicts using GitHub Desktop.

### Fix conflicts in GitHub desktop
1. In GitHub Desktop, go to your master/main branch and fetch pull. 
2. Go to branch with conflict. 
3. Pull branch. 
4. Branch -> update from master. 
5. Open in Sublime or Atom. 
6. Make changes in file (open the ontology file in a text editor (like Sublime) and search for the conflicts. These are usually preceded by <<<<<. Fix the conflicts, then save). 
7. In GitHub Desktop, continue merge. 
8. Push. 
9. In terminal: `open [ontology file name]` (e.g.`open mondo-edit.obo`) or open in Protege manually. 
10. Save as (nothing should have changed in the diff). 
11. Check the diff in GitHub online. 

Some examples of conflicts that Nicole fixed in Mondo are below:  

![Example1](images/lessons/FixGitHubConflicts/Slide1.jpeg)
![Example2](images/lessons/FixGitHubConflicts/Slide2.jpeg)
![Example3](images/lessons/FixGitHubConflictss/Slide3.jpeg)
![Example4](images/lessons/FixGitHubConflicts/Slide4.jpeg)

## Further regarding 

### Gene Ontology Daily Workflow
[Gene Ontology Editing Guide](https://go-ontology.readthedocs.io/en/latest/DailyWorkflow.html)

### GitHub Merge Conflicts
- [Resolving a merge conflict on GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-on-github)
- [Git merge conflicts
](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)

