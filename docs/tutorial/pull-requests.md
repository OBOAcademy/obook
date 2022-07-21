# Pull Requests

## Prerequisites
Participants will need to have access to the following resources and tools prior to the training:  
- **GitHub account** - register for a free GitHub account [here](https://github.com/join?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)   
- **Install GitHub Desktop** Please make sure you have some kind of git client installed on your machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)  
- **Protege** - Install Protege 5.5, download it [here](https://protege.stanford.edu/)   

## Preparation (_optional_)
- Review tutorial on [Contributing to Ontologies](contributing-to-obo-ontologies.md)
- See ['How to' guide on Pull Requests](howto/github-create-pull-request.md)

## What is delivered as part of the course

**Description:** How to create and manage pull requests to ontology files in GitHub.

### Learning objectives

- [How to create a really good pull request](#good-pr)
- [GitHub Pull Request Workflow](#workflow)
- [How to find a reviewer for your pull request in an open source environment](#reviewer)
- [How to review a pull request](#review)
- [How to change a pull request in response to review](#change)
- [How to update from master](#update)
- [Resolve conflicts on branch](#conflict)

### Further Reading
[Available below](#reading)

## Contributors
- [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)
- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)

<a name="good-pr"></a> 
# How to create a really good pull request

### What is a Pull Request?

A Pull Request (PR) is an event in Git where a contributor (you!) asks a maintainer of a Git repository to review changes (e.g. edits to an ontology file) they want to merge into a project (e.g. the owl file) (see [reference](https://www.gitkraken.com/learn/git/tutorials/what-is-a-pull-request-in-git)). A contributor creates a pull request to propose and collaborate on changes to a repository. These changes are proposed in a branch, which ensures that the default branch only contains finished and approved work. See more details [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

### How to write a great descriptive title

When committing a pull request, you must include a title and a description (more details in the [workflow](#workflow) below.) Tips below (adapted from [Hugo Dias](https://hugooodias.medium.com/the-anatomy-of-a-perfect-pull-request-567382bb6067)):

- The title of the PR should be self-explanatory

- **_Do_**: Describe what was changed in the pull request 
  - _Example:_ Add new term: MONDO:0100503 DPH5-related diphthamide-deficiency syndrome`

- **_Don't_**: write a vague title that has very little meaning. 
  - Example: Add new term

- **Don't**: use the branch name in the Pull Request (sometimes GitHub will offer this as a default name)
  - Example: issue-5024

### What kind of information to include in the description

- Describe **what** was changed in the pull request
- Explain **why** this PR exists
- Make it clear how it does what it sets out to do. E.g., Does it edit the ontology-edit.owl file? Does it edit another file(s)?
- What was your motivation for the chosen solution?
- Use screenshots to demonstrate what has changed

_Example_: 

<img width="819" alt="image" src="https://user-images.githubusercontent.com/6722114/180045920-41fb3bcf-7eea-4f3e-ab06-bc1c300796a1.png">

### General tips
- **Do**:
    - Follow the _Single Responsibility Principle_: The pull request should do only one thing.
        - _Note_: sometimes a small edit can change a lot of code, for example, if you want to change all of the created_by annotations to dc:creator. That's okay.
    - The pull request should be atomic: it should be small and self contained with simple changes that affect a little code a possible
    - Whenever possible, break pull-requests into smaller ones  
    - Commit early, commit often
- **Don't**:
    - Make additional changes on a single PR that goes beyond the scope of the ticket or PR. For example, if you are adding a new term, don't also fix definitions or formatting for other terms.

<a name="workflow"></a> 
# GitHub Pull Request Workflow

## Update the local copy of the ontology

1. In GitHub Desktop, navigate to your local ontology directory of your ontology
2. Make sure you are on the master/main branch and click Pull origin (or Fetch origin) 

<img width="434" alt="image" src="https://user-images.githubusercontent.com/6722114/179310654-bd87fcf8-9855-4769-b309-9413b03434e7.png">


## Create a New Working Branch

1. When starting to work on a ticket or making edits to an ontology, you should create a new branch of the repository to edit the ontology file.
2. Make sure you are on the master branch before creating a new branch. **_Please do not create a new branch off of an existing branch (unless the situation explicitly calls for it)._** 
3. To create a new branch, click on Current Branch and select New Branch 

<img width="383" alt="image" src="https://user-images.githubusercontent.com/6722114/179310850-65c6b211-9190-44e5-8032-e4ab34a68c21.png">

4. Name your branch. Some recommended best practices for branch name are to name the branch after the issue number, for example issue-206. If you are not addressing a ticket per se, you could name the branch: 'initals-edits-date', e.g. nv-edits_2022-07-12, or give it a name specific to what you are doing, e.g. fix-typos-2022-07-12.

<img width="392" alt="image" src="https://user-images.githubusercontent.com/6722114/178575718-4ff6f7d2-4ae9-454d-bdd8-49b3ad63484a.png">

## Continuing work on an existing Working Branch

1. If you are continuing to do work on an existing branch, in addition to updating master, go to your branch by selecting Current Branch in GitHub Desktop and either search for or browse for the branch name. 

A video is  [here](https://drive.google.com/file/d/1q0Fdj1OjzIKwGrmCRYyI2z8_xzO_4uU8/view?usp=sharing)).

2. **OPTIONAL:** To update the working branch with respect to the current version of the ontology, select Branch from the top menu, Update from master. This step is optional because it is not necessary to work on the current version of the ontology; all changes will be synchronized when git merge is performed.

## Editing an ontology on a branch

1. Create a new branch, open Protege. Protege will display your branch name in the lower left corner (or it will show Git: **master**)

<img width="131" alt="image" src="https://user-images.githubusercontent.com/6722114/178575944-8fead930-409e-4cc6-9907-1fac10ee308c.png">

2. Make necessary edits in Protege. 

## Committing, pushing and making pull requests

1. Review: GitHub Desktop will display the diff or changes made to the ontology. 
2. Before committing, view the diff and ensure the changes were intended. Examples of a diff are pasted below. Large diffs are a sign that something went wrong. In this case, do not commit the changes and ask for help instead or consider discarding your changes and starting the edits again. To discard changes, right click on the changed file name and select Discard changes.

<img width="506" alt="image" src="https://user-images.githubusercontent.com/6722114/179311118-b998f0e7-3271-4736-a308-48f024be5f34.png">

**Example diffs:**

Example 1 (Cell Ontology):

![](https://lh4.googleusercontent.com/dBtjnSflSSf85x1wO8lNFhqbjy4hx-ubSQe7UuGl7AimU5JqIWxez0TZIffqoI0j0Uey-ucWMJSp8EEu6AfGE5XOsGsh07K1H2gBzmbY1xoNFXlTfxoO13yC7zczajOZjPuDroEv)

Example 2 (Mondo):

<img width="1489" alt="image" src="https://user-images.githubusercontent.com/6722114/174409050-45209f25-c1f5-4f41-a369-64a7a82d27e5.png"> 

### Write a good commit messages

3. Commit message: Before Committing, you must add a commit message. In GitHub Desktop in the Commit field in the lower left, there is a subject line and a description. 

4. Give a very descriptive title: Add a descriptive title in the subject line. For example: add new class ONTOLOGY:ID [term name] (e.g. add new class MONDO:0000006 heart disease)

5. Write a detailed summary of what the change is in the Description box, referring to the issue. The sentence should clearly state how the issue is addressed.

6. **NOTE**: You can use the word ‘fixes’ or ‘closes’ in the commit message - these are magic words in GitHub; when used in combination with the ticket number, it will automatically close the ticket. Learn more on this GitHub Help Documentation page about [Closing issues via commit messages](https://help.github.com/en/articles/closing-issues-using-keywords).

7. ‘Fixes’ and “Closes’ is case-insensitive and can be plural or singular (fixes, closes, fix, close).

<img width="306" alt="image" src="https://user-images.githubusercontent.com/6722114/178576147-7ee2c455-a6da-4e73-a2d3-897af8b78a15.png">


8. If you don’t want to close the ticket, just refer to the ticket # without the word ‘fixes’ or use ‘adresses’ or 'addresses'. The commit will be associated with the correct ticket but the ticket will remain open.

9. **Push**: To incorporate the changes into the remote repository, click Commit to [branch name], then click Push.

## Make a Pull Request (PR)

1. You can either make a Pull Request (PR) directly from GitHub Desktop, or via the GitHub web browser.
1. To make a PR from GitHub Desktop, click the button 'Create Pull Request'. You will be directed to your web browser and GitHub repo.
1. Click Create Pull Request.

<img width="617" alt="image" src="https://user-images.githubusercontent.com/6722114/179312344-fda913a9-f2fd-4e04-bfb2-c8b424fddeba.png">

1. If your PR is a work-in-progress and not ready for review, you can save it as a draft PR and convert it to a PR when it is ready for review.

<img width="343" alt="image" src="https://user-images.githubusercontent.com/6722114/179314287-e4474c60-f905-493a-90e9-9bd1af13f227.png">

1. If you do not create a PR directly from GitHub Dekstop, you can go to your GitHub repo and you will see a yellow banner on top that notifies you of a pending PR.
1. Navigate to the tab labeled as ‘Code’. You should see your commit listed at the top of the page in a light yellow box. If you don’t see it, click on the ‘Branches’ link to reveal it in the list, and click on it.  

<img width="1241" alt="image" src="https://user-images.githubusercontent.com/6722114/179314202-a1d1e229-decd-4033-ad46-9f504cbbc2d0.png">

1. Click the green button ‘Compare & pull request’ on the right.
1. You may now add comments, if applicable and request a reviewer. See section below on reviewers.
1. You can see the diff for your file by clicking 'Files Changed'. Examine it as a sanity check.
1. Go back to the Conversation tab.
1. Click on the green box ‘Pull request’ to generate a pull request.

<a name="reviewer"></a> 
## How to find a reviewer for your pull request in an open source environment

1. Depending on the level of your permissions for the repository, you may or may not be able to assign a reviewer yourself.
1. If you have write access to the repository, you can assign a reviewer.
1. Otherwise, you can tag people in the description of your Pull Request.
1. Tips for finding reviewers:
  - An ontology repository should have an owner assigned. This may be described in the ReadMe file or on the [OBO Foundry website](). For example, the contact person for [Mondo](https://obofoundry.org/ontology/mondo.html) is Nicole Vasilevsky.
  - The primary owner can likely review your PR or triage your request to the appropriate person.
  - If you are addressing a specific ticket, you may want to assign the person who created the ticket to review.

<a name="review"></a> 
## How to review a pull request (PR)

If you are assigned to review a pull request, you should receive an email notification. You can also check for PRs assigned to you by going to [https://github.com/pulls/assigned](https://github.com/pulls/assigned).

### What kind of person do we need for what kind of pull request?

It depends on what the pull request is addressing. Remember the QC checks will check for things like unsatisfiable classes and many other checks (that vary between ontologies). Your job as a reviewer is to check for things that the QC checks won't pick up.

- If it is content changes, like adding new terms, or reclassifying a term, an ontology curator could review your PR. 
- If the PR is addressing quality control or technical aspects, one of the ontology semantic engineers would probably be a good fit. 
- If you don't know who to assign, we recommend assigning the ontology contact person and they can triage the request. 

1. To review a PR, you should view the 'Files changed' and view the diff(s). You can review changes in a pull request one file at a time.
1. While reviewing the files in a pull request, you can leave individual comments on specific changes.

_Example_:
<img width="1003" alt="image" src="https://user-images.githubusercontent.com/6722114/180077713-85c2da65-913a-4043-a7ff-a42e1ad48caa.png">

### Things to look out for when reviewing a PR:

1. Make sure the changes made address the ticket. In the example above, Sabrina addressed a ticket that requested adding a new term to Mondo, which is what she did on the PR (see https://github.com/monarch-initiative/mondo/pull/5078).
- Examples of things to look for in content changes (like adding new terms or revising existing terms):
  - Poorly written definitions
  - Missing or misformatted database cross-references
  - Incorrectly scoped synonyms
  - appropriate annotations
1. Make sure there are not any unintended or unwanted changes on the PR. 

### Adding your review

1. After you finish reviewing each file, you can mark the file as viewed. This collapses the file, helping you identify the files you still need to review.
1. A progress bar in the pull request header shows the number of files you've viewed.
1. You can leave comments and requests for changes on the PR inline for on the PR when viewing the 'Files changed'.
1. You can add a single comment, or start a review if you have multiple comments. 
1. After reviewing the file(s), you can approve the pull request or request additional changes by submitting your review with a summary comment. 
- Comment (Submit general feedback without explicit approval)
- Approve (Submit feedback and approve merging these changes)
- Request changes (Submit feedback that must be addressed before merging)
1. In addition or instead of adding inline comments, you can leave comments on the Conversation page. The conversation page is a good place to discuss the PR, and for the original creator to respond to the reviewer comments.  

### When are you done with your review?

If you review the PR and the changes properly address what was described in the description, then it should be sufficient. Not every PR needs comments, it can be approved without any comments or requests for changes. Feel free to ask for help with your review, and/or assign additional reviewers.

Some of the content above was adapted from [GitHub Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-proposed-changes-in-a-pull-request).

<a name="change"></a> 
## How to change a pull request in response to review

1. Check out your branch in GitHub Desktop and open the file in Protege.
1. Make the suggested changes.
1. Check the diff.
1. Commit your changes on your branch.
1. Note, you do not need to create another PR, your commits will show up on the same PR.
1. Resolve the comments on the PR. 
1. Notify the reviewer that your PR is ready for re-review.

<a name="update"></a> 
## How to update from master

1. In GitHub Desktop, navigate to your branch.
1. In the top file menu, select Branch -> Update from master.

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

Watch a [video example](https://drive.google.com/file/d/1DqYiXEdkLCVji55FmFlA9sPmfLouEqrj/view?usp=sharing) of fixing a conflict in the Mondo ontology file.

Some examples of conflicts that Nicole fixed in Mondo are below:  

<img width="1025" alt="image" src="https://user-images.githubusercontent.com/6722114/179615230-e6a21d27-ce42-41d0-840d-8abd80ccd866.png">
<img width="1043" alt="image" src="https://user-images.githubusercontent.com/6722114/179615278-c4565bcc-7267-4045-a734-4803bb20235f.png">
<img width="1046" alt="image" src="https://user-images.githubusercontent.com/6722114/179615326-b2e7326b-68aa-4fd5-a667-f96cb4d6403e.png">
<img width="955" alt="image" src="https://user-images.githubusercontent.com/6722114/179615360-b2bc96ea-d3cc-4a6c-acde-a0900040e318.png">


<a name="reading"></a> 
## Further regarding 

### Gene Ontology Daily Workflow

[Gene Ontology Editing Guide](https://go-ontology.readthedocs.io/en/latest/DailyWorkflow.html)

### GitHub Merge Conflicts

- [Resolving a merge conflict on GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-on-github)
- [Git merge conflicts
](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)

### The anatomy of a perfect pull request

[Blog post by Hugo Dias](https://hugooodias.medium.com/the-anatomy-of-a-perfect-pull-request-567382bb6067)
