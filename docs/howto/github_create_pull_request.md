Create a pull request in GitHub
===============================

Committing, pushing and making pull requests
--------------------------------------------

1.  Review: Changes made to the ontology can be viewed in GitHub Desktop.

2.  Before committing, check the diff. Examples of a diff are pasted below. Large diffs are a sign that something went wrong. In this case, do not commit the changes and ask the CL editors team for help instead.

Example 1:

![](https://lh4.googleusercontent.com/dBtjnSflSSf85x1wO8lNFhqbjy4hx-ubSQe7UuGl7AimU5JqIWxez0TZIffqoI0j0Uey-ucWMJSp8EEu6AfGE5XOsGsh07K1H2gBzmbY1xoNFXlTfxoO13yC7zczajOZjPuDroEv)

1.  Commit: Add a meaningful message in the Commit field in the lower left, for example: add new class MONDO:ID episodic angioedema with eosinophilia

NOTE: You can use the word 'fixes' or 'closes' in the description of the commit message, followed by the corresponding ticket number (in the format #1234) - these are magic words in GitHub; when used in combination with the ticket number, it will automatically close the ticket. Learn more on this GitHub Help Documentation page about [Closing issues via commit messages](https://help.github.com/en/articles/closing-issues-using-keywords).

1.  Note: 'Fixes' and "Closes' are case-insensitive.

2.  If you don't want to close the ticket, just refer to the ticket # without the word 'Fixes' or use 'Adresses'. The commit will be associated with the correct ticket but the ticket will remain open. 7.NOTE: It is also possible to type a longer message than allowed when using the '-m' argument; to do this, skip the -m, and a vi window (on mac) will open in which an unlimited description may be typed.

1.  Click Commit to [branch]. This will save the changes to the cl-edit.owl file. 

2.  Push: To incorporate the changes into the remote repository, click Publish branch.

Make a Pull Request
-------------------

1.  Click: Create Pull Request in GitHub Desktop

2.  This will automatically open GitHub Desktop 

3.  Click the green button 'Create pull request'

4.  You may now add comments to your pull request. 

5.  The CL editors team will review your PR and either ask for changes or merge it.

6.  The changes will be available in the next release.