# Scientific Computing

By: [James Overton](https://orcid.org/0000-0001-5139-5557)

By "scientific computing" we mean
using computers to help with key aspect of science
such as data collection, cleaning, interpretation, analysis, and visualization.
Some people use "scientific computing" to mean something more specific,
focusing on computational modelling or computationally intensive analysis.
We'll be focusing on more general and day-to-day topics:
how can a scientist make best use of a computer
to do her work well?

These three things apply to lots of fields,
but are particularly important to scientists:

- reliability
- reproducibility
- communication

It should be no surprise that
[automation](automation.md)
can help with all of these.
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

## Make Space

When starting a new project,
make a nice clean new space for it.
Try for that "new project smell".
I always create a new directory on my computer.
I almost always create a new GitHub repository.
I usually create a README and a Makefile, right away.

It's not always clear when a project is really "new"
or just a new phase of an old project.
But try to clear some space to make a fresh start.

## Firm Foundations

A lot of data analysis starts with a reference data set.
It might be a genome or a proteome.
It might be a corpus.
It might be a set of paper or data from those papers.

Start by finding that data
and selecting a particular version of it.
Write that down clearly in your notes.
If possible, include a unique identifier such as a URL or DOI.
If that's not possible, write down the steps you took.
If the data isn't too big,
keep a copy of it in your fresh new project directory.
If the data is a bit too big,
keep a compressed copy in a `zip` or `gz` file.
A lot of software is perfectly happy to read directly from compressed files,
and you can compress or uncompress data using piped commands in your shell or script.
If the data is really to big,
then be extra careful to keep notes
on **exactly** where you can find it again.
Consider storing just the
[hashes](https://en.wikipedia.org/wiki/Hash_function)
of the big files,
so you can confirm that they have exactly the same contents.

If you know from the start
that you will need to compare you results with some other group,
make sure that you're using the **same** reference data
that they are.
This may require a conversation,
but trust me that it's better to have this conversation now than later.

## One-Way Data Flow

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

## Plan for Change

It's very tempting:
you could automate this step,
or you could just do it manually.
It might take three times as long to automate it, right?
So you can save yourself some precious time
but just opening Excel and "fixing" things by hand.

Sometimes that bet will pay off,
but I lose that bet most of the time.
I tend to realize my mistake only at the last minute.
The submission deadline is tomorrow
but the core lab "fixed" something
and they have a new version of the dataset
that we need to use for the figures.
Now I *really* don't have time to automate,
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

## Test from the Start

Tests are another thing that take

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

## Documentation is also for You

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
She may be even more tired, even more stressed than you are today.

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


