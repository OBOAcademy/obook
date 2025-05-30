# How to create permanent identifiers for your ontology

Permanent identifiers are a core feature of ontologies. Each term should have its own unique URI that contains information about that term. In large domain ontologies, these identifiers are handled by OBO Foundry and resolve to a major ontology index service. However, when making [project ontologies]("../tutorial/project-ontology-development") or other small ontologies not in the OBO ecosystem, you are on your own.

Fortunately there's [w3id.org](https://w3id.org/) - an open, secure, permanent redirect service. This service can give you a custom URI for your ontology and handle redirects to where your ontology lives. 

This tutorial will show you how to use [w3id.org](https://w3id.org/) to create permanent URIs for your ontology. This tutorial does not cover how to add prefixes and URIs to your ontology - for that you should check out the tutorial [How to get started with your own ODK-style repository]("/setting-up-project-odk/").

## Step 1: Pick your prefix

The convention in ontology world is to have a short prefix for your ontology. This is usually indicative of the domain of the ontology. For example, the environment ontology has the prefix ENVO. 

When selecting your prefix, you should ensure that it is not in use or similar to other ontologies. See the OBO Foundry [ID Policy](https://obofoundry.org/id-policy.html#allocating-idspaces) page for more best practices.

In our example, we will look at how I set up URIs for the [Ecolink Model Ontology](https://github.com/timalamenciak/elmo) (Prefix: ELMO). 

## Step 2: Create a folder and upload your .htaccess file

The records for w3id.org are managed using GitHub. Here is a link to the repository: https://github.com/perma-id/w3id.org

You need to fork the repository, create a folder with two files and submit a pull request. This sounds like a complicated set of actions, but they will become second nature to you while working on ontologies. 

Here is the official GitHub documentation on how to [Fork a repository](https://docs.github.com/en/enterprise-cloud@latest/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) and [Creating a pull request from a fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)

The name of the folder you create will form the URI. For example, we created the `elmo` folder and our URI is https://w3id.org/elmo/. Think of the w3id.org repository as the root of the website.

You need to create exactly two files in this folder: `.htaccess` and `README.md`. You can use your favourite text editor to create these two files. 

The folks at w3id.org have created some documentation and examples for these files which can be found at [this link](https://github.com/perma-id/w3id.org/tree/master/examples), but we will provide ontology-specific examples here.

### README.md

This file must contain, at a minimum: 
- The name of the project to which the permanent identifier applies;
- A name, email and GitHub username responsible for the identifier;
- A GitHub repo for the ontology.

The syntax is straightforward markdown. Here is the [exact file](https://raw.githubusercontent.com/perma-id/w3id.org/refs/heads/master/elmo/README.md) used for elmo:

```
# Ecolink Model Ontology (elmo)
This is a permanent identifier for the Ecolink Model Ontology.

This space is administered by: Tim Alamenciak
tim.alamenciak@gmail.com
GitHub username: timalamenciak  

Please see the Github repo for more details: https://github.com/timalamenciak/elmo
```

### .htaccess

This file is a little more complicated and may take some trial and error to get right. You have two options here:

1. A generic redirect that always points to the latest version of the ontology:
```
# Ecolink Model Ontology (elmo)
# This is a project ontology for the Ecolink Model, which 
# describes ecological knowledge.
# 
# https://github.com/timalamenciak/elmo
# This space is administered by:
#
# Tim Alamenciak
# tim.alamenciak@gmail.com
# GitHub username: timalamenciak  
Options +FollowSymLinks
RewriteEngine On

# Handle /elmo without additional path (exact match)
RewriteRule ^$ https://timalamenciak.github.io/elmo/elmo.html [R=301,L,QSA]
```

2. A more sophisticated redirect that can properly resolve term URIs - e.g. https://w3id.org/elmo/elmo.html#ELMO_3620021

```
# Ecolink Model Ontology (elmo)
# This is a project ontology for the Ecolink Model, which 
# describes ecological knowledge.
# 
# https://github.com/timalamenciak/elmo
# This space is administered by:
#
# Tim Alamenciak
# tim.alamenciak@gmail.com
# GitHub username: timalamenciak  
Options +FollowSymLinks
RewriteEngine On

# Handle /elmo with additional path segments
RewriteRule ^(.+)$ https://timalamenciak.github.io/elmo/elmo.html#$1 [R=301,NE,L,QSA]

# Handle /elmo without additional path (exact match)
RewriteRule ^$ https://timalamenciak.github.io/elmo/elmo.html [R=301,L,QSA]
```

#### Breaking down .htaccess
This file uses a fairly uncommon syntax and it can be difficult to get right. Here is a breakdown of our example.

First, there is the frontmatter, which essentially restates what you wrote in the `README.md`:

```
# Ecolink Model Ontology (elmo)
# This is a project ontology for the Ecolink Model, which 
# describes ecological knowledge.
# 
# https://github.com/timalamenciak/elmo
# This space is administered by:
#
# Tim Alamenciak
# tim.alamenciak@gmail.com
# GitHub username: timalamenciak  
Options +FollowSymLinks
RewriteEngine On
```

There are two lines here that configure the server so that redirects work.

The rewrite rules are where the bulk of the work happens. Here's the simple one:
`RewriteRule ^$ https://timalamenciak.github.io/elmo/elmo.html [R=301,L,QSA]`

This line contains a snippet of [Regex](https://en.wikipedia.org/wiki/Regular_expression) (`^$`) that matches the base URI for your redirect. In this case, it will match requests to `https://w3id.org/elmo` and direct them to `https://timalamenciak.github.io/elmo/elmo.html`. The end of the line contains some essential flags to enable the redirect: `[R=301,L,QSA]`. These have specific meanings in the .htaccess file. If you are very curious, you can see the meanings in [this StackOverflow post](https://stackoverflow.com/questions/16468098/what-is-l-in-qsa-l-in-htaccess). All three are required.

Including just this rule will always redirect your base URI to whatever you point it at. This means that even if someone clicks on a term URI (e.g. `https://w3id.org/elmo/elmo_3620021`), it redirects to the entire ontology file rather than to the specific term. That functionality requires an additional rewrite rule and some processing of your ontology.

This is the second rewrite rule you need, which has to come first in your .htaccess file:
`RewriteRule ^(.+)$ https://timalamenciak.github.io/elmo/elmo.html#$1 [R=301,NE,L,QSA]`

There are two differences with this file. The first is the matching Regex which now looks like this: `^(.+)$`. This tells the web server to look at the URI (`^`) and capture anything between the base URI and the end (e.g. `#elmo_3620022`) and append that to the end of the redirect URI (signified by `$1`). There is one additional flag (`NE`) which tells the web server not to escape characters. Without this flag, the web server will pass along `%23` instead of `#`.

Of course, this won't do anything if you are redirecting to your raw OWL file. (See: https://raw.githubusercontent.com/timalamenciak/elmo/refs/heads/main/elmo.owl#elmo_3620021). 

For ELMO, I wrote a custom Python script that creates a `.html` file from an OWL file based on a template. If you are handy with Python, it would be fairly straightforward to adapt this script for your own repo. If you are really handy with Python, consider helping to make this a generic script that anyone can use in their ontology! Here is the link: https://github.com/timalamenciak/elmo/blob/main/src/scripts/owl2mkdocs.py



