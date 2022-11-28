# ROBOT Mini-Tutorial 1: Convert, Extract and Template

Last week, we were introduced to ROBOT for quality control and generating reports about terms in an ontology. This week, we will learn about three new ROBOT commands:

- Convert
- Extract
- Template

Before starting this tutorial, either:

- make sure Docker is running and you are in the container
- [download and install ROBOT](http://robot.obolibrary.org/) for your operating system

We will be using the files from the [Ontologies 101 Tutorial](https://github.com/OHSUBD2K/BDK14-Ontologies-101).
In your terminal, navigate to the repository that you cloned and then into the `BDK14_exercises` folder.

## Convert

So far, we have been saving our ontologies in Protege using the default RDF/XML syntax, but there are many flavors of OWL.
We will discuss each of these serializations in more detail during the class session, but ROBOT supports the following:

- owl - RDF/XML
- owx - OWL/XML
- ttl - Turtle
- obo - OBO Format
- ofn - OWL Functional
- omn - OWL Manchester
- json - obographs JSON

### Let's Try It!

Navigate to the `basic-subclass/` folder. Open `chromosome-parts.owl` in your text editor and you will see it's in RDF/XML format.
We're going to take this file and convert it to Turtle (`ttl`) serialization. Return to your terminal and enter the following command:

```
robot convert --input chromosome-parts.owl --format ttl --output chromosome-parts.ttl
```

ROBOT convert is smart about detecting formats, so since the output file ends with `.ttl`, the `--format ttl` parameter isn't really required.
If you wanted to use a different file ending, say `.owl`, you will need to include the format flag to force ROBOT to write Turtle.

Now open `chromosome-parts.ttl` in your text editor and see what's changed!
RDF/XML and Turtle are very different serializations, but the actual data that is contained in these two files is exactly the same.

### On Your Own

1. Convert `chromosome-parts.owl` into the following formats: `obo` (OBO Format), `ofn` (OWL Functional), and `omn` (OWL Manchester).
2. Open each file and take a minute to scroll through (we don't expect you to be able to read these, they're _mostly_ meant for computers!)
3. Why do you think we need these different serializations? What do you think the purpose of OWL Manchester vs. RDF/XML is?

---

## Extract

Sometimes we only want to browse or share a subset of an ontology, especially with some of the larger OBO Foundry ontologies.
There are two main methods for creating subsets:

- MIREOT
- SLME

Right now, we will use use MIREOT and talk more about SLME in our class session.
MIREOT makes sure that you have the _minimal_ amount of information you need to reuse an existing ontology term.
It allows us to extract a small portion of the class hierarchy by specifying upper and lower boundaries, which you will see in the example below.
We need to know the identifiers (as CURIEs) of the terms that we want to set as our boundaries.

### Let's Try It!

Open `chromosome-parts.owl` in Protege and open the Class hierarchy. We are going to create a subset relevant to the term "chromosome".
First, we will find the CURIE of our desired term. Search for "chromosome" and find the "id" annotation property. This will be our lower term.
Right now, we won't set an upper boundary. That means this subset will go all the way up to the top-level ancestor of "chromosome".

Return to your terminal and enter the following command (where the `--lower-term` is the CURIE that we just found):

```
robot extract --method MIREOT --input chromosome-parts.owl --lower-term GO:0005694 --output chromosome-full.owl
```

Now open `chromosome-full.owl` in Protege and open the Class hierarchy. When you open the "cellular_component" node, you'll notice that most of the terms are gone!
Both "organelle" and "intracellular part" remain because they are in the path between "chromosome" and the top-level "cellular_component".
Keep clicking down and you'll find "chromosome" at the very bottom.
Since "chromosome" has two named parents, both of those parents are included, which is why we ended up with "organelle" and "intracellular part".

Now let's try it with an upper term. This time, we want "organelle" to be the upper boundary. Find the CURIE for "organelle".

Return to your terminal and enter the following command (where the `--upper-term` is the new CURIE we just found):

```
robot extract --method MIREOT \
  --input chromosome-parts.owl \
  --lower-term GO:0005694 \
  --upper-term GO:0043226 \
  --output chromosome.owl
```

Open `chromosome.owl` and again return to the Class hierarchy. This time, we see "organelle" directly below `owl:Thing`.
"intracellular part" is also now missing because it does not fall under "organelle".

### On Your Own

1. Play with different upper- and lower-level terms to create different subsets
2. Compare the terms that are in the subsets to the terms in the original `chromosome-parts.owl` file.
3. What is missing from the terms in the subsets? What has been included as our "minimal" information?

---

## Template

Most of the knowledge encapsulated in ontologies comes from domain experts.
Often, these domain experts are not computer scientists and are not familiar with the command line.
Luckily, most domain experts _are_ familiar with spreadsheets!

ROBOT provides a way to convert spreadsheets into OWL ontologies using _template strings_. We'll get more into these during the class session, but if you want to get a head start, they are all [documented here](http://robot.obolibrary.org/template#template-strings).
Essentially, the first row of a ROBOT template is a human-readable header. The second row is the ROBOT template string.
Each row below that represents an entity to be created in the output ontology. We can create new entities by giving them new IDs, but we can also reference existing entities just by label.
For now, we're going to create a new, small ontology with new terms using a template.

### Let's Try It!

Download (or copy/paste) the [animals.tsv](robot_tutorial_1/animals.tsv) file and move it to the `basic-subclass/` folder (or whatever folder you would like to work in; we will not be using any of the Ontology 101 files anymore).
This contains the following data:

| CURIE       | Label  | Parent | Comment                      |
| ----------- | ------ | ------ | ---------------------------- |
| ID          | LABEL  | SC %   | A rdfs:comment               |
| obo:0000001 | animal |        | Any animal in the world.     |
| obo:0000002 | canine | animal | A member of the genus Canis. |
| obo:0000003 | feline | animal | A member of the genus Felis. |

In the first column, we use the special `ID` keyword to say that this is our term's unique identifier.
The second column contains the `LABEL` keyword which is a shortcut for the `rdfs:label` annotation property.
The third column uses the `SC` keyword to state that this column will be a subclass statement. The `%` sign is replaced by the value in the cell.
We'll talk more about this keyword and the `%` symbol during the class session.
Finally, the last column begins with `A` to denote that this will be an annotation, and then is followed by the annotation property we're using.

Just looking at the template, you can begin to predict what a class hierarchy using these terms would look like in an ontology. We can turn this into reality!

In your terminal, enter the following command:

```
robot template --template animals.tsv --output animals.owl
```

Note that in this command, we don't use the `--input` parameter. That parameter is reserved for input ontologies, and we are not using one right now. More on this later.

Open `animals.owl` in Protege, and you'll be able to see the class hierarchy we defined in the template as an actual structure.

Now let's make another small ontology that reuses some terms from our `animals.owl` file. Download (or copy/paste) [animals2.tsv](robot_tutorial_1/animals2.tsv) into the same folder.
This contains the following:

| CURIE       | Label | Parent | Comment                                            |
| ----------- | ----- | ------ | -------------------------------------------------- |
| ID          | LABEL | SC %   | A rdfs:comment                                     |
| obo:0000004 | dog   | canine | A member of the subspecies Canis lupus familiaris. |
| obo:0000005 | cat   | feline | A member of the species Felis catus.               |

You'll notice that we are referencing two terms from our other spreadsheet in this one.

In your terminal, enter the following command:

```
robot template --input animals.owl --template animals2.tsv --output animals2.owl
```

This time, we did use the `--input` parameter and provided the animals ontology we just created.
This allows us to use any term in the `animals.owl` file in our `animals2.tsv` template and ROBOT will know what we're talking about.

Go ahead and open `animals2.owl` in Protege. What's missing? The parent classes for "dog" and "cat" don't have labels, and the "animal" term is missing entirely.
This is because, even though ROBOT knew about these classes, we didn't ask for the original ontology to be included in the output, so no axioms from that ontology can be found in this newly-created one.
Next week, we'll learn about combining ontologies with the **Merge** command.

For now, let's add the original `animals.owl` file as an import:

1. Go to the "Active ontology" tab and find the "Imported ontologies" section at the bottom
2. Click the **+** next to "Direct imports"
3. Select "Import an ontology contained in a local file" and click Continue
4. Browse for the path to `animals.owl`, click Continue, and then click Finish

Protégé will now load `animals.owl` as an import. When you return to the Entities tab, you'll see all those upper-level terms. Note the difference in how the terms are displayed in the class hierarchy.

### On Your Own

1. Try adding another class or two to the `animals.tsv` template and regenerating `animals.owl`.
2. Can you create your own template?
