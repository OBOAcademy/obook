## Introduction to GitHub
##### [Back to Getting Started](https://github.com/jamesaoverton/obook/tree/master/00-gettingStarted)
##### [Back to Main Repo](https://github.com/jamesaoverton/obook)
### Overview:
- [Getting started](#getting-started)
- [Organization](#organization)
- [Markdown](#markdown)
- [Content types](#content)

### Getting started

GitHub is increasingly used by software developers, programmers and project managers for uploading and sharing content, as well as basic project management. You build a profile, upload projects to share and connect with other users by "following" their accounts. Many users store programs and code projects, but you can also upload text documents or other file types in your project folders to share publicly (or privately). It is capable of storing any file type from text, to structured data, to software. And more features are being added by the day. The real power of Git, however, is less about individuals publishing content (many places can do that, including google docs etc). It is more about that content being easily shared, built upon, and credited in a way that is robust to the realities of distributed collaboration. You don't have to know how to code or use the command line. It is a powerful way to organize projects with multiple participants.

### Organization

Git supports the following types of primary entities:

- **Individual:** A person who contributes to GitHub (that's you!) 
  - Example individual [http://github.com/jmcmurry](http://github.com/jmcmurry)
- **Organization:** An entity that may correspond to an actual organization (such as a university) or to a meaningful grouping of repositories. Organizations are like individuals except that they can establish teams. 
  - Example organization: [http://github.com/data2health](http://github.com/data2health)
- **Repository:** A collection of versioned files (of any type)
  - Example repository [http://github.com/data2health/mtip-tutorial](http://github.com/data2health/mtip-tutorial)
- **Teams**: A group of individuals assembled by the administrators of an organization. An individual may participate in many teams and organizations, however a team is always bound to a single organization. Nesting teams saves time; [instructions here](https://github.blog/2017-06-13-nested-teams-add-depth-to-your-team-structure/).
  - Example team [https://github.com/orgs/data2health/teams/mtiptutorial](https://github.com/orgs/data2health/teams/mtiptutorial)

The relationships between any combination of these entities is many-to-many, with the nuanced exception of repositories.
For our purposes today we will oversimplify by saying that a repositoy belongs *either* to a single organization or to a single *individual*.

![](../docs/images/github-organizations-teams-repos.png)

### Task - create a new GitHub repository
- [Create your GitHub account](https://github.com/join) if you do not already have one
- Customize your avatar if you haven't already
	- Go to [settings](https://github.com/settings/profile) and upload any picture (it doesn't have to be your face)
- Create a repository 
	- For directions specific to CD2H Phase II projects, see the FAQ [here](https://docs.google.com/document/d/1UNNxrOpHm7B9hw2Xn2JP_O1DYa7tCHx8OYEC1r0YAyU/edit#)

### Markdown

Content in GitHub is written using Markdown, a text-to-HTML conversion tool for web writers [(ref)](https://kirkstrobeck.github.io/whatismarkdown.com/).

For more help with Markdown, see this [GitHub guide](https://help.github.com/categories/writing-on-github/).

| Raw markup syntax | As rendered |
|-------------|------------|
|`Header - use # for H1, ## for H2, etc.`|# Header, ## Header (note, the header is not displaying properly in this table)|
|`Emphasis, aka italics, with *asterisks* or _underscores_.`|Emphasis, aka italics, with *asterisks* or _underscores_.|
|`Strong emphasis, aka bold, with **asterisks** or __underscores__.`|Strong emphasis, aka bold, with **asterisks** or __underscores__.
|`Combined emphasis with **asterisks and _underscores_**.`|Combined emphasis with **_asterisks and underscores_**.|
|`Strikethrough uses two tildes. ~~Scratch this.~~` | Strikethrough uses two tildes. ~~Scratch this.~~ |

**Lists:**  
To introduce line breaks in markdown, add two spaces
For a bulleted list, use * or - (followed by a space)

Here is an example of a list:  
One  
Two  
Three  

Here is an example of a bulleted list:
- One
- Two
- Three

### Task - update the content in your README
- Go back to the repository you just created
- Click the pencil icon in the right corner of your README.md file
- Add some content to your file that includes a header, italics, bold, strikethrough, and lists
- You can preview your changes before committing by clicking 'Preview changes'.
- Commit your changes by clicking the commit button at the bottom of the page.

### Content types

GitHub can store any kind of content, provided it isn't too big. (And now [even this is possible](https://git-lfs.github.com/)).
However, it is more capable for some filetypes than it is for others. Certain filetypes can be viewed 'natively' within the GitHub interface. These are:

- Images: png, jpg, svg
- GEOJSON
- CSV, TSV (note that files named type '.tab' will not render properly in the UI.)
- Markdown
- Software code (eg. including json, HTML, xml etc)

### Task - add content to your repository
- Click on the code button
- Click upload file
- Upload a file by dragging and dropping or browse for file
- Trying uploading an Excel file vs a TSV or CSV file. How are these displayed differently?

### Chat
- For realtime help with this tutorial, please go to our Gitter chat [here](https://gitter.im/tis-lab/MTIP-tutorial?utm_source=share-link&utm_medium=link&utm_campaign=share-link). You will need to log in with GitHub (preferable) or Twitter.

### Additional Resources
- [Frequently Asked Questions](https://docs.google.com/document/d/1UNNxrOpHm7B9hw2Xn2JP_O1DYa7tCHx8OYEC1r0YAyU/edit#)
- [Git and GitHub for Documentation](http://www.slideshare.net/annegentle/git-and-github-for-documentation)
- [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
- [Git 101: Git and GitHub for Beginners](http://www.slideshare.net/HubSpot/git-101-git-and-github-for-beginners)
- [Mastering Issues (10 min read)](https://guides.github.com/features/issues/)


##### [Click here for Lesson 6](https://data2health.github.io/mtip-tutorial/lessons/Lesson6.html) 
### [Back to Home](../index.md)

