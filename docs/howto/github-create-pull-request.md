Create a Pull Request in GitHub
===============================

Committing, pushing and making pull requests
--------------------------------------------

1.  Review: Changes made to the ontology can be viewed in GitHub Desktop.

2.  Before committing, check the diff. An example diff from the Cell Ontology (CL) is pasted below. Large diffs are a sign that something went wrong. In this case, do not commit the changes and consider asking the ontology editor team for help instead.

Example 1 (Cell Ontology):

![](https://lh4.googleusercontent.com/dBtjnSflSSf85x1wO8lNFhqbjy4hx-ubSQe7UuGl7AimU5JqIWxez0TZIffqoI0j0Uey-ucWMJSp8EEu6AfGE5XOsGsh07K1H2gBzmbY1xoNFXlTfxoO13yC7zczajOZjPuDroEv)

1. Commit message: Before Committing, you must add a commit message. In GitHub Desktop in the Commit field in the lower left, there is a subject line and a description. 

1. Give a very descriptive title: Add a descriptive title in the subject line. For example: add new class ONTOLOGY:ID [term name] (e.g. add new class MONDO:0000006 heart disease)

1. Write a great summary of what the change is in the Description box, referring to the issue. The sentence should clearly state how the issue is addressed.

1. To link the issue, you can use the word 'fixes' or 'closes' in the description of the commit message, followed by the corresponding ticket number (in the format #1234) - these are magic words in GitHub; when used in combination with the ticket number, it will automatically close the ticket. Learn more on this GitHub Help Documentation page about [Closing issues via commit messages](https://help.github.com/en/articles/closing-issues-using-keywords).

1.  Note: 'Fixes' and "Closes' are case-insensitive.

2.  If you don't want to close the ticket, just refer to the ticket # without the word 'Fixes' or use 'Addresses'. The commit will be associated with the correct ticket but the ticket will remain open. 7.NOTE: It is also possible to type a longer message than allowed when using the '-m' argument; to do this, skip the -m, and a vi window (on mac) will open in which an unlimited description may be typed.

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