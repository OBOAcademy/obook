## Intro to managing and tracking issues in GitHub


### [Overview](#overview)
- [How to create issues](#create-issues)
- [How to assign issues](#assign-issues)
- [How to communicate about issues](#communicate-about-issues)
- [How to organize issues](#organize-issues)
- [How to query issues](#query-issues)
- [How to close issues](#close-issues)
- [How to assign teams](#teams)
- [Where to go when you need help](#help)
- [Miscellany that is good to know](#miscellany)

### Create issues
[Back to top](#overview)

**Why:**
"Issues are a great way to keep track of **tasks**, **enhancements**, and **bugs** for your projects or for anyone else's. As long as you are a registered GitHub user you can log an issue, or comment on an issue for any open repo on GitHub. Issues are a bit like email—except they can be shared, intelligently organized, and discussed with the rest of your team. GitHub’s tracker is called Issues, and has its own section in every repository." (From: https://guides.github.com/features/issues/)

**How:**

How to create an issue in GitHub:

- We will practice creating tickets in this repository [https://github.com/nicolevasilevsky/c-path-practice/issues](https://github.com/nicolevasilevsky/c-path-practice/issues)
- Click "issues"
- Click "New Issue" (note the word 'issue' and 'ticket' are frequently used interchangeably)
- Write an informative title
- Write a detailed explanation of your issue
- In the case of reporting software bugs, provide some context in which the issue was encountered (e.g. bug detected when using Google Chrome on a Mac OS)
- If you know the sub-tasks that are involved, list these using `- [ ] ` markdown syntax before each bullet. Note, you can also add sub-tasks by clicking the 'add a task list' button in the tool bar. The status of the tasks in an issue (eg. [https://github.com/nicolevasilevsky/c-path-practice/issues/1](https://github.com/nicolevasilevsky/c-path-practice/issues/1) will then be reflected in any summary view. Eg. [https://github.com/nicolevasilevsky/c-path-practice/issues](https://github.com/nicolevasilevsky/c-path-practice/issues).
- Click Submit new issue
- Edit the issue (if needed) (Note that post-hoc edits will not propagate to email notifications).

**Your turn:**

Follow the instructions above to create a ticket about a hypothetical issue (such as an improvement to this tutorial) that includes a sub-task list.

### Assign issues
[Back to top](#overview)

**Assign issues to people**

- On the top right hand side, click "Assignees"
- You can assign issues to yourself or other people who are part of the repository
- In the box, start typing type their name or GitHub handle
- It is possible to assign up to 9 handles at once (assignment to a team is currently not supported)
- Best practice is to assign only the people that are on the critical path at any given time; once that person has completed their portion of the issue, it can be reassigned to the next person who is on the critical path.
- Best practice is that any given ticket that is part of a milestone should be assigned to someone
- No milestone should be without corresponding issues.

**Add labels**

- On the top right hand side, click "Labels"
- Assign a relevant label to your ticket
- Note, by default, every GitHub repo comes with some standard labels
- You can also create new labels that are specific to your project

**New Labels**

 - On GitHub, navigate to the main page of the repository Issues and pull requests tab selection
 - Under your repository name, click  Issues (or  Pull requests)
 - Click Labels button next to the search field
 - Click New Label to create a new label, or click Edit to edit an existing one.
 - In the text box, type your new label name.
 - Select a color for the label from the color bar. You can customize this color by editing the hexadecimal number above the color bar. For a list of hexadecimal numbers see [HTML color codes](http://htmlcolorcodes.com/)
 - Click Create Label to save the new label.

**Your turn:**

On the ticket you previously created:

- Assign the ticket to someone
- Add a label for an enhancement
- Create a new label and add it to the ticket

### Communicate about issues
[Back to top](#overview)

**Comment on issues**

- Click on an issue in the issue tracker in the [https://github.com/nicolevasilevsky/c-path-practice/issues](https://github.com/nicolevasilevsky/c-path-practice/issues) repo
- Scroll to the bottom of the issue, and add content in the "Leave a comment" field
- Use the top tool bar to format your text, add **bold**, *italic*, lists etc.
- Preview your text to see how your formatting looks
- Click Comment. 

**Close issues**
- If an issue has been addressed, click Close Issue. Best practice is to point to the work (whether code, documentation, etc) that has been done to close it.
- Only close the ticket if the issue has been resolved, usually someone will write a comment describing the action they did to close the issue and click Close Issue. 
- The issue will no longer be dispalyed in the list of open issue, but will be archived.
- Some issues have a long half life without being addressed. It is best practice to have some way of designated these issues as having been triaged and determined not to be a priority. This can either be achieved with the use of a label or milestone (eg: 'parked' or 'parking lot').
- When making a change to code or documentation in GitHub, it is possible to automatically couple a change to an issue and close it. Just use 'fixes' or 'closes' followed by the issue number.

**Use direct @ mentions**

- You can mention someone in a issue without assigning it to them
- In the comments section, type @github handle. For example, to mention Nicole, you would type @nicolevasilevsky. You can either start typing their name or GitHub handle and GitHub will autosuggest their handle.

**Link documents**

You can link documents and files by:

- copy and pasting URL
- you can attach files by dragging and dropping.
- You can link one issue to another in the same repo by typing '#' followed by the title of the ticket
- This approach also works across repos but you need to use the full URL (no autocomplete available). Doing this will also cause the referent issue to display that it has been referenced.

**Cross reference to another ticket**

- If your ticket is a duplicate or related to another ticket, you can cross reference another ticket
- Type # and you will see a list of other tickets in that repo
- Type #TicketNumber and that will link to the other ticket. For example [#1](https://github.com/nicolevasilevsky/c-path-practice/issues/1) will link to [this ticket](https://github.com/nicolevasilevsky/c-path-practice/issues/1)

**_Before saving your changes, you can preview the comment to ensure the correct formatting._**

**Your turn:**

- Follow the instructions above to comment on a ticket that someone created.
- Mention Nicole
- Attach a picture of a cat (such as a picture you copy from the internet, or attach a picture you have saved on your computer)
- Include a comment that says, 'related to #1' and link to ticket [#1](https://github.com/nicolevasilevsky/c-path-practice/issues/1)

### Organize issues
[Back to top](#overview)

**Milestones**

- To create a milestone, navigate to the issues page in your repository
- Next to the search field, click **Milestones**
- Click **New Milestone** to create a new milestone, click **Edit** to edit an existing one
- Create a milestone that is broad enough to be meaningful, but specific enough to be actionable.
- Set a due date for the milestone (note that specific tasks can not be formally assigned due dates, though you can mention a desired due date in the narrative text of a ticket.
- Each ticket can only be associated to ONE milestone, however it can have as many labels as appropriate.
- A given issue can be part of multiple "project" boards (see below)

**Your turn**

Create a new milestone, and add the milestone to an existing ticket.

**Projects**

- Projects is a lot like Trello, it uses cards on a list that you can name and organize as you see fit.
- You can create as many projects within a repository as you like

To create project:

- Click on Projects
- Click New Project
- Name the project
- Write a description of the project
- Create columns and give them names
- Add 'cards' to the columns

**Your turn**

Create a new project and add columns and add cards to the columns.

### Query issues
[Back to top](#overview)

Once you start using GitHub for lots of things it is easy to get overwhelmed by the number of issues. I find the query dashboard, [https://github.com/issues](https://github.com/issues), much more relevant to me than the notification page. [https://github.com/notifications](https://github.com/notifications).
- All issues assigned to me: [https://github.com/issues/assigned](https://github.com/issues/assigned)
- All issues on which I am @ mentioned: [https://github.com/issues/mentioned](https://github.com/issues/mentioned)

More complex queries are also possible.

- All issues either assigned to me OR on which I have commented OR am mentioned: [https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+involves%3Anicolevasilevsky+](https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+involves%3Ajmcmurry+)
- All issues in all repos within an organization: [https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+org%3Ajamesaoverton](https://github.com/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+org%3Ajamesaoverton)

Further reading on [Issue querys](https://help.github.com/articles/searching-issues/)

#### Configure emails for mentions

You can set rules in your email to filter for emails that mention you, ie @username.

### Help
[Back to top](#overview)

If you have an issue with GitHub itself (bug, feature request, etc) where do you go? Ironically, there is no good place. If you want to look up things that others have reported, isaacs has a good resource. [https://github.com/isaacs/github/issues/](https://github.com/isaacs/github/issues/). However, this is a rogue repo and a bit contentious.

- You may find the answers you seek in  [StackOverflow](http://stackoverflow.com/questions/tagged/github), although it is primarily geared towards programmers.
- GitHub kind of monitors [https://github.com/isaacs/github/issues/](https://github.com/isaacs/github/issues/) but not with any rigor.
- To be safe, contact GitHub directly at [https://github.com/contact](https://github.com/contact), but recognize that they support literally millions of users and responsiveness is not guaranteed. Forums like isaacs sometimes offer some help because other users can help identify workarounds, for instance, as shown [here](https://github.com/isaacs/github/issues/65#issuecomment-123740194).




