# Automating Ontology Development Workflows: Make, Shell and Automation Thinking

### Warning

These materials are under construction and incomplete.

## Prerequisites

- Ontology Pipelines

## What is delivered as part of the course

In this course, you will learn the basics of automation in and around the OBO ontology world - and beyond. The primary goal is to enable ontology pipeline developers to plan the automation of their ontology workflows and data pipelines, but some of the materials are very general and apply to scientific computing more widely. The course serves also as a prerequisite for advanced application ontology development.

## Learning objectives

- Unix shell
- `make`
- Advanced Git, GitHub

## Preparation

Please complete the following tutorials.

- [The Unix Shell](http://swcarpentry.github.io/shell-novice/) (~4.5 hours)
- [Version Control with Git](http://swcarpentry.github.io/git-novice/) (~3 hours)
- [Introduction to GitHub](../tutorial/github-fundamentals.md)

## Tutorials

### Thinking "Automation"

By: [James Overton](https://orcid.org/0000-0001-5139-5557)

Automation is part of the foundation of the modern world.
The key to using and building automation
is a certain way of thinking about processes,
how they can be divided into simple steps,
and how they operate on inputs and outputs
that must be exactly the same in some respects but different in others.

In this article I want to make some basic points about automation
and how to think about it.
The focus is on automation with software and data,
but not on any particular software or data.
Some of these points may seem _too_ basic,
especially for experienced programmers,
but in 20+ years of programming
I've never seen anybody lay out these basic points in quite this way.
I hope it's useful.

#### The Basics

> "automatos" from the Greek: "acting of itself"

Automation has two key aspects:

1. make the input the **same**
2. **process** the inputs in the same way

The second part is more visible,
and tends to get more attention,
but the first part is at least as important.
While automation makes much of the modern world possible,
it is not new,
and there are serious pitfalls to avoid.
No system is completely automatic,
so it's best to think of automation on a spectrum,
and starting thinking about automation
at the beginning of a new project.

#### Examples of Automation

To my mind, the word "automation" brings images of car factories,
with conveyor belts and robotic arms moving parts and welding them together.
Soon they might be assembling self-driving ("autonomous") cars.
Henry Ford is famous for making cars affordable
by building the first assembly lines,
long before there were any robots.
The essential steps for Ford were standardizing the inputs and the processes
to get from raw materials to a completed car.
The history of the 20th century is full of examples of automation
in factories of all sorts.

Automation was essential to the Industrial Revolution,
but it didn't start then.
We can look to the printing press.
We can look to clocks, which regimented lives in monasteries and villages.
We can think of recipes, textiles, the logistics of armies,
advances in agriculture, banking, the administration of empires,
and so on.
The scientific revolution was built on repeatable experiments
published in letters and journal articles.
I think that the humble checklist is also an important relative of automation.

Automation is not new,
but it's an increasingly important part
of our work and our lives.

#### Software Automation is Special

Software is almost always written as source code in text files
that are compiled and/or interpreted as machine code
for a specific set of hardware.
Software can drive machines of all sorts,
but a lot of software automation stays inside the computer,
working on data in files and databases,
and across networks.
We'll be focused on this kind of software automation,
transforming data into data.

The interesting thing about this is that source code is a kind of data,
so there are software automation workflows
that operate on data that defines software.
The upshot is that you can have automation that modifies itself.
Doing this on a large scale introduces a lot of complexity,
but doing it on a small scale can be a clean solution to certain problems.

Another interesting thing about software is that
once we solve an automation problem once
we can copy that solution and apply it again and again
for almost zero cost.
We don't need to build a new factory or a new threshing machine.
We can just download a program and run it.
Henry Ford could make an accurate estimate
of how long it would take to build a car on his assembly line,
but software development is not like working on the assembly line,
and estimating time and budget for software development is notoriously hard.
I think this is because software developers
aren't just executing automation,
they're building _new_ automation for each new project.

Although we talk about "bit rot",
and software does require maintenance of a sort,
software doesn't break down or wear out
in the same ways that physical machines do.
So while the Industrial Revolution eliminated many jobs,
it also created different jobs,
building and maintaining the machines.
It's not clear that software automation will work the same way.

Software automation is special because it can operate on itself,
and once complete can be cheaply copied.
Software development is largely about building automated systems of various sorts,
usually out of many existing pieces.
We spend most of our time building _new_ systems,
or modifying an existing system to handle _new_ inputs,
or adapting existing software to a _new_ use case.

#### The Dangers of Automation

> To err is human; to really foul things up requires a computer.

An obvious danger of automation is that
machines are faster than humans,
so broken automation can often do more damage
more quickly than a human can.
A related problem is that humans usually have much more
context and depth of experience,
which we might call "common sense",
and a wider range of sensory inputs than most automated systems.
This makes humans much better at recognizing
that something has gone wrong with a process
and that it's time to stop.

New programmers soon learn that a simple program
that performs perfectly when the input is in exactly the right format,
becomes a complex program once it's updated to handle
a wide range of error conditions.
In other words, it's almost always much harder
to build automation that can gracefully handler errors and problems
than it is to automate just the "happy path".
Old programmers have learned through bitter experience
that it's often practically impossible to predict
all the things that can go wrong with an automated system in practise.

> I suppose it is tempting, if the only tool you have is a hammer,
> to treat everything as if it were a nail.
> -- Abraham Maslow

A less obvious danger of automation comes from the sameness requirement.
When you've built a great piece of automation,
perfectly suited to inputs of a certain type,
it's very tempting to apply that automation more generally.
You start paying too much attention to how things are the same,
and not enough attention to their differences.
You may begin to ignore important differences.
You may surrender your common sense and good judgment,
to save yourself the work of changing the automated system or making an exception.

Bureaucracies are a form of automation.
Everyone has had a bad experience
filling out some form that ignores critical information,
and with some bureaucrat who would not apply common sense and make an exception.

Keep all this in mind as you build automated systems:
a broken machine can do a lot of damage very quickly,
and a system built around bad assumptions
can do a lot of hidden damage.

#### A Spectrum of Automation

Let's consider a simple case of automation with software,
and build from the most basic sort of automation
to a full-fledged system.

Say you have a bunch of text files in a directory,
each containing minutes from meetings that we had together over the years.
You can remember that I talked about a particular software package
that might solve a problem that you just discovered,
but you can't remember the name.

##### 1. Ad Hoc

The first thing you try is to just search the directory.
On a Mac you would open the Finder,
navigate to the directory,
and type "James" into the search bar.
Unfortunately that gives too many results:
all the files with the minutes for a meeting where I said something.

The next thing to do is double click some text files,
which would open them in Text Edit program,
and skim them.
You might get lucky!

You know that I the meeting was in 2019,
so you can try and filter for files modified in that year.
Unfortunately the files have been updated at different times,
so the file dates aren't useful.

Now if each file was named with a consistent pattern,
including the meeting date,
then it would be simple to filter for files with "2019" in the name.
This isn't automation,
but it's the first step in the right direction.
Consistent file names are one way to make inputs the **same**
so that you can **process** them in the same way.

Let's say it works:
you filter for files from 2019 with "James" in them,
skim a few,
and find a note where I recommended using Pandoc
to convert between document formats.
Mission accomplished!

##### 2. Notes

Next week you need to do something very similar:
Becky mentioned a website where you can find an important dataset.
It's basically the same problem with different inputs.
If you remember exactly what you did last time,
then you can get the job done quickly.
As the job gets more complicated and more distant in time,
and as you find yourself doing similar tasks more often,
it's nice to have notes about what you did and how you did it.

If I'm using a graphical user interface (GUI)
then for each step I'll note
the program I used,
and the menu item or button I clicked,
e.g. "Preferences > General > Font Size",
or "Search" or "Run".
If I'm using a command-line interface (CLI)
then I'll copy-paste the commands into my notes.

I often keep informal notes like this in a text file
in the relevant directory.
I name the file "notes.txt".
A "README" file is similar.
It's used to describe the contents of a directory,
often saying which files are which,
or what the column headers for a given table mean.

Often the task is more complicated
and requires one or more pieces of software that I don't use every day.
If there's relevant documentation,
I'll put a link to it in my notes,
and then a short summmary of exactly what I did.

In this example
I look in the directory of minutes and see my "notes.txt" file.
I read that and remember how I filtered on "2019" and searched for "James".
This time I filter on "2020" and search for "Becky",
and I find the website for the dataset quickly enough.

As a rule of thumb,
it might take you three times longer
to find your notes file,
write down the steps you took,
and provide a short description,
than it would to just do the job without taking notes.
When you're just taking notes for yourself,
this often feels like a waste of time
(you'll remember, right?!),
and sometimes it is a bit of a waste.
If you end up using your notes
to help with similar tasks in the future,
then this will likely be time well spent.

As a rule of thumb,
it might take three times longer
to write notes for a broader audience
than notes for just yourself.
This is because you need to take into account
the background knowledge of your reader,
including her skills and assumptions and context,
and especially the possible misunderstandings
that you can try to avoid with careful writing.
I often start with notes for just myself
and then expand them for a wider audience only when needed.

##### 3. Checklist

When tasks get more complicated
or more important
then informal notes are not enough.
The next step on the spectrum of automation is the humble checklist.

The most basic checklists are for making sure that each item has been handled.
Often the order isn't important,
but lists are naturally ordered from top to bottom,
and in many cases that order is useful.
For example,
my mother lays out her shopping lists
in the order of the aisles in her local grocery store,
making it easier to get each item and check it off
without skipping around and perhaps having to backtrack.

I think of a checklist as a basic form of automation.
It's like a recipe.
It should lay out the things you need to start,
then proceed through the required steps
in enough detail that you can reproduce them.
In some sense,
by using the checklist you are becoming the "machine".
You are executing an algorithm
that should take you from the expected inputs to the expected output.

Humble as the checklist is,
there's a reason that astronauts, pilots, and surgical teams
live by their checklists.
Even when the stakes are not so high,
it's often nice to "put your brain on autopilot"
and just work the checklist
without having to remember and reconsider the details of each step.

A good checklist is more focused than a file full of notes.
A checklist has a goal at the end.
It has specific starting conditions.
The steps have been carefully considered,
so that they have the proper sequence,
and none are missing.
Perhaps most importantly,
a checklist helps you break a complex task down
into simple parts.
If one of the parts is still too complex,
then break it down again
into a **nested** checklist
(really a sort of tree structure).

Checklists sometimes include another key element of automation: conditionals.
A shopping list might say
"if there's a sale on crackers, then buy three boxes".
If-then conditions let our automated systems adapt to circumstances.
The "then" part is just another step,
but the "if" part is a little different.
It's a **test** to determine whether a condition holds.
We almost always want the result of the test
to be a simple True or False.
Given a bunch of inputs,
some of which pass the test and some of which fail it,
we can think of the test as _determining_ some way in which
all the things that pass are the **same**
and all the things that fail are the **same**.
Programmers will also be familiar with more complex conditionals
such as if-then-else, if-elseif-else, and "case",
which divide process execution across multiple "branches".

As a rule of thumb,
turning notes into a checklist will likely take
at least three times as long
as simply writing the notes.
If the checklist is for a wider audience,
expect it to take three times as long to write,
for the same reasons mentioned above for notes.

If a task is simple
and I can hold all the steps in my head,
and I can finish it in one sitting without distractions,
then I won't bother with a checklist.
But more and more I find myself writing myself a checklist
before I begin any non-trivial tasks.
I use bullet points in my favourite text editor,
or sometimes the Notes app on my iPhone.
I lay out the steps in the expected order,
and I check them off as I go.
Sometimes I start making the checklist days before I need it,
so I have lots of time to think about it and improve it.
If there's a job that I'm worried about,
breaking it down into smaller pieces
usually helps to make the job feel more manageable.
Actually, I try to start every workday
by skimming my (long) To Do list,
picking the most important tasks,
and making a checklist for what I want to get done
by quitting time.

##### 3. Checkscript

"Checkscript" is a word that I think I made up,
based on insights from a couple of sources,
primarily this blog post on
["Do-nothing scripting: the key to gradual automation"](https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/)
This is where "real" automation kicks in,
writing "real" code and stuff,
but hopefully you'll see that it's just one more step
on the spectrum of automation that I'm describing.

The notes and checklists we've been discussing
are just text in your favourite text editor.
A checkscript is a program.
It can be written in whatever programming language you prefer.
I'll give examples in Posix Shell,
but that blog post uses Python,
and it really doesn't matter.
You start with a checklist
(in your mind at least).
The first version of your program
should just walk you through your checklist.
The program should walk you through each step of your checklist,
one by one.
That's it.

Here's a checkscript based on the example above.
It just prints the first step (`echo`),
waits for you to press any key (`read`),
then prints the next step, and so on.

```
###!/bin/sh

echo "1. Use Finder to filter for files with '2019' in the name"
read -p "Press enter to continue"

echo "2. Use finder to search file content for 'James'"
read -p "Press enter to continue"

echo "3. Open files in Text Edit and search for 'James'"
read -p "Press enter to continue"

echo "Done!"
```

So far this is just a more annoying way to use a checklist.
The magic happens once you break the steps down into small enough pieces
and realize that you know how to tell the computer
to do _some_ of the steps
instead of doing them all yourself.

For example,
you know that the command-line tool `grep`
is used for searching the contents of files,
and that you can use "fileglob"s to select
just the files that you want to search,
and that you can send the output of `grep`
to another file to read in your favourite text editor.
Now you know how to automate the first two steps.
The computer can just do that work without waiting for you:

```
###!/bin/sh

grep "James" *2019* > search_results.txt

echo "1. Open 'search_results.txt' in Text Edit and search for 'James'"
read -p "Press enter to continue"

echo "Done!"
```

Before we were using the Finder,
and it is possible to write code to tell the Finder
to filter and seach for files.
The key advantage of `grep` here
is that we send the search results to another file
that we can read now or save for later.

This is also a good time to mention the advantage of text files
over word processor files.
If the minutes were stored in Word files, for example,
then Finder could probably search them
and you could use Word to read them,
but you wouldn't be able to use `grep`
or easily output the results to another file.
Unix tools such as `grep` treat all text files the same,
whether they're source code or meeting minutes,
which means that these tools work pretty much the same on **any** text file.
By keeping your data in Word
you restrict yourself to a much smaller set of tools
and make it harder to automate you work
with simple scripts like this one.

Even if you can't get the computer
to run any of the steps for you automatically,
a checkscript can still be useful
by using variables instead of repeating yourself:

```
###!/bin/sh

FILE_PATTERN="*2019*"
FILE_CONTENTS="James"

echo "1. Use Finder to filter for files with '${FILE_PATTERN}' in the name"
read -p "Press enter to continue"

echo "2. Use finder to search file content for '${FILE_CONTENTS}'"
read -p "Press enter to continue"

echo "3. Open files in Text Edit and search for '${FILE_CONTENTS}'"
read -p "Press enter to continue"

echo "Done!"
```

Now if I want to search for "Becky"
I can just change the FILE_CONTENTS variable in one place.
I find this especially useful for dates and version numbers.

This is pretty simple for a checkscript,
with very few steps.
A more realistic example would be
if there were many directories containing the minutes of many meetings,
maybe in different file formats
and with different naming conventions.
In order to be sure that we're searching all of them
we might need a longer checkscript.

Writing and using a checkscript instead of a checklist
will likely take (you guessed it) about three times as long.
But the magic of the checkscript
is in the title of the blog post I mentioned:
"gradual automation".
Once you have a checkscript,
you can run through it all manually,
but you can also automate bits a pieces of the task,
saving yourself time and effort next time.

##### 5. Script

A "script" is a kind of program that's easy to edit and run.
There are technical distinctions to be made
between "compiled" programs and "interpreted" programs,
but they turn out to be more complicated and less helpful than they seem at first.
Technically, a checkscript is just a script
that waits for you to do the hard parts.
In this section I want to talk about "fully automated" or "standalone" scripts
that you just provide some input and execute.

Most useful programs are useful
because they call other programs (in the right ways).
I like shell scripts because they're basically just
commands that are copied and pasted
from work I was doing on the command-line.
It's really easy to call other programs.

To continue our example,
say that our minutes were stored in Word files.
There are Python libraries for this,
such as [python-docx](https://python-docx.readthedocs.io/en/latest/).
You can write a little script using this library
that works like `grep`
to search for specified text in selected files,
and output the results to a search results file.

As you add more and more functionality to a script
it can become unwieldy.
Scripts work best when they have a simple "flow"
from beginning to end.
They may have some conditionals and some loops,
but once you start seeing nested conditionals and loops,
then your script is doing too much.
There are two main options to consider:

1. break your script into smaller, simpler scripts
2. build a specialized tool: the next step on the spectrum of automation

The key difference between a checkscript and a "standalone" script
is handling problems.
A checkscript relies on you to supervise it.
A standalone script is expected to work properly without supervision.
So the script has to be designed to handle
a wider range of inputs
and fail gracefully when it gets into trouble.
This is a typical case of the "80% rule":
the last 20% takes 80% of the time.
As a rule of thumb,
expect it to take three times as long
to write a script that can run unsupervised
than it takes you to write a checkscript
that does "almost" the same thing.

##### 6. Specialized Tool

When your script needs nested conditionals and loops,
then it's probably time to reach for a programming language
that's designed to write code "in the large".
Some languages such as Python can make a pretty smooth transition
from a script in a single file
to a set of files in a module,
working together nicely.
You might also choose another language
that can provide better performance or efficiency.

It's not just the size and the logical complexity of your script,
consider its **purpose**.
The specialized tools that I have in mind
have a clear purpose that helps guide their design.
This also makes them easier to reuse
across multiple projects.

I often divide my specialized tools into two parts:
a library and a command-line interface.
The library can be used in other programs,
and contains the most distinctive and important functionality.
But the command-line interface is essential,
because it lets me use my specialized tool
in the shell and in scripts,
so I can build more automation on top of it.

Writing a tool in Java or C++ or Rust
usually takes longer than a script in shell or Python
because there are more details to worry about
such as types and efficient memory management.
In return you usually get more reliability and efficiency.
But as a rule of thumb,
expect it to take three times as long
to write a specialized tool
than it would to "just" write the script.
On the other hand,
if you already have a script that does most of what you want,
and you're already familiar with the target you are moving to,
then it can be fairly straightforward to translate
from the script to the specialized tool.
That's why it's often most efficient
to write a prototype script first,
do lots of quick experiments to explore the design space,
and when you're happy with the design
then start on the "production" version.

##### 7. Workflow

The last step in the spectrum of automation
is to bring together all your scripts
into a single "workflow".
My favourite tool for this is the venerable
[Make](https://www.gnu.org/software/make/).
A `Makefile` is essentially a bunch of small scripts
with their input and output files carefully specified.
When you ask Make to build a given output file,
it will look at the whole tree of scripts,
figure out which input files are required to build your requested output file,
then which files are required to build _those_ files,
and so on until it has determined a sequence of steps.
Make is also smart enough to check whether some of the dependencies
are already up-to-date,
and can skip those steps.
Looking at a `Makefile` you can see everything
broken down into simple steps
and organized into a tree,
through which you can trace various paths.
You can make changes at any point,
and run Make again to update your project.

I've done this all so many times
that now I often start with a `Makefile` in an empty directory
and build from there.
I try experiments on the command line.
I make notes.
I break the larger task into parts with a checklist.
I automate the easy parts first,
and leave some parts as manual steps with instructions.
I write little scripts in the `Makefile`.
I write larger scripts in the `src/` directory.
If these get too big or complex,
I start thinking about building a specialized tool.
(And of course, I store everything in version control.)
It takes more time at the beginning,
but I think that I usually save time later,
because I have a nice place to put everything from the start.

In other words, I start thinking about automation
at the very beginning of the project,
assuming from the start that it will grow,
and that I'll need to go back and change things.
With a mindset for automation,
from the start I'm thinking about how
the inputs I care about are the same and different,
which similarities I can use for my tests and code,
and which differences are important or unimportant.

#### Conclusion

In the end, my project isn't ever completely automated.
It doesn't "act of itself".
But by making everything clear and explicit
I'm telling the computer how to do a lot of the work
and other humans (or just my future self)
how to do the rest of it.
The final secret of automation,
especially when it comes to software and data,
is **communication**:
expressing things clearly for humans and machines
so they can see and do **exactly** what you did.

### Scientific Computing: An Overview

By: [James Overton](https://orcid.org/0000-0001-5139-5557)

By "scientific computing" we mean
using computers to help with key aspect of science
such as data collection, cleaning, interpretation, analysis, and visualization.
Some people use "scientific computing" to mean something more specific,
focusing on computational modelling or computationally intensive analysis.
We'll be focusing on more general and day-to-day topics:
how can a scientist make best use of a computer
to do their work well?

These three things apply to lots of fields,
but are particularly important to scientists:

- reliability
- reproducibility
- communication

It should be no surprise that
automation can help with all of these.
When working properly, computers make fewer mistakes than people,
and the mistakes they do make are more predictable.
If we're careful, our software systems can be easily reproduced,
which means that an entire data analysis pipeline can be copied
and run by another lab to confirm the results.
And scientific publications are increasingly including data and code
as part of the review and final publication process.
Clear code is one of the best ways to communicate detailed steps.

Automation is critical to scientific instruments and experiments,
but we'll focus on the data processing and analysis side:
after the data has been generated,
how should you deal with it.

Basic information management is always important:

- community standard file formats
- consistent file naming
- documentation, READMEs
- backups
- version control

More advanced data management is part of this course:

- consistent use of versioned
  - software
  - reference data
- terminology
  - controlled vocabularies
  - data dictionaries
  - ontologies

Some simple rules of thumb can help reduce complexity and confusion:

- make space
- firm foundations
- one-way data flow
- plan for change
- test from the start
- documentation is also for you

#### Make Space

When starting a new project,
make a nice clean new space for it.
Try for that "new project smell".

- I always create a new directory on my computer.
- I almost always create a new GitHub repository.
- I usually create a README and a Makefile, right away.

It's not always clear when a project is really "new"
or just a new phase of an old project.
But try to clear some space to make a fresh start.

#### Firm Foundations

A lot of data analysis starts with a reference data set.
It might be a genome or a proteome.
It might be a corpus.
It might be a set of papers or data from those papers.

Start by finding that data
and selecting a particular version of it.
Write that down clearly in your notes.
If possible, include a unique identifier such as a ([persistent](https://en.wikipedia.org/wiki/Persistent_uniform_resource_locator)) URL or DOI.
If that's not possible, write down the steps you took.
If the data isn't too big,
keep a copy of it in your fresh new project directory.
If the data is a bit too big,
keep a compressed copy in a `zip` or `gz` file.
A lot of software is perfectly happy to read directly from compressed files,
and you can compress or uncompress data using piped commands in your shell or script.
If the data is really too big,
then be extra careful to keep notes
on **exactly** where you can find it again.
Consider storing just the
[hashes](https://en.wikipedia.org/wiki/Hash_function)
of the big files,
so you can confirm that they have exactly the same contents.

If you know from the start
that you will need to compare your results with someone else's,
make sure that you're using the **same** reference data
that they are.
This may require a conversation,
but trust me that it's better to have this conversation now than later.

#### One-Way Data Flow

It's much easier to think about processes
that flow in one direction.
Branches are a little trickier, but usually fine.
The real trouble comes with loops.
Once a process loops back on itself
it's much more difficult to reason about what's happening.
Loops are powerful,
but with great power comes great responsibility.
Keep the systems you design
as simple as possible
(but no simpler).

In practical terms:

- Try not to read then write to the same file.
  If you have to, try to append rather than overwrite.
  This is one reason why I prefer tables on disk to databases.
- Don't hesitate to write intermediate files.
  These are very useful for testing and debugging.
  When you're "finished" you can comment out these steps.

#### Plan for Change

It's very tempting:
you could automate this step,
or you could just do it manually.
It might take three times as long to automate it, right?
So you can save yourself some precious time
by just opening Excel and "fixing" things by hand.

Sometimes that bet will pay off,
but I lose that bet most of the time.
I tend to realize my mistake only at the last minute.
The submission deadline is tomorrow
but the core lab "fixed" something
and they have a new version of the dataset
that we need to use for the figures.
Now I _really_ don't have time to automate,
so I'm up late clicking through Excel again
and hoping that I remembered to redo
all the changes that I made last time.

Automating the process would have actually saved me time,
but more importantly it would have avoided a lot of stress.
By now I should know that the dataset
will almost certainly be revised at the last minute.
If I have the automation set up,
then I just update the data,
run the automation again,
and quickly check the results.

#### Test from the Start

Tests are another thing that take time to implement.

One of the key benefits to tests is (again) communication.
When assessing or trying out some new piece of software
I often look to the test files to see examples
of how the code is really used,
and the shape of the inputs and outputs.

There's a spectrum of tests
that apply to different parts of your system:

- unit tests: individual functions and methods
- regression tests: ensure that fixed bugs do not reappear
- integration tests: end-to-end functionality
- performance tests: system speed and resource usage
- acceptance tests: whether the overall system meets its design goals

Tests should be automated.
The test suite should either pass or fail,
and if it fails something needs to be fixed
before any more development is done.
The automated test suite should run
before each new version is committed to version control,
and ideally more often during development.

Tests come with costs:

- development cost of writing the tests
- time and resources spent running the tests
- maintenance costs of updating the tests

The first is obvious but the other two often more important.
A slow test suite is annoying to run,
and so it won't get run.
A test suite that's hard to update won't get updated,
and then failures will be ignored,
which defeats the entire purpose.

#### Documentation is also for You

I tend to forget how bad a memory I have.
In the moment, when I'm writing brilliant code
nothing could be more obvious than the perfect solution
that is pouring forth from my mind all over my keyboard.
But when I come back to that code weeks, months, or years later,
I often wonder what the heck I was thinking.

We think about the documentation we write as being for other people,
but for a lot of small projects
it's really for your future self.
Be kind to your future self.
They may be even more tired, even more stressed than you are today.

There's a range of different forms of documentation,
worth a whole discussion of its own.
I like this [four-way distinction](https://diataxis.fr):

- tutorials: getting started, basic concepts, an overview
- how-to guides: how to do common tasks
- explanation: why does it work this way?
- reference: looking up the details

You don't need all of these for your small project,
but consider a brief explanation of why it works the way it does
(aimed at a colleague who knows your field well),
and some brief notes on how-to do the stuff this project is for.
These could both go in the README of a small project.

## Additional materials and resources

- [A whirlwind introduction to the command line](https://github.com/jamesaoverton/command-line)
- [Programming with Python](https://swcarpentry.github.io/python-novice-inflammation/)
- [Oh My Git!](https://ohmygit.org)

## Contributors

- [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)
- [James Overton](https://orcid.org/0000-0001-5139-5557)
