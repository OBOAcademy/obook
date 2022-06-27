Create a Pull Request in GitHub
===============================

Overview
---------
### GitHub workflows

A Git repo consists of a set of branches each with a complete history of all changes ever made to the files and directories. This is true for a local copy you check out to your computer from GitHub or for a copy (fork) you make on GitHub.

![image](https://user-images.githubusercontent.com/6722114/115820759-59267500-a3b6-11eb-8452-b44404ce7aa7.png)

A Git repo typically has a master or main branch that is not directly edited. Changes are made by creating a branch from Master (complete copy of the Master + its history) (either a direct branch or via a fork).  

### Branch vs Fork

You can copy (fork) any GitHub repo to some other location on GitHub without having to ask permission from the owners.  If you modify some files in that repo, e.g. to fix a bug in some code, or a typo in a document, you can then suggest to the owners (via a Pull Request) that they adopt (merge) you your changes back into their repo. See the [Appendix](../howto/github-create-fork.md) for instructions on how to make a fork.

If you have permission from the owners, you can instead make a new branch. 

### What is a Pull Request?

A Pull Request (PR) is an event in Git where a contributor (you!) asks a maintainer of a Git repository to review changes (e.g. edits to an ontology file) they want to merge into a project (e.g. the owl file) (see [reference](https://www.gitkraken.com/learn/git/tutorials/what-is-a-pull-request-in-git)). Create a pull request to propose and collaborate on changes to a repository. These changes are proposed in a branch, which ensures that the default branch only contains finished and approved work. See more details [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

Committing, pushing and making pull requests
--------------------------------------------
1. See these [instructions](https://oboacademy.github.io/obook/lesson/contributing-to-obo-ontologies/#basics-of-ontology-development-workflows) on cloning an ontology repo and creating a branch using GitHub Dekstop.

1.  Review: Once changes are made to the ontology file, they can be viewed in GitHub Desktop.

1.  Before committing, check the diff. An example diff from the Cell Ontology (CL) is pasted below. Large diffs are a sign that something went wrong. In this case, do not commit the changes and consider asking the ontology editor team for help instead.

Example 1 (Cell Ontology):

![](https://lh4.googleusercontent.com/dBtjnSflSSf85x1wO8lNFhqbjy4hx-ubSQe7UuGl7AimU5JqIWxez0TZIffqoI0j0Uey-ucWMJSp8EEu6AfGE5XOsGsh07K1H2gBzmbY1xoNFXlTfxoO13yC7zczajOZjPuDroEv)

Example 2 (Mondo):

<img width="1489" alt="image" src="https://user-images.githubusercontent.com/6722114/174409050-45209f25-c1f5-4f41-a369-64a7a82d27e5.png">


1. Commit message: Before Committing, you must add a commit message. In GitHub Desktop in the Commit field in the lower left, there is a subject line and a description. 

1. Give a very descriptive title: Add a descriptive title in the subject line. For example: add new class ONTOLOGY:ID [term name] (e.g. add new class MONDO:0000006 heart disease)

1. Write a great summary of what the change is in the Description box, referring to the issue. The sentence should clearly state how the issue is addressed.

1. To link the issue, you can use the word 'fixes' or 'closes' in the description of the commit message, followed by the corresponding ticket number (in the format #1234) - these are magic words in GitHub; when used in combination with the ticket number, it will automatically close the ticket. Learn more on this GitHub Help Documentation page about [Closing issues via commit messages](https://help.github.com/en/articles/closing-issues-using-keywords).

1.  Note: 'Fixes' and "Closes' are case-insensitive.

2.  If you don't want to close the ticket, just refer to the ticket # without the word 'Fixes' or use 'Addresses'. The commit will be associated with the correct ticket but the ticket will remain open. 7.NOTE: It is also possible to type a longer message than allowed when using the '-m' argument; to do this, skip the -m, and a vi window (on mac) will open in which an unlimited description may be typed.

<img width="304" alt="image" src="https://user-images.githubusercontent.com/6722114/174409098-1cdcd424-39d9-4e92-96d2-25aa80a12f26.png">

1.  Click Commit to [branch]. This will save the changes to the ontology edit file. 

2.  Push: To incorporate the changes into the remote repository, click Publish branch.

Make a Pull Request
-------------------

1.  Click: Create Pull Request in GitHub Desktop

2.  This will automatically open GitHub Desktop 

3.  Click the green button 'Create pull request'

4.  You may now add comments to your pull request. 

5.  The CL editors team will review your PR and either ask for changes or merge it.

6.  The changes will be available in the next release.
