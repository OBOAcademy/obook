# Creating a new Repository with the Ontology Development Kit

This is instructions on how to create an ontology repository in
GitHub. This will only need to be done once per project. You may need
assistance from someone with basic unix knowledge in following
instructions here.

We will walk you though the steps to make a new ontology project.

## 1. Get ready to use the ODK

Follow the [procedure](odk-setup.md) to

* install Docker;
* download the current ODK image;
* install the ODK Runner tool.

At the end of this procedure, you should be able to call both `docker` and
`odkrun` from the command line.

Also make sure you have `git` installed and ready to use. The default seeding
command further below assumes you have a `.gitconfig` file in your home
directory.

## 2. Run the seeding command

You can either pass in a configuration file in YAML format that specifies your
ontology project setup, or you can pass arguments on the command line.

Creating a repo by passing arguments on the command line:

```
odkrun seed -d po -d ro -d pato -u cmungall -t "Triffid Behavior Ontology" triffo
```

Using a predefined [project.yaml](https://raw.githubusercontent.com/INCATools/odkcore/refs/heads/main/examples/triffo/project.yaml) file:

```
odkrun seed -C project.yaml
```

Both commands will create your starter files in
`target/triffid-behavior-ontology`. It will also prepare an initial release
and initialize a local repository (not yet pushed to your Git host site such
as GitHub or GitLab).

### Customizing the command

- Instead of `-u cmungall` you should be using your own username (i.e. `-u
  nico`), for example for your GitHub or GitLab hosting sites.
- You can add a -c (lowercase) just before the -C (capital c) in the command
  to first delete any previous attempt to generate your ontology with the ODK,
  and then replaces it with a completely new one. So, `-c` stands for `clean`
  or "clean up previous attempts before running again" and `-C` stands for
  "the next parameter is the relative path to my config file".
- In general, we now _always_ recommend the use of config files. The ODK has a
  rich set of configuration options, most of which can only be set through the
  config file, but in general the config also serves as documentation and will
  help with updating your ontology at later stages.

To create a config file, you can download for example
[project.yaml](https://raw.githubusercontent.com/INCATools/odkcore/refs/heads/main/examples/triffo/project.yaml)
by clicking on the link and then typing `command+s` on Mac or `ctrl+s` on
Windows to save it in your working directory.

Then you can open the file with a text editor like Notepad++, Atom, Sublime or
even nano, and adapt it to your project. Other more comprehensive examples can
be found
[here](https://raw.githubusercontent.com/INCATools/odkcore/refs/heads/main/examples/).


### Problems?

There are three frequently encountered problems at this stage:

1. No local Git configuration
2. Spaces in user path
3. During download, your filenames got changed (Windows)

#### No local Git configuration

The `odkrun seed` command uses `git config` to automatically obtain the
username and email to use in the initial commit. That information is typically
stored in a `~/.gitconfig` file in your user account’s home directory.

If you do not have such a file, you may create and initialise it with:

```sh
git config --global user.name Alice
git config --global user.email alice@example.org
```

If for some reason you do not wish to set a Git username and email globally,
or you wish to use a different username and email than those already set in
your `~/.gitconfig` file, you may explicitly pass a username and an email when
you call the `odkrun seed` script as follows:

```sh
odkrun seed --gitname Alice --gitemail alice@example.org ...
```

#### Spaces in user path

We have had reports of users having trouble if their paths (say, `D:\data`)
contain a space symbol, like `D:/Dropbox (Personal)` or similar. In this case,
we recommend to find a directory you can work in that does not contain a space
symbol.

You can customize at this stage, but we recommend to first push the changes to
you Git hosting site (see next steps).

#### During download, your filenames got changed (Windows)

Windows users, occasionally it has been reported that files downloaded on a
Windows machine get a wrong file ending, for example `project.yaml.txt`
instead of `project.yaml`. If you have problems, double check your files are
named correctly after the download!

## 4. Push to Git hosting website

The development kit will automatically initialize a git project, add all files
and commit.

You will need to create a project on you Git hosting site.

_For GitHub:_

1.  Go to: https://github.com/new
2.  The owner MUST be the org you selected with the `-u` option. The name MUST
    be the one you set with `-t`, just with lower case letters and dashes
    instead of spaces. In our example above, the name "Triffid Behavior
    Ontology" translates to `triffid-behavior-ontology`.
3.  Do not initialize with a README (you already have one).
4.  Click Create.
5.  See the section under "…or push an existing repository from the command
    line".

_For GitLab:_

1.  Go to: https://gitlab.com/projects/new
2.  The owner MUST be the org you selected with the `-u` option. The name MUST
    be the one you set with `-t`.
3.  Do not initialize with a README (you already have one).
4.  Click 'Create project'.
5.  See the section under "Push an existing Git repository".

Follow the instructions there. E.g. (make sure the location of your remote is
exactly correct!).

```
cd target/triffo
git remote add origin https://github.com/matentzn/triffid-behavior-ontology.git
git branch -M main
git push -u origin main
```

Note: you can now mv `target/triffid-behavior-ontology` to anywhere you like
in your home directory. Or you can do a fresh checkout from github.

### Alternative recommendation for GitHub by @matentzn

I generally feel its easier and less error prone to deviate from the standard
instructions above. I keep having problems with git, passwords, typose etc, so
I tend to do it, inofficially, as follows:

1. When my repo is created I go to my GitHub Desktop.
2. I then do File > Add local repository, and select the directory which
   contains my newly created repo (e.g. `target/triffo`).
3. I then Click on "Publish repository".
4. If I want the code to be public, I deselect "Keep this code private". By
   default, the repo will be uploaded to my own user profile on GitHub, but I
   can also select another Organization I have access to in the respective
   Dropdown menu.
5. NOTE: there seem to be some issues with pushing a GitHub Workflow file
   recently - you may be asked by GitHub Desktop to provide an additional
   permission to push the Workflow file.

## Next Steps: Edit and release cycle

In your repo you will see a README-editors.md file that has been customized
for your project. Follow these instructions.

## OBO Library metadata

The assumption here is that you are adhering to OBO principles and want to
eventually submit to OBO. Your repo will contain stub metadata files to help
you do this.

You can create pull requests for your ontology on the OBO Foundry. See the
`src/metadata` file for more details.

For more documentation, see http://obofoundry.org

## Additional

You will want to also:

- enable GitHub actions.

See the README-editors.md file that has been generated for your project.
