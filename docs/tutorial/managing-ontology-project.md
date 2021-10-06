# Tutorial on Managing OBO Ontology Projects

This tutorial is not about editing ontologies and managing the evolution of its content (aka ontology curation), but the general process of managing an ontology project overall. In this lesson, we will cover the following:

1. How to effectively manage an ontology project using GitHub projects and teams
2. How to coordinate the evolution of ontologies across projects and grants

It is important to understand that the following is just one good way of doing project management for OBO ontologies, and most projects will do it slightly differently. We do however believe that thinking about your project management process and the roles involved will benefit your work in the long term, and hope that the following will help you as a starting point.

## Roles in OBO Ontology project management activities

1. *Ontology Editor* (OE): manage the content of ontologies and interact with users
1. *Principal Ontology Editor* (POE): coordinate the curation activities and have _always_ fixed hours assigned to the project.
1. *Ontology Pipeline Developer* (OPD): Manage the technical workflows around ontologies, such as release workflows, continuous integration and QC, and setting up data pipelines. Also helps with bulk editing activities.
1. *Principal Investigators* (PI): Manage the projects that fund ontology curation activities.

For an effective management of an ontology, the following criteria are recommended:

1. There should be *at least one Principal Ontology Editor* for every ontology project. The importance is not whether this editor (or sometimes called 'ontology curator') has a specific number of hours per week allocated to the project (although based on our experience, 1 day per week is minimum), but whether the editor has a sense of ownership, i.e. they understand that they are the primary responsible person for maintaining the ontology moving forward. Because of potential grant overlapping issues, we recommend to have *at least 1 Principal Ontology Editor* for every grant/funded project that has a stake in the ontology.
2. Every effective ontology needs at least a few hours per week from an Ontology Pipeline Developer (OPD). More on that role later. The OPD does not always have as strong a sense of ownership of the ontology project, but typically has a strong sense of responsibility to members of the curation team.
3. There should be separate meetings for curation and technical activities - both problems are hard, and need different team members being present. We recommend at least monthly technical and biweekly curation calls, but for many of the most effective ontology projects we manage, weekly technical and weekly curation calls are normal.

Without the above minimum criteria, the following recommendations will be very hard to implement.

## The Project Management Toolbox

We make use of three tools in the following recommendation:

*Project boards*: 
Project boards, sometimes referred to as Kanban boards, GitHub boards or agile boards, are a great way to organise outstanding tickets and help maintain a clear overview of what work needs to be done. They are usually realised with either [GitHub projects](https://docs.github.com/en/issues/organizing-your-work-with-project-boards/managing-project-boards/about-project-boards) or [ZenHub](https://blog.zenhub.com/zenhub-vs-github-projects-what-are-the-key-differences/). If you have not worked with project boards before, we highly recommend watching a quick tutorial on Youtube, such as: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/ff5cBkPg-bQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

*GitHub teams*. 
[GitHub teams](https://docs.github.com/en/organizations), alongside with organisations, are a powerfull too to organise collaborative workflows on GitHub. They allow you to communicate and organise permissions for editing your ontology in a transparent way. You can get a sense of GitHub teams by watching one of the the numerous tutorials on GitHub, such as:

<iframe width="560" height="315" src="https://www.youtube.com/embed/SUu6cmcC-3A" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

*Markdown-based documentation system*. 
Writing great documentation is imperative for a sustainable project. Across many of our recent projects, were are using [mkdocs](https://www.mkdocs.org/), which we have also integrated with the Ontology Development Kit, but there are others to consider. We deeply recommend to complete a very short introduction to Markdown, [this tutorial on YouTube](https://www.youtube.com/watch?v=HUBNt18RFbo).

## What do you need for your project?

Every ontology or group of related ontologies (sometimes it is easier to manage multiple ontologies at once, because their scope or technical workflows are quite uniform or they are heavily interrelated) should have:

1. *at least two teams*, an Editorial Team and a Technical Team, with clearly defined members. We recommend to create two teams on GitHub and keep their members always up to date (i.e. remove members that are not actively participating), but many of our projects merely maintain a "core team", which is a more liberal team containing everyone from stakeholders, principal investigators, editors and users (for managing write permissions see later in the "best practice" section) and listing the members of the Editorial and Technical Teams on a page in the documentation ([example](http://obophenotype.github.io/uberon/team/)). Note that it is a good idea to be careful of who on your team has "admin" rights on your repo, so sometimes, a distinct "admin" team can be very helpful. Admins are allowed to do "dangerous" things like deleting the repository.
2. *two distinct project boards*. We recommend two distinct project boards, one for the Curation/Editorial Team, and one for the Technical Team. The details on how to design the boards is up to the respective teams, but we found a simple 4 stage board with sections for `To Do` (issues that are important but not urgent), `Priority` (issues that are important and urgent), `In Progress` (issues that are being worked on) and `Under review` (issues that need review). From years of experience with project boards, we recommend against the common practice of keeping a `Backlog` column (issues that are neither important nor urgent nor likely to be addressed in the next 6 months), nor a `Done` column (to keep track of closed issues) - they just clutter the view.
3. *A documentation system* (often realised using `mkdocs` in OBO projects) with a page listing the members of the team ([example](http://obophenotype.github.io/uberon/team/)). This page should provide links to all related team pages from Github and their project boards, as well as a table listing all current team members with the following information:
    - Name
    - ORCiD
    - Funding Information
    - Allocated FTEs (0 if on volunteering basis)
    - Associated teams
    - Role 
    - Responsibilities (What kind of issues can they be assigned to review? How are they involved in the Project?)

## Responsibilities

1. Effective Ontology Pipeline Developers (OPDs) are extremely rare and are typically active across many different projects. Therefore *their attention is scattered*. Understanding and accepting this is key for the following points.
1. Principal Investigators *explicitly assign target weekly hours* for Ontology Editors and Ontology Pipeline Developers to the project. These should be captured on the documentation systems team page (see above).
1. The Ontology Editors are responsible for the entire Curation Team Board and the `To Do` and `Priority` columns of the Technical Team. The later is important: it is the job of the curation team to _prioritise the technical issues_. The Technical Team can add tickets to the `To Do` and `Priority` columns, but this usually happens only in response to a request from the Curation Team.
1. When the technical team meets, the Principal Ontology Editor(s) (POE) are present, i.e. *the POEs are members of the technical team as well*. They will help clarifying the `Priority` tickets. The Technical Team is responsible to 
    - assign issues and reviewers among themselves (ideally, the reviewer should be decided at the same time the issue is assigned)
    - move issues from the `Priority` to the `In Progress` and later to the `Done` section.
    - communicate through the POE to the PIs when resources are insufficient to address `Priority` issues.
1. The Principal Ontology Editor is responsible for ensuring that new issues on the issue tracker are dealt with. Usually this happens in the following ways:
    - They ensure that each _external_ issue (i.e. an issue from anyone outside the core team) is (a) responded to in a polite manner and (b) assigned to someone appropriate or politely rejected due to lack of resources.
    - They ensure that each _internal_ issue is assigned to the person that made them. No issue should appear unassigned.
    - The ensure that pull requests are (a) assigned to someone to handle and (b) merged in a timely manner. Too many open PRs cause problems with conflicts.

## Best Practices

- The `To Do` issues should first be moved to the `Priority` section before being addressed. This prevents focusing on easy to solve tickets in favour of important ones.
- Even if Google Docs are used to manage team meetings, at the end of each meetings *all open issues must be captured as GitHub tickets* and placed in the appropriate box on the board. We recommend that `Backlog` items are not added at all to the board - if they ever become important, they tend to resurface all by themselves.
- The single most important point of failure is the absence of an Principal Ontology Editor with a *strong sense of ownership*. This should be the projects priority to determine first.
- All new members of the project should undergo an onboarding. It is a good idea to prepare walkthroughs of the project (as video or pages in the documentation system) covering everything from Curation to Technical and Project Management.
- The Principal Ontology Editor responsible for dealing with external issues should be named explicitly on the team page.
- We recommend the following practices for write permissions:
    - The `main` (formerly `master`) branch should be write protected with suitable rules. For example, requiring QC to pass and 1 approving review as a minimum.
    - The curation and technical teams are mainly for social organisation, they do not have to physically exist. However, having a small team with "admin rights" and a team (e.g. the core team mentioned above) with "write" rights greatly helps with organising the permissions in a transparent manner.