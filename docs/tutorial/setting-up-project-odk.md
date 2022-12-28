# Tutorial: How to get started with your own ODK-style repository

1. Preparation: Installing docker, installing ODK and setting memory. Follow the steps [here](../howto/odk-setup.md).
2. Creating your first ontology repository

The tutorial uses example tailored for users of UNIX systems, like Mac and Linux.
Users of Windows generally have analogous steps - wherever we talk about an `sh` file in the following
there exists a corresponding `bat` file that can be run in the windows powershell, or CMD.

## Prerequisites

You have:

- A Github account
- Completed the "Preparation" steps above

## Video

A recording of a demo of creating a ODK-repo is available [here](https://www.youtube.com/watch?v=cd7750JVDaw)

## Your first repository

1. Create temporary directory to get started

On your machine, create a new folder somewhere:

```
cd ~
mkdir odk_tutorial
cd odk_tutorial
```

2. Download the seed-my-repo wrapper script

Now download the seed-my-repo wrapper script from the ODK GitHub repository. A detailed explanation of how to do that can be found [here](https://github.com/INCATools/ontology-development-kit/blob/master/docs/CreatingRepo.md#2-download-the-wrapper-script-and-pull-latest-odk-version). For simplicity, we just use wget here to download the seed-my-repo file, but you can do it manually:

```
wget https://raw.githubusercontent.com/INCATools/ontology-development-kit/master/seed-via-docker.sh
```

3. Download a basic config to start from and start building your own

The last ingredient we need is an ODK config file. While you can, in theory, create an empty repo entirely without a config file (one will be generated for you), we recommend to just start right with one. You can find many examples of configs [here](https://github.com/INCATools/ontology-development-kit/tree/master/configs). For the sake of this tutorial, we will start with a simple config:

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

Safe this config file as in your temporary directory, e.g. `~/odk_tutorial/cato-odk.yaml`.

Most of your work managing your ODK in the future will involve editing this file. There are dozens of cool options that do magical things in there. For now, lets focus on the most essential:

#### General config:

```
id: cato
title: "Cat Anatomy Ontology"
```

The id is essential, as it will determine how files will be named, which default term IDs to assume, and many more. It should be a lowercase string which is, by convention at least 4 characters long - 5 is not unheard of. The `title` field is used to generate various default values in the repository, like the README and others. There are other fields, like `description`, but let's start minimal for now. A full list of elements can be found in this schema:

https://github.com/INCATools/ontology-development-kit/blob/master/schema/project-schema.json

#### Git config:

```
github_org: obophenotype
git_main_branch: main
repo: cat_anatomy_ontology
```

The `github_org` (the GitHub or GitLab organisation) and the `repo` (repository name) will be used for some basic config of the git repo. Enter your own `github_org` here rather than `obophenotype`. Your default `github_org` is your GitHub username. If you are not creating a new repo, but working on a repo that predates renaming the GitHub main branch from `master` to `main`, you may want to set the `git_main_branch` as well.

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

With this configuration, we tell the ODK that we wish to automatically generate the base, full and simple release files for our ontology. We also say that we want the `primary_release` to be the `full` release (which is also the default). The primary release will be materialised as `cato.owl`, and is what most users of your ontology will interact with. More information and what these are can be found [here](https://github.com/INCATools/ontology-development-kit/blob/master/docs/ReleaseArtefacts.md). We always want to create a `base`, i.e. the release variant that contains all the axioms that belong to the ontology, and none of the imported ones, but we do not want to make it the `primary_release`, because it will be unclassified and missing a lot of the important inferences.

We also configure export products: we always want to export to `OWL` (`owl`), but we can also chose to export to `OBO` (`obo`) format and `OBOGraphs JSON` (`json`).

#### Imports config:

```
import_group:
  products:
    - id: ro
    - id: pato
    - id: omo
```

This is a central part of the ODK, and the section of the config file you will interact with the most. Please see [here](managing-dynamic-imports-odk.md) for details. What we are asking the ODK here, in essence, to set us up for dynamically importing from the Relation Ontology (RO), the Phenotype And Trait Ontology (PATO) and the OBO Metadata Ontology (OMO).

#### Memory management:

```
robot_java_args: '-Xmx8G'
```

Here we say that we allow ROBOT to consume up to 8GB of memory. Make sure that your docker is set up to permit at least ~20% more memory than that, i.e. 9GB or 10GB, otherwise, some cryptic Docker errors may come up.

#### ROBOT Report:

```
robot_report:
  use_labels: TRUE
  fail_on: ERROR
  custom_profile: TRUE
  report_on:
    - edit
```

- `use_labels`: allows switching labels on and off in the ROBOT report
- `fail_on`: the report will fail if there is an ERROR-level violation
- `custom_profile`: allows switching on custom profiles, see [here](http://robot.obolibrary.org/report#profiles)
- `report_on`: specify which files to run the report over.

With this configuration, we tell ODK we want to run a report to check the quality of the ontology. Check [here](http://robot.obolibrary.org/report_queries/) the complete list of report queries.

## Generate the repo

Run the following:

```
cd ~/odk_tutorial
sh seed-via-docker.sh -c -C cato-odk.yaml
```

This will create a basic layout of your repo under `target/cato/*`

_Note:_ after this run, you wont need `cato-odk.yaml` anymore as it will have been added to your ontology repo, which we will see later.

## Publish on GitHub

You can now move the `target/cato` directory to a more suitable location. For the sake of this tutorial we will move it to the Home directory.

```
mv target/cato ~/
```

### Using GitHub Desktop

If you use GitHub Desktop, you can now simply add this repo by selecting `File -> Add local repository` and select the directory you moved the repo to (as an aside, you should really have a nice workspace directory like `~/git` or `~/ws` or some such to organise your projects).

Then click `Publish the repository` on

### Using the Command Line

Follow the instructions you see on the Terminal (they are printed after your seed-my-repo run).

## Finish!

Congratulations, you have successfully jump-started your very own ODK repository and can start developing.

## Next steps:

1. Start editing `~/cato/src/ontology/cato-edit.owl` using Protege.
2. [Run a release](managing-ontology-releases-odk.md)
