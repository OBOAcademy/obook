# Objectives


The objective of this tutorial is to introduce trainees to basic ontology editing in Protege and OWL logic. At the end of this tutorial, trainees should be able to:

-   create tickets in GitHub
-   do basic edits in the Cell Ontology 
-   make pull requests to GitHub


# GitHub workflows


GitHub - distributed version control (Git) + social media for geeks who like to build code/documented collaboratively.

A Git repo consists of a set of branches each with a complete history of all changes ever made to the files and directories. This is true for a local copy you check out to your computer from GitHub or for a copy (fork) you make on GitHub.

![image](https://user-images.githubusercontent.com/6722114/115820759-59267500-a3b6-11eb-8452-b44404ce7aa7.png)

A Git repo typically has a master or main branch that is not directly editing.  Changes are made by creating a branch from Master (complete copy of the Master + its history).  

Branch vs Fork
--------------

You can copy (fork) any GitHub repo to some other location on GitHub without having to ask permission from the owners.  If you modify some files in that repo, e.g. to fix a bug in some code, or a typo in a document, you can then suggest to the owners (via a Pull Request) that they adopt (merge) you your changes back into their repo.

If you have permission from the owners, you can instead make a new branch. For this training, we gave you access to the repository. See the [Appendix](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/appendix.md) for instructions on how to make a fork.

Creating a branch using GitHub Desktop
--------------------------------------

1.  Open GitHub Desktop
1.  Clone the repository:

![image](https://user-images.githubusercontent.com/6722114/115820985-c3d7b080-a3b6-11eb-8131-7b9c33cc294d.png)

1. Go to <https://github.com/monarch-initiative/mondo>
1. Click 'Code', then Open with GitHub desktop
1. Click the little arrow in Current Branch
1. Click New Branch
1. Give your branch a name: c-path-training-initials (ie `c-path-training-NV`)

![image](https://user-images.githubusercontent.com/6722114/115821352-7ad42c00-a3b7-11eb-97e0-b02611eb77e6.png)

Browsing and Searching Mondo
============================

Open the Mondo in Protégé
-------------------------

1.  Navigate to where you downloaded the repository and open the mondo-edit.obo file (src/ontology/mondo-edit.obo)
2.  When you open Protege, you will be on the Active Ontology tab
3.  Note the Ontology IRI field. The IRI is used to identify the ontology on the Web.

![image](https://user-images.githubusercontent.com/6722114/115821407-9b03eb00-a3b7-11eb-8dd2-7eb0eb9593eb.png)

The Protégé UI
--------------

The Protégé interface follows a basic paradigm of Tabs and Panels. By default, Protégé launches with the main tabs seen below. The layout of tabs and panels is configurable by the user. The Tab list will have slight differences from version to version, and depending on your configuration. It will also reflect your customizations.

To customize your view, go to the Window tab on the toolbar and select Views. Here you can customize which panels you see in each tab. In the tabs view, you can select which tabs you will see. You will commonly want to see the Entities tab, which has the Classes tab and the Object Properties tab.

![image](https://user-images.githubusercontent.com/6722114/115821442-a9520700-a3b7-11eb-9710-cc85471f133b.png)

Note: if you open a new ontology while viewing your current ontology, Protégé will ask you if you'd like to open it in a new window.  **_For most normal usage you should answer no._** This will open in a new window.

The panel in the center is the ontology annotations panel. This panel contains basic metadata about the ontology, such as the authors, a short description and license information.

![image](https://user-images.githubusercontent.com/6722114/115821747-34cb9800-a3b8-11eb-9ec4-302ed3fcd222.png)
