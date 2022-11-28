# Using Github actions to automate tasks

## Post a comment with ontology differences on pull request

The command line tool Robot has a [diff tool](http://robot.obolibrary.org/diff) that compares two ontology files and can print the differences between them in multiple formats, among them markdown.

We can use this tool and [GitHub actions](https://github.com/features/actions) to automatically post a comment when a Pull Request to master is created, with the differences between the two ontologies.

To create a new GitHub action, create a folder in your ontology project root folder called `.github`. Then create a yaml file in a subfolder called `workflows`, e.g. `.github/workflows/diff.yml`. This file contains code that will be executed in GitHub when certain conditions are meant, in this case, when a PR to master is submitted. The comments in [this file](https://github.com/pombase/fypo/blob/master/.github/workflows/diff.yml) from FYPO will help you write an action for your own repository.

The comment will look something [like this](https://github.com/pombase/fypo/pull/4199#issuecomment-1222373760).
