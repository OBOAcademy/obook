# Tutorial: Very (!) short introduction to the command line for ontology curators and semantic engineers: Part 2

Today we will pick up where we left off after the [first CLI tutorial](intro-cli-1.md), and discuss some more usages of the command line. In particular, we will:

- Introduce you into the art of managing your shell profile
- Learn how to manage your path
- Talk about how to make your shell hacking more efficient with aliases and functions.

## Prerequisites

You have:

- Completed the [first CLI tutorial](intro-cli-1.md)
- (Optional) installed the amazing [ohmyzsh! - advanced CLI](#ohmyzsh) for managing your ZSH profile. **Important**: Before installing ohmyzsh, back up you `~/.zshrc` file in case you have had any previous customisations you wish to preserve.

## Preparation

- Install https://ohmyz.sh/ (optional)
- For advanced windows users with docker installed, you can:
    1. Follow the [instructions here](../howto/odk-setup.md) to set yourself up for ODK development.
    2. Place `odk.bat` as instructed above in some directory on your machine (the path to the odk.bat file should have no spaces!)
    3. Create a new file `.bash_profile` in the same directory as your odk.bat file.
    4. Add something like `-v %cd%\.bash_profile:/root/.bash_profile` to the odk.bat file (this is mounting the `.bash_profile` file inside your ODK container). There is already a similar -v statement in this file, just copy it right after
    5. Enter the ODK using `odk.bat bash` on your CMD (first, `cd` to the directory containing the odk.bat file).
    6. Now you can follow most of this tutorial here as well.

## Tutorial

- [ohmyzsh! - advanced CLI (OPTIONAL)](#ohmyzsh)
- [Managing the "Path": A first peak at your shell profile](#path)
- [Managing aliases and functions in your bash profile](#alias)

<a id="ohmyzsh"></a>

## ohmyzsh! - advanced CLI (OPTIONAL)

If you have not done so, install https://ohmyz.sh/. It is not strictly speaking necessary to use ohmyzsh to follow the rest of this tutorial, but it is a nice way to managing your Zsh (z-shell) configuration. Note that the ODK is using the much older `bash`, but it should be fine for you to work with anyways.

<a id="path"></a>

## Managing the "Path": A first peak at your shell profile

As Semantic Engineers or Ontology Curators we frequently have to install custom tools like ROBOT, owltools, and more on our computer. These are frequently downloaded from the internet as "binaries", for example as Java "jar" files. In order for our shell to "know" about these downloaded programs, we have to "add them to the path".

Let us first look at what we currently have loaded in our path:

```console
echo $PATH
```

What you see here is a list of paths. To read this list a bit more easily, let us remember our lesson on [piping commands](../tutorial/intro-cli-1.md#pipe):

```console
echo $PATH | tr ':' '\n'  | sort
```

What we do here:

1. Using the `echo` command to print the contents of the $PATH variable. In Unix systems, the `$` signifies the beginning of a variable name (if you are curious about what other "environment variables" are currently active on your system, use the `printenv` command). The output of the `echo` command is piped to the next command (`tr`).
2. The `tr – translate characters` command copies the input of the previous command to the next with substitution or deletion of selected characters. Here, we substitute the `:` character, which is used to separate the different directory paths in the `$PATH` variable, with "\n", which is the all important character that denotes a "new line".
3. Just because, we also sort the output alphabetically to make it more readable.

So, how do we change the "$PATH"? Let's try and install ROBOT and see! Before we download ROBOT, let us think how we will organise our custom tools moving forward. Everyone has their own preferences, but I like to create a `tools` directory right in my Users directory, and use this for all my tools moving forward. In this spirit, lets us first go to our user directory in the terminal, and then create a "tools" directory:

```
cd ~
mkdir -p tools
```

The `-p` parameter simply means: create the tools directory only if it does not exist. Now, let us go inside the tools directory (`cd ~/tools`) and continue following the instructions provided [here](http://robot.obolibrary.org/).

First, let us download the latest ROBOT release using the `curl` command:

```
curl -L https://github.com/ontodev/robot/releases/latest/download/robot.jar > robot.jar
```

ROBOT is written in the Java programming language, and packaged up as an executable JAR file. It is still quite cumbersome to directly run a command with that JAR file, but for the hell of it, let us just do it (for fun):

```
java -jar robot.jar --version
```

If you have worked with ROBOT before, this looks quite a bit more ugly then simply writing:

```
robot --version
```

If you get this (or a similar) error:

```
zsh: permission denied: robot
```

You will have to run the following command as well, which makes the `robot` wrapper script executable:

```
chmod +x ~/tools/robot
```

So, how can we achieve this? The answer is, we download a "wrapper script" and place it in the same folder as the Jar. Many tools provide such wrapper scripts, and they can sometimes do many more things than just "running the jar file". Let us know download the latest wrapper script:

```
curl https://raw.githubusercontent.com/ontodev/robot/master/bin/robot > robot
```

If everything went well, you should be able to print the contents of that file to the terminal using `cat`:

```console
cat robot
```

You should see something like:

```console
#!/bin/sh

## Check for Cygwin, use grep for a case-insensitive search
IS_CYGWIN="FALSE"
if uname | grep -iq cygwin; then
    IS_CYGWIN="TRUE"
fi

# Variable to hold path to this script
# Start by assuming it was the path invoked.
ROBOT_SCRIPT="$0"

# Handle resolving symlinks to this script.
# Using ls instead of readlink, because bsd and gnu flavors
# have different behavior.
while [ -h "$ROBOT_SCRIPT" ] ; do
  ls=`ls -ld "$ROBOT_SCRIPT"`
  # Drop everything prior to ->
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    ROBOT_SCRIPT="$link"
  else
    ROBOT_SCRIPT=`dirname "$ROBOT_SCRIPT"`/"$link"
  fi
done

# Directory that contains the this script
DIR=$(dirname "$ROBOT_SCRIPT")

if [ $IS_CYGWIN = "TRUE" ]
then
    exec java $ROBOT_JAVA_ARGS -jar "$(cygpath -w $DIR/robot.jar)" "$@"
else
    exec java $ROBOT_JAVA_ARGS -jar "$DIR/robot.jar" "$@"
fi
```

We are not getting into the details of what this wrapper script does, but note that, you can fine the actually call the the ROBOT jar file towards the end: `java $ROBOT_JAVA_ARGS -jar "$DIR/robot.jar" "$@"`. The cool thing is, we do not need to ever worry about this script, but it is good for use to know, as Semantic Engineers, that it exists.

Now, we have downloaded the ROBOT jar file and the wrapper script into the `~/tools` directory. The last step remaining is to add the `~/tools` directory to your path. It makes sense to try to at least understand the basic idea behind environment variables: variables that are "loaded" or "active" in your environment (your shell). The first thing you could try to do is change the variable right here in your terminal. To do that, we can use the `export` command:

```
export PATH=$PATH:~/tools
```

What you are doing here is using the `export` command to set the `PATH` variable to `$PATH:~/tools`, which is the old path (`$PATH`), a colon (`:`) and the new directory we want to add (`~/tools`). And, indeed, if we now look at our path again:

```console
echo $PATH | tr ':' '\n'  | sort
```

We will see the path added. We can now move around to any directory on our machine and invoke the `robot` command. Try it before moving on!

Unfortunately, the change we have now applied to the `$PATH` variable is not persistent: if you open a new tab in your Terminal, your `$PATH` variable is back to what it was. What we have to do in order to make this persistent is to add the `export` command to a special script which is run every time the you open a new terminal: your shell profile.

There is a lot to say about your shell profiles, and we are taking a very simplistic view here that covers 95% of what we need: If you are using `zsh` your profile is managed using the `~/.zshrc` file, and if you are using `bash`, your profile is managed using the `~/.bash_profile` file. In this tutorial I will assume you are using `zsh`, and, in particular, after installing "oh-my-zsh". Let us look at the first 5 lines of the `~/.zshrc` file:

```console
head ~/.zshrc
```
If you have installed oh-my-zsh, the output will look something like:

```
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
```

This `~/.zshrc` profile script is loaded every time you open up a new shell. What we want to do is add our `export` command above to this script, so that it is running **every time**. That is the basic concept of a shell profile: providing a series of commands that is run every time a new shell (terminal window, tab) is opened.

For this tutorial, we use `nano` to edit the file, but feel free to use your text editor of choice. For example, you can open the profile file using `TextEdit` on Mac like this:

```console
open -a TextEdit ~/.zshrc
```

We will proceed using `nano`, but feel free to use any editor.

```console
nano ~/.zshrc
```

Using terminal-based editors like nano or, even worse, vim, involves a bit of a learning curve. `nano` is by far the least powerful and simple to use. If you typed the above command, you should see its contents on the terminal. The next step is to copy the following (remember, we already used it earlier)

```
export PATH=$PATH:~/tools
```

and paste it **somewhere into the file**. Usually, there is a specific section of the file that is concerned with setting up your path. Eventually, as you become more of an expert, you will start organising your profile according to your own preferences! Today we will just copy the command anywhere, for example:

```console
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=~/tutorial:$PATH
# ..... other lines in the file
```

Note that the `#` symbol denotes the beginning of a "comment" which is ignored by the shell/CLI. After you have pasted the above, you use the following keyboard key-combinations to safe and close the file:

```
control + O
```

This saves the file. Confirm with Enter.

```
control + x
```

This closes the file. Now, we need to tell the shell we are currently in that it should reload our profile we have just edited. We do that using the `source` command.

```
source ~/.zshrc
```

Great! You should be able open a new tab in your terminal (with command+t on a Mac, for example) and run the following command:

```
robot --version
```

<a id="alias"></a>

## Managing aliases and custom commands in your shell profile

This section will only give a sense of the kinds of things you can do with your shell profile - in the end you will have to jump into the cold water and build your skills up yourself. Let us start with a very powerful concept: aliases. Aliases are short names for your commands you can use if you use them repeatedly but are annoyed typing them out every time. For example, tired of typing out long paths all the time to jump between your Cell Ontology and Human Phenotype Ontology directories? Instead of:

```console
cd /Users/matentzn/ws/human-phenotype-ontology/src/ontology
```

wouldn't it be nice to be able to use, instead,

```console
cdhp
```

or, if you are continuously checking `git status`, why not implement a  alias `gits`? Or activating your python environment (`source ~/.pyenv/versions/oak/bin/activate`) with a nice `env-oak`? To achieve this we do the following:

(1) Open your profile in a text editor of your choice, e.g.

```
nano ~/.zshrc
```

add the following lines:

```console
alias cdt='cd ~/tools'
alias hg='history | grep'
```

Save (control+o) and close (control+x) the profile. Reload the profile:

```console
source ~/.zshrc
```

(Alternatively, just open a new tab in your Terminal.) Now, lets try our new aliases:

```console
cdt
```

Will bring you straight to your `tools` directory you created in the previous lesson above.

```console
hg robot
```
Will search your terminal command history for every command you have executed involving `robot`.

### List of ideas for aliases

In the following, we provide a list of aliases we find super useful:

1. `alias cdt='cd ~/tools'` - add shortcuts to all directories you frequently visit!
2. `alias orcid='echo '\''https://orcid.org/0000-0002-7356-1779'\'' | tr -d '\''\n'\'' | pbcopy'` - if you keep having to look up your ORCID, your favourite ontologies PURL or the your own zoom room, why not add a shortcut that copies it straight into your clipboard?
3. `alias opent='open ~/tools'` - why not open your favourite directory in finder without faving to search the User Interface? You can use the same idea to open your favourite ontology from wherever you are, i.e. `alias ohp='open ~/ws/human-phenotype-ontology/src/ontology/hp-edit.owl'`.
4. `alias env-linkml='source ~/.pyenv/versions/linkml/bin/activate'` - use simple shortcuts to active your python environments. This will become more important if you learn to master special python tools like [OAK](https://github.com/INCATools/ontology-access-kit).
5. `alias update_repo='sh run.sh make update_repo'` - for users of ODK - alias all your long ODK commands!

### Functions

The most advanced thought we want to cover today is "functions". You can not only manage simple aliases, but you can actually add proper functions into your shell profile. Here is an example of one that I use:

```
ols() {
    open https://www.ebi.ac.uk/ols/search?q="$1"
}
```

This is a simple function in my bash profile that I can use to search on OLS:

```console
ols "lung disorder"
```

It will open this search straight in my browser.

```
rreport() {
    robot report -i "$1" --fail-on none -o /Users/matentzn/tmp_data/report_"$(basename -- $1)".tsv
}
```

This allows me to quickly run a robot report on an ontology. 

```
rreport cl.owl
```

Why not expand the function and have it open in my atom text editor right afterwards?

```
rreport() {
    robot report -i "$1" --fail-on none -o /Users/matentzn/tmp_data/report_"$(basename -- $1)".tsv && atom /Users/matentzn/tmp_data/report_"$(basename -- $1)".tsv
}
```

The possibilities are endless. Some power-users have hundreds of such functions in their shell profiles, and they can do amazing things with them. Let us know about your own ideas for functions on the [OBOOK issue tracker](https://github.com/OBOAcademy/obook/issues). Or, why not add a function to create a new, titled issue on OBOOK?

```console
obook-issue() {
  open https://github.com/OBOAcademy/obook/issues/new?title="$1"
}
```

and from now on run:

```console
obook-issue "Add my awesome function"
```

<a id="further"></a>

## Further reading

- [Automating Ontology Development Workflows: Make, Shell and Automation Thinking](../lesson/automating-ontology-workflows.md)
- [Data Science at the Command Line](https://datascienceatthecommandline.com/2e/index.html): Free online book that covers everything you need to know to be a command line magician
- [A whirlwind introduction to the command line by James Overton](https://github.com/jamesaoverton/command-line)