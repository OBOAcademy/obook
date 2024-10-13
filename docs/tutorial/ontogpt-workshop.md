# Using OntoGPT in practice

OntoGPT is useful for extracting structured data from loosely-structured text and grounding it to consistent identifiers.

Because it is an interface for LLMs, OntoGPT can also help to automate otherwise tedious formatting and data cleaning tasks.

[The full OntoGPT documentation may be found here.](https://monarch-initiative.github.io/ontogpt/)

The examples below demonstrate how to do the following:

1. Set up OntoGPT
2. Assemble a custom schema for extracting concepts (and then run it)
3. Assemble a custom schema for extracting relationships (and then run that, too)
4. Examine the results

## Setup

OntoGPT requires Python 3.9 or greater to be installed. It also requires access to an LLM, either through an API or a local model.

OntoGPT may be installed with `pip`:

```bash
pip install ontogpt
```

This tutorial uses OntoGPT version 1.0.6.

To set an API key (in this case, for OpenAI), run the following:

```bash
runoak set-apikey -e openai <your openai api key>
```

Alternatively, you may run this:

```bash
export OPENAI_API_KEY=<your openai api key>
```

### Using a local model

OntoGPT works with local models through the `ollama` package.

[Full setup instructions are in the OntoGPT docs](https://monarch-initiative.github.io/ontogpt/setup/), but in brief:

1. Install ollama [as described on their GitHub repository](https://github.com/ollama/ollama).
2. Download a local model, e.g., for `llama3` run `ollama pull llama3`.
3. Ensure the ollama service is running so OntoGPT can access it. This may require a command like `ollama serve`.
4. In OntoGPT commands below, specify the local model with the `--model` option, e.g., `--model ollama/llama3`.

## Extract concepts

Let's use OntoGPT to extract the names of vertebrate animals and ground them to the Vertebrate Breed Ontology (VBO).

We'll start with an example text - copy and paste the following into a document named `pigeons.txt`.

```text
The Fantail is a popular breed of pigeon known for its distinctive fan-shaped tail feathers and comes in a variety of colors, including white, black, and gray.
The Jacobin is another well-known breed, characterized by its distinctive crest and hood of feathers around its head and neck.
The Homing Pigeon, also known as the Racing Homer, is a breed prized for its speed and navigational abilities, with some individuals able to fly at speeds of up to 80 km/h.
```

Next, create a document named `vbo_names.yaml`. This will be our first extraction schema.

It should contain the following:

```yaml
id: http://w3id.org/ontogpt/vbo_names
name: vbo_names
title: Extraction Template for Animal Names
description: >-
  An extraction template for animal names present in VBO
license: https://creativecommons.org/publicdomain/zero/1.0/
prefixes:
  rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
  linkml: https://w3id.org/linkml/
  vbo_names: http://w3id.org/ontogpt/vbo_names
  vbo: http://purl.obolibrary.org/obo/vbo

default_prefix: vbo_names
default_range: string

imports:
  - linkml:types
  - core

classes:
  NameSet:
    tree_root: true
    is_a: NamedEntity
    attributes:
      animal_names:
        range: AnimalName
        multivalued: true
        description: >-
          A semicolon-separated list of names of animals
          used in the input text. These are general names,
          e.g., if any breed of cat is mentioned, this
          list should include "Cat breed", or for any pig,
          include "Pig breed".
      names:
        range: BreedName
        multivalued: true
        description: >-
          A semicolon-separated list of names of animal breeds
          used in the input text. These should be as specific
          as possible about the breed of the animal.
          Examples include:
          Gimbsheimer Enten, Debao pony, Baixi

  AnimalName:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:vbo
      prompt: >-
        The name of a grouping category of vertebrate
        animal breeds.

  BreedName:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:vbo
      prompt: >-
        The name of a vertebrate animal breed.

```

Note that this schema includes a root class (`NameSet`) with two slots, each intended to contain a list of extracted names.

We use the two different classes (`AnimalName` and `BreedName`) to extract two different types of entities: general names such as "Pigeon" and more specific breed names.

This reflects the structure and format of VBO, allowing us to provide instructions to the LLM to get better grounding, and it allows us to capture instances where animal names aren't described in as much detail as we may like.

Each of the classes will be annotated with `sqlite:obo:vbo` - this is shorthand for "the SQLite version of VBO as provided by the OBO Foundry". This will be downloaded when OntoGPT needs it.

If you had a local file for VBO, such as `vbo.obo`, you could use that as the annotator here instead of `sqlite:obo:vbo`.

You may also use multiple annotators - for example, this value could be `sqlite:obo:vbo, sqlite:obo:vto`.

VBO already contains NCBI Taxonomy identifiers, so these may be included in our grounded identifiers.

To run the extraction - assuming this new extraction template and the `pigeons.txt` input file are in the current directory, run this command:

```bash
ontogpt extract -i pigeons.txt -t vbo_names.yaml
```

After a few seconds, you should get a result like the following:

```yaml
---
input_text: |+
  The Fantail is a popular breed of pigeon known for its distinctive fan-shaped tail feathers and comes in a variety of colors, including white, black, and gray.
  The Jacobin is another well-known breed, characterized by its distinctive crest and hood of feathers around its head and neck.
  The Homing Pigeon, also known as the Racing Homer, is a breed prized for its speed and navigational abilities, with some individuals able to fly at speeds of up to 80 km/h.

raw_completion_output: |-
  animal_names: Pigeon breed
  names: Fantail; Jacobin; Homing Pigeon; Racing Homer
  label:
prompt: |+
  From the text below, extract the following entities in the following format:

  animal_names: <A semicolon-separated list of names of animals used in the input text. These are general names, e.g., if any breed of cat is mentioned, this list should include "Cat breed", or for any pig, include "Pig breed".>
  names: <A semicolon-separated list of names of animal breeds used in the input text. These should be as specific as possible about the breed of the animal. Examples include: Gimbsheimer Enten, Debao pony, Baixi>
  label: <The label (name) of the named thing>


  Text:
  The Fantail is a popular breed of pigeon known for its distinctive fan-shaped tail feathers and comes in a variety of colors, including white, black, and gray.
  The Jacobin is another well-known breed, characterized by its distinctive crest and hood of feathers around its head and neck.
  The Homing Pigeon, also known as the Racing Homer, is a breed prized for its speed and navigational abilities, with some individuals able to fly at speeds of up to 80 km/h.



  ===

extracted_object:
  id: ca691ef7-4073-4339-9101-99e6ce8a8340
  animal_names:
    - VBO:0400015
  names:
    - VBO:0013279
    - AUTO:Jacobin
    - AUTO:Homing%20Pigeon
    - VBO:0016851
named_entities:
  - id: VBO:0400015
    label: Pigeon breed
  - id: VBO:0013279
    label: Fantail
    original_spans:
      - 4:10
  - id: AUTO:Jacobin
    label: Jacobin
    original_spans:
      - 164:170
  - id: AUTO:Homing%20Pigeon
    label: Homing Pigeon
    original_spans:
      - 291:303
  - id: VBO:0016851
    label: Racing Homer
    original_spans:
      - 324:335
```

The `raw_completion_output` field contains the LLM's generated response, before any of these terms are grounded to unique identifiers.

The list of animal names includes `VBO:0400015` (Pigeon breed), as expected.

Of the three pigeon breeds mentioned in the text, two are grounded to VBO CURIEs.

VBO contains a term for the Jacobin (`VBO:0001216`) but refers to it as the "Danish Jacobin Pigeon" - not close enough to match in this case.

## Extract relationships

Let's take this extraction a step further and identify relationships between animal breeds and their characteristics.

We can edit the existing extraction schema from above (`vbo_names.yaml`):

```yaml
id: http://w3id.org/ontogpt/vbo_char
name: vbo_char
title: Extraction Template for Animal Breeds and their Characteristics
description: >-
  An extraction template for animal names present in VBO,
  along with the characteristics of each breed
license: https://creativecommons.org/publicdomain/zero/1.0/
prefixes:
  rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
  linkml: https://w3id.org/linkml/
  vbo_char: http://w3id.org/ontogpt/vbo_char
  vbo: http://purl.obolibrary.org/obo/vbo

default_prefix: vbo_char
default_range: string

imports:
  - linkml:types
  - core

classes:
  NameSet:
    tree_root: true
    is_a: NamedEntity
    attributes:
      animal_names:
        range: AnimalName
        multivalued: true
        description: >-
          A semicolon-separated list of names of animals
          used in the input text. These are general names,
          e.g., if any breed of cat is mentioned, this
          list should include "Cat breed", or for any pig,
          include "Pig breed".
      names:
        range: BreedName
        multivalued: true
        description: >-
          A semicolon-separated list of names of animal breeds
          used in the input text. These should be as specific
          as possible about the breed of the animal.
          Examples include:
          Gimbsheimer Enten, Debao pony, Baixi
      characteristics:
        range: BreedToCharacteristic
        multivalued: true
        inlined: true
        inlined_as_list: true
        description: >-
          A semicolon-separated list of names of animal breeds
          used in the input text, along with a single characteristic
          mentioned for that breed. These should be as specific
          as possible about the breed of the animal. The characteristic
          may be color, dimensions, physical properties, abilities,
          or other features. Each statement should contain just one
          pair of breed name and characteristic.
          It should be formatted as
          "Breed IS Characteristic", or "Breed HAS Characteristic",
          e.g., Gimbsheimer Enten IS blue,
          Debao pony IS short,
          Baixi IS circular
          Each additional characteristic for a breed should get
          its own statement, e.g., "breed name is tall and wide"
          should become "Breed IS tall" and "Breed is wide".

  AnimalName:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:vbo
      prompt: >-
        The name of a grouping category of vertebrate
        animal breeds.

  BreedName:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:vbo
      prompt: >-
        The name of a vertebrate animal breed.

  Characteristic:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:uberon, sqlite:obo:pato
      prompt: >-
        The name of a characteristic of an animal.

  Descriptor:
    is_a: NamedEntity
    annotations:
      annotators: sqlite:obo:pato
      prompt: >-
        A descriptor for a characteristic.

  BreedToCharacteristic:
    is_a: Triple
    description: >- 
      A triple in which the subject is an animal breed,
      the object is a characteristic, and the predicate
      is usually "IS" or "HAS".
    slot_usage:
      subject:
        range: BreedName
      object:
        description: >-
          The specific characteristic.
          This is generally a noun of the characteristic,
          e.g., with "blue fin" the object is "fin".
        range: Characteristic
      predicate:
        range: NamedEntity
        description: >-
          The relationship type, generally IS or HAS to indicate a breed
          is defined by having a specific characteristic.
      subject_qualifier:
        range: NamedEntity
        description: >-
          An optional qualifier or modifier for the breed.
      object_qualifier:
        range: Descriptor
        description: >-
          An optional qualifier or modifier for the characteristic.
          This is generally a descriptor of the characteristic,
          e.g., with "blue fin" the qualifier is "blue".

```

Save this as `vbo_char.yaml`.

We may now run this as before:

```bash
ontogpt extract -i pigeons.txt -t vbo_char.yaml
```

The output will be quite a bit longer, and it will resemble that from before (no surprises here - it's extracting the same material and more).

The extracted characteristic relationships may look like so:

```yaml
  characteristics:
    - subject: VBO:0013279
      predicate: AUTO:HAS
      object: UBERON:0018537
    - subject: AUTO:Jacobin
      predicate: AUTO:HAS
      object: UBERON:4200133
    - subject: AUTO:Jacobin
      predicate: AUTO:HAS
      object: UBERON:0000022
    - subject: AUTO:Homing%20Pigeon
      predicate: AUTO:IS
      object: AUTO:fast
    - subject: AUTO:Homing%20Pigeon
      predicate: AUTO:HAS
      object: AUTO:abilities
```

## Extracting from other sources

OntoGPT can use PubMed citations and PubMed Central full texts as its inputs with the `pubmed-annotate` command, from Wikipedia pages with the `wikipedia-extract` command, or from web pages with the `web-extract` command.

Here, we'll re-use the extraction schema from above, but with the `web-extract` command and a page about Fengjing pigs (https://breeds.okstate.edu/swine/fengjing-swine.html).

Run the following:

```bash
ontogpt web-extract -t vbo_char.yaml https://breeds.okstate.edu/swine/fengjing-swine.html
```

This will produce quite a verbose output, with an extracted set of values like this:

```yaml
extracted_object:
  id: 9afe16d9-9f4c-4596-943d-bbf5a124a236
  label: Fengjing Swine
  animal_names:
    - VBO:0001199
    - NCBITaxon:9823
  names:
    - VBO:0012847
    - VBO:0001175
    - VBO:0012819
  characteristics:
    - subject: VBO:0012847
      predicate: IS
      object: UBERON:0001456
    - subject: VBO:0012847
      predicate: IS
      object: UBERON:0001003
    - subject: VBO:0012847
      predicate: IS
      object: growing
    - subject: VBO:0012847
      predicate: IS
      object: UBERON:0001013
    - subject: VBO:0012847
      predicate: IS
      object: GO:0050909
    - subject: VBO:0012847
      predicate: IS
      object: diseases
    - subject: VBO:0012847
      predicate: IS
      object: ability
    - subject: Fengjing Sows
      predicate: IS
      object: high
    - subject: Fengjing Sows
      predicate: ARE
      object: UBERON:0001443
    - subject: Fengjing Sows
      predicate: ARE
      object: live-weight
    - subject: Fengjing Sows
      predicate: HAS
      object: backfat thickness
    - subject: VBO:0012847
      predicate: HAS
      object: percentage
    - subject: VBO:0012847
      predicate: IS
      object: prolific
    - subject: Fengjing Sows
      predicate: HAVE
      object: PATO:0000161
    - subject: Fengjing Sows
      predicate: HAS
      object: PATO:0000276
    - subject: Fengjing Sows
      predicate: HAVE
      object: litters
    - subject: Fengjing Sows
      predicate: HAVE
      object: PATO:0000128
    - subject: Fengjing Sows
      predicate: HAS
      object: ADG
```

That's a lot of details about these swine.

Some of the relationships may not be particularly informative or useful (e.g., VBO:0012847 IS diseases; the source text states this breed is "resistant to some diseases") and may suggest areas for further refinement of the extraction schema.
