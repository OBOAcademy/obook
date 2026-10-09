# Tutorial: How to get started with your own ODK-style repository

1. Preparation: Installing docker, installing ODK and setting memory. Follow
   the steps [here](../howto/odk-setup.md).
2. Creating your first ontology repository

## Prerequisites

You have:

- a Github account;
- completed the "Preparation" steps above.

## Video

A recording of a demo of creating a ODK-repo is available
[here](https://www.youtube.com/watch?v=cd7750JVDaw).

## Your first repository

1. Create temporary directory to get started.

On your machine, create a new folder somewhere:

```
cd ~
mkdir odk_tutorial
cd odk_tutorial
```

2. Download a basic config to start from and start building your own

Then we need an ODK config file. While you can, in theory, create an empty
repo entirely without a config file (one will be generated for you), we
recommend to just start right with one. You can find many examples of configs
[here](https://github.com/INCATools/odkcore/tree/main/examples). For the sake
of this tutorial, we will start with a simple config:

```yaml
id: cato
title: "Cat Anatomy Ontology"
github_org: obophenotype
git_main_branch: main
repo: cat_anatomy_ontology
release_artefacts:
  - base
  - full
  - simple
primary_release: full
export_formats:
  - owl
  - obo
  - json
import_group:
  products:
    - id: ro
    - id: pato
    - id: omo
robot_java_args: "-Xmx8G"
robot_report:
  use_labels: TRUE
  fail_on: ERROR
  custom_profile: TRUE
  report_on:
    - edit
```

Safe this config file as in your temporary directory, e.g.
`~/odk_tutorial/cato-odk.yaml`.

Most of your work managing your ODK in the future will involve editing this
file. There are dozens of cool options that do magical things in there. For
now, lets focus on the most essential:

#### General config:

```
id: cato
title: "Cat Anatomy Ontology"
```

The id is essential, as it will determine how files will be named, which
default term IDs to assume, and many more. It should be a lowercase string
which is, by convention at least 4 characters long - 5 is not unheard of. The
`title` field is used to generate various default values in the repository,
like the README and others. There are other fields, like `description`, but
let's start minimal for now.

#### Git config:

```
github_org: obophenotype
git_main_branch: main
repo: cat_anatomy_ontology
```

The `github_org` (the GitHub or GitLab organisation) and the `repo`
(repository name) will be used for some basic config of the git repo. Enter
your own `github_org` here rather than `obophenotype`. Your default
`github_org` is your GitHub username. If you are not creating a new repo, but
working on a repo that predates renaming the GitHub main branch from `master`
to `main`, you may want to set the `git_main_branch` as well.

#### Pipeline configuration

```
release_artefacts:
  - base
  - full
  - simple
primary_release: full
export_formats:
  - owl
  - obo
  - json
```

With this configuration, we tell the ODK that we wish to automatically
generate the base, full and simple release files for our ontology. We also say
that we want the `primary_release` to be the `full` release (which is also the
default). The primary release will be materialised as `cato.owl`, and is what
most users of your ontology will interact with. More information and what
these are can be found
[here](https://github.com/INCATools/ontology-development-kit/blob/master/docs/ReleaseArtefacts.md).
We always want to create a `base`, i.e. the release variant that contains all
the axioms that belong to the ontology, and none of the imported ones, but we
do not want to make it the `primary_release`, because it will be unclassified
and missing a lot of the important inferences.

We also configure export products: we always want to export to `OWL` (`owl`),
but we can also chose to export to `OBO` (`obo`) format and `OBOGraphs JSON`
(`json`).

#### Imports config:

```
import_group:
  products:
    - id: ro
    - id: pato
    - id: omo
```

This is a central part of the ODK, and the section of the config file you will
interact with the most. Please see [here](managing-dynamic-imports-odk.md) for
details. What we are asking the ODK here, in essence, to set us up for
dynamically importing from the Relation Ontology (RO), the Phenotype And Trait
Ontology (PATO) and the OBO Metadata Ontology (OMO).

#### ROBOT Report:

```
robot_report:
  use_labels: TRUE
  fail_on: ERROR
  report_on:
    - edit
```

- `use_labels`: allows switching labels on and off in the ROBOT report;
- `fail_on`: the report will fail if there is an ERROR-level violation;
- `report_on`: specify which files to run the report over.

With this configuration, we tell ODK we want to run a report to check the
quality of the ontology. Check
[here](http://robot.obolibrary.org/report_queries/) the complete list of
report queries.

## Generate the repo

Run the following:

```
cd ~/odk_tutorial
odkrun seed -c -C cato-odk.yaml
```

This will create a basic layout of your repo under `target/cato/*`

_Note:_ after this run, you wont need `cato-odk.yaml` anymore as it will have
been added to your ontology repo, which we will see later.

By default, the `odkrun seed` command attempts to obtain your Git username and
email from your local Git configuration (typically stored in `~/.gitconfig`,
or in `GIT_*` environment variables). If for some reason you want your
repository to be initialised with a different username and/or email, you may
explicitly pass them to the `seed` command as follows:

```
odkrun seed -c -C cato-odk.yaml --gitname Alice --gitemail alice@example.org
```

> The above section assumes that you have installed the `odkrun` tool as
> recommended [here](../howto/odk-setup.md#odkrunner). If for some reason you
> prefer not using that tool, you may use instead the `seed-via-docker.sh` (or
> `seed-via-docker.bat` on Windows) seeding script mentioned in the section
> [Alternatives to the ODK Runner](../howto/odk-setup.md#odkrunner-alternatives).

## Publish on GitHub

You can now move the `target/cato` directory to a more suitable location. For
the sake of this tutorial we will move it to the Home directory.

```
mv target/cato ~/
```

### Using GitHub Desktop

If you use GitHub Desktop, you can now simply add this repo by selecting `File
-> Add local repository` and select the directory you moved the repo to (as an
aside, you should really have a nice workspace directory like `~/git` or
`~/ws` or some such to organise your projects).

Then click `Publish the repository` on

### Using the Command Line

Follow the instructions you see on the Terminal (they are printed after your
`odkrun seed` run).

## Finish!

Congratulations, you have successfully jump-started your very own ODK
repository and can start developing.

## Next steps:

1. Start editing `~/cato/src/ontology/cato-edit.owl` using Protégé.
2. [Run a release](managing-ontology-releases-odk.md)
