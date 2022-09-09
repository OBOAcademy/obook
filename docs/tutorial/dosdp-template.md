# Dead Simple Ontology Design Patterns (DOSDP)

Note: This is an updated Version of Jim Balhoff's DOSDP tutorial [here](https://github.com/INCATools/dosdp-tools/wiki/Generating-ontology-terms-using-a-pattern/_edit).

The main use case for `dosdp-tools` (and the [DOS-DP framework](https://github.com/dosumis/dead_simple_owl_design_patterns)) is managing a set of ontology terms, which all follow a common logical pattern, by simply collecting the unique aspect of each term as a line in a spreadsheet. For example, we may be developing an ontology of environmental exposures. We would like to have terms in our ontology which represent exposure to a variety of stressors, such as chemicals, radiation, social stresses, etc.

## Creating an ontology of environmental exposures

To maximize reuse and facilitate data integration, we can build our exposure concepts by referencing terms from domain-specific ontologies, such as the [Chemical Entities of Biological Interest Ontology (ChEBI)](https://www.ebi.ac.uk/chebi/) for chemicals. By modeling each exposure concept in the same way, we can use a reasoner to leverage the chemical classification provided by ChEBI to provide a classification for our exposure concepts. Since each exposure concept has a logical definition based on our data model for exposure, there is no need to manually manage the classification hierarchy. Let's say our model for exposure concepts holds that an "exposure" is an event with a particular input (the thing the subject is exposed to):

`'exposure to X' EquivalentTo 'exposure event' and 'has input' some X`

If we need an ontology class to represent 'exposure to sarin' (bad news!), we can simply use the term [sarin](http://purl.obolibrary.org/obo/CHEBI_75701) from ChEBI, and create a logical definition:

`'exposure to sarin' EquivalentTo 'exposure event' and 'has input' some sarin`

We can go ahead and create some other concepts we need for our exposure data:

`'exposure to asbestos' EquivalentTo 'exposure event' and 'has input' some asbestos`

`'exposure to chemical substance' EquivalentTo 'exposure event' and 'has input' some 'chemical substance'`

These definitions again can reference terms provided by ChEBI: [asbestos](http://purl.obolibrary.org/obo/CHEBI_46661) and [chemical substance](http://purl.obolibrary.org/obo/CHEBI_59999)

## Classifying our concepts

Since the three concepts we've created all follow the same logical model, their hierarchical relationship can be logically determined by the relationships of the chemicals they reference. ChEBI asserts this structure for those terms:

```
'chemical substance'
         |
         |
   --------------
  |              |
  |              |
sarin        asbestos
```

Based on this, an OWL reasoner can automatically tell us the relationships between our exposure concepts:

```
        'exposure to chemical substance'
                       |
                       |
           --------------------------
          |                          |
          |                          |
'exposure to sarin'        'exposure to asbestos'
```

To support this, we simply need to declare the ChEBI OWL file as an `owl:import` in our exposure ontology, and use an OWL reasoner such as ELK.

## Managing terms with dosdp-tools

Creating terms by hand like we just did works fine, and relying on the reasoner for the classification will save us a lot of trouble and maintain correctness as our ontology grows. But since all the terms use the same logical pattern, it would be nice to keep this in one place; this will help make sure we always follow the pattern correctly when we create new concepts. We really only need to store the list of inputs (e.g. chemicals) in order to create all our exposure concepts. As we will see later, we may also want to manage separate sets of terms that follow other, different, patterns. To do this with `dosdp-tools`, we need three main files: a **pattern template**, a spreadsheet of **pattern fillers**, and a **source ontology**. You will also usually need a file of **prefix definitions** so that the tool knows how to expand your shortened identifiers into IRIs.

For our chemical exposures, getting the **source ontology** is easy: just download [chebi.owl](http://purl.obolibrary.org/obo/chebi.owl). _Note—it's about 450 MB._

For our **pattern fillers spreadsheet**, we just need to make a tab-delimited file containing the chemical stressors for which we need exposure concepts. The file needs a column for the term IRI to be used for the generated class (_this column is always called `defined_class`_), and also a column for the chemical to reference (_choose a label according to your data model_). It should look like this:

```
defined_class input
EXPOSO:1      CHEBI:75701
EXPOSO:2      CHEBI:46661
EXPOSO:3      CHEBI:59999
```

The columns should be tab-separated—you can download a [correctly formatted file](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/exposure_with_input.tsv) to follow along. For now you will just maintain this file by hand, adding chemicals by looking up their ID in ChEBI, and manually choosing the next ID for your generated classes. In the future this may be simplified using the [DOS-DP table editor](https://github.com/INCATools/table-editor), which is under development.

The trickiest part to DOS-DP is creating your **pattern template** (but it's not so hard). Pattern templates are written in [YAML](http://www.yaml.org), a simple file format based on keys and values. The keys are text labels; values can be plain values, another key-value structure, or a list. The DOS-DP schema specifies the keys and values which can be used in a pattern file. We'll use most of the common entries in this example. Read the comments (lines starting with #) for explanation of the various fields:

```yaml
# We can provide a name for this pattern here.
pattern_name: exposure_with_input

# In 'classes', we define the terms we will use in this pattern.
# In the OBO community the terms often have numeric IDs, so here
# we can provide human-readable names we can use further in the pattern.
# The key is the name to be used; the value is the ID in prefixed form (i.e. a CURIE).
classes:
  exposure event: ExO:0000002
  Thing: owl:Thing

# Use 'relations' the same way as 'classes',
# but for the object properties used in the pattern.
relations:
  has input: RO:0002233

# The 'vars' section defines the various slots that can be
# filled in for this pattern. We have only one, which we call 'input'.
# The value is the range, meaning the class of things that are valid
# values for this pattern. By specifying owl:Thing, we're allowing any
# class to be provided as a variable filler. You need a column in your
# spreadsheet for each variable defined here, in addition to the `defined class` column.
vars:
  input: "Thing"

# We can provide a template for an `rdfs:label` value to generate
# for our new term. dosdp-tools will search the source ontology
# to find the label for the filler term, and fill it into the
# name template in place of the %s.
name:
  text: "exposure to %s"
  vars:
    - input

# This works the same as label generation, but instead creates
# a definition annotation.
def:
  text: "A exposure event involving the interaction of an exposure receptor to %s. Exposure may be through a variety of means, including through the air or surrounding medium, or through ingestion."
  vars:
    - input

# Here we can generate a logical axiom for our new concept. Create an
# expression using OWL Manchester syntax. The expression can use any
# of the terms defined at the beginning of the pattern. A reference
# to the variable value will be inserted in place of the %s.
equivalentTo:
  text: "'exposure event' and 'has input' some %s"
  vars:
    - input
```

Download the [pattern template file](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/exposure_with_input.yaml) to follow along.

Now we only need one more file before we can run `dosdp-tools`. A file of **prefix definitions** (also in YAML format) will specify how to expand the CURIEs we used in our spreadsheet and pattern files:

```yaml
EXPOSO: http://example.org/exposure/
```

Here we are specifying how to expand our `EXPOSO` prefix (used in our spreadsheet `defined_class` column). To expand the others, we'll pass a convenience option to `dosdp-tools`, `--obo-prefixes`, which will activate some predefined prefixes such as `owl:`, and handle any other prefixes using the standard expansion for OBO IDs: `http://purl.obolibrary.org/obo/PREFIX_`. Here's a link to the [prefixes file](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/prefixes.yaml).

Now we're all set to run `dosdp-tools`! If you've downloaded or created all the necessary files, run this command to generate your ontology of exposures (assuming you've added the `dosdp-tools` to your Unix PATH):

```bash
dosdp-tools generate --obo-prefixes=true --prefixes=prefixes.yaml --infile=exposure_with_input.tsv --template=exposure_with_input.yaml --ontology=chebi.owl --outfile=exposure_with_input.owl
```

This will apply the pattern to each line in your spreadsheet, and save the result in an ontology saved at `exposure_with_input.owl` (it should look something [like this](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/exposure_with_input.owl)). If you take a look at this ontology in a text editor or in Protégé, you'll see that it contains three classes, each with a generated label, text definition, and equivalent class definition. You're done!

Well... you're sort of done. But wouldn't it be nice if your exposure ontology included some information about the chemicals you referenced? Without this our reasoner can't classify our exposure concepts. As we said above, we could add an `owl:import` declaration and load all of ChEBI, but your exposure ontology has three classes and ChEBI has over 120,000 classes. Instead, we can use the [ROBOT](https://github.com/ontodev/robot) tool to extract a module of just the relevant axioms from ChEBI. Later, we will also see how to use ROBOT to merge the outputs from multiple DOS-DP patterns into one ontology. You can download ROBOT from [its homepage](https://github.com/ontodev/robot).

## Extracting a module from the source ontology

ROBOT has a few different methods for extracting a subset from an ontology. We'll use the Syntactic Locality Module Extractor (SLME) to get a set of axioms relevant to the ChEBI terms we've referenced. ROBOT will need a file containing the list of terms. We can use a Unix command to get these out of our spreadsheet file:

```bash
sed '1d' exposure_with_input.tsv | cut -f 2 >inputs.txt
```

We'll end up with a simple list:

```
CHEBI:75701
CHEBI:46661
CHEBI:59999
```

Now we can use ROBOT to extract an SLME bottom module for those terms out of ChEBI:

```bash
robot extract --method BOT --input chebi.owl --term-file inputs.txt --output chebi_extract.owl
```

Our ChEBI extract only has 63 classes. Great! If you want, you can merge the ChEBI extract into your exposure ontology before releasing it to the public:

```bash
robot merge --input exposure_with_input.owl --input chebi_extract.owl --output exposo.owl
```

Now you can open `exposo.owl` in Protégé, run the reasoner, and see a correct classification for your exposure concepts! You may notice that your ontology is missing labels for `ExO:0000002` ('exposure event') and `RO:0002233` ('has input'). If you want, you can use ROBOT to extract that information from ExO and RO.

## Working with multiple patterns

You will often want to generate ontology modules using more than one DOS-DP pattern. For example, you may want to organize environmental exposures by an additional axis of classification, such as exposure to substances with various biological roles, based on information provided by ChEBI. This requires a slightly different logical expression, so we'll make a [new pattern](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/exposure_with_input_with_role.yaml):

```yaml
pattern_name: exposure_with_input_with_role

classes:
  exposure event: ExO:0000002
  Thing: owl:Thing

relations:
  has input: RO:0002233
  has role: RO:0000087

vars:
  input: "Thing"

name:
  text: "exposure to %s"
  vars:
    - input

def:
  text: "A exposure event involving the interaction of an exposure receptor to a substance with %s role. Exposure may be through a variety of means, including through the air or surrounding medium, or through ingestion."
  vars:
    - input

equivalentTo:
  text: "'exposure event' and 'has input' some ('has role' some %s)"
  vars:
    - input
```

Let's create an [input file](https://raw.githubusercontent.com/INCATools/dosdp-tools/master/src/test/resources/tutorial/exposure_with_input_with_role.tsv) for this pattern, with a single filler, [neurotoxin](http://purl.obolibrary.org/obo/CHEBI_50910):

```
defined_class	input
EXPOSO:4	CHEBI:50910
```

Now we can run `dosdp-tools` for this pattern:

```bash
dosdp-tools generate --obo-prefixes --prefixes=prefixes.yaml --infile=exposure_with_input_with_role.tsv --template=exposure_with_input_with_role.yaml --ontology=chebi.owl --outfile=exposure_with_input_with_role.owl
```

We can re-run our ChEBI module extractor, first appending the terms used for this pattern to the ones we used for the first pattern:

```bash
sed '1d' exposure_with_input_with_role.tsv | cut -f 2 >>inputs.txt
```

And then run `robot extract` exactly as before:

```bash
robot extract --method BOT --input chebi.owl --term-file inputs.txt --output chebi_extract.owl
```

Now we just want to merge both of our generated modules, along with our ChEBI extract:

```bash
robot merge --input exposure_with_input.owl --input exposure_with_input_with_role.owl --input chebi_extract.owl --output exposo.owl
```

If you open the new `exposo.owl` in Protégé and run the reasoner, you'll now see 'exposure to sarin' classified under both 'exposure to chemical substance' and also 'exposure to neurotoxin'.

## Conclusion

By using `dosdp-tools` and `robot` together, you can effectively develop ontologies which compose parts of ontologies from multiple domains using standard patterns. You will probably want to orchestrate the types of commands used in this tutorial within a Makefile, so that you can automate this process for easy repeatability.
