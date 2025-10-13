# Exploring LinkML Models with Claude Code

This tutorial demonstrates how to use Claude Code to explore, understand, and extend LinkML schemas. We'll work with the Alliance Genome Resources (AGR) LinkML schema and create a new CellLine model based on real FlyBase database data.

## Prerequisites

- Claude Code installed ([Getting Started guide](claude-code-getting-started.md))
- Basic understanding of ontologies and database schemas
- PostgreSQL client (optional, for database exploration)

## What You'll Learn

1. Cloning and navigating the AGR LinkML schema repository
2. Understanding LinkML class inheritance and patterns
3. Exploring the FlyBase public database
4. Creating a new LinkML model from scratch
5. Connecting LinkML models to database schemas

## Background: Alliance LinkML Schema

The [Alliance Genome Resources](https://www.alliancegenome.org/) uses LinkML to standardize genomic data across seven model organism databases:
- FlyBase (Drosophila)
- WormBase (C. elegans)
- SGD (Yeast)
- MGI (Mouse)
- RGD (Rat)
- ZFIN (Zebrafish)
- XenBase (Xenopus)

**LinkML** (Linked Data Modeling Language) is a YAML-based schema definition language that generates:
- JSON schemas
- SQL DDL (Data Definition Language)
- Python data classes
- Documentation

**Repository:** https://github.com/alliance-genome/agr_curation_schema

## Part 1: Clone and Explore the AGR Schema

### Step 1: Clone the Repository

Ask Claude Code to clone the schema:

```
Clone the Alliance LinkML schema repository:
https://github.com/alliance-genome/agr_curation_schema

Put it in a folder called agr_curation_schema
```

### Step 2: Explore the Structure

```
What's in the model/schema/ directory?
Show me the main files and explain what they contain.
```

Key schema files:
- `allianceModel.yaml` - Main entry point, imports all other schemas
- `core.yaml` - Base classes (AuditedObject, CurieObject, SubmittedObject)
- `gene.yaml` - Gene model
- `allele.yaml` - Allele and variant model
- `disease.yaml` - Disease annotations
- `reagent.yaml` - Antibodies and constructs
- `reference.yaml` - Publications and cross-references

### Step 3: Understanding LinkML Basics

Before we dive deeper, let's understand the key LinkML concepts you'll encounter:

```
Read core.yaml and explain what these LinkML concepts mean:
1. What is a "class" in LinkML?
2. What is a "slot"?
3. What does "is_a" mean (inheritance)?
```

**LinkML Fundamentals:**
- **Classes** = Data types that represent entities (like Gene, Allele, CellLine)
- **Slots** = Properties or fields that classes have (like name, taxon, references)
- **is_a** = Inheritance - a class inherits all slots from its parent
- **slot_usage** = Override or refine how a slot behaves in a specific class

**Example:** If CellLine `is_a: GenomicEntity`, then CellLine automatically gets all the slots that GenomicEntity has (like taxon, curie), plus any additional slots it defines.

### Step 4: Understand the Inheritance Hierarchy

Now that you know what inheritance means, let's explore how AGR organizes its base classes:

```
In core.yaml, show me the inheritance chain.
What is the relationship between AuditedObject, CurieObject, and SubmittedObject?
```

**Inheritance chain:**
```
AuditedObject (audit fields: created_by, date_created, etc.)
  └─> CurieObject (adds curie field)
      └─> SubmittedObject (adds internal flag)
          └─> GenomicEntity (adds taxon)
              └─> Gene, Allele, etc.
```

Each class inherits all the slots from its parent and adds new ones. This means a Gene has audit fields (from AuditedObject), a curie (from CurieObject), an internal flag (from SubmittedObject), AND a taxon (from GenomicEntity), plus gene-specific slots.

## Part 2: Explore FlyBase Public Database

FlyBase provides a public PostgreSQL database that anyone can query!

### Connection Details

```
Host:     chado.flybase.org
User:     flybase
Password: (none)
Database: flybase
Port:     5432
```

### Connect and Explore

Ask Claude to connect:

```
Connect to the FlyBase public database:
Host: chado.flybase.org
User: flybase
Database: flybase
Port: 5432

Show me all tables that contain "cell_line"
```

**Cell line tables in FlyBase:**
- `cell_line` (341 records) - Main table
- `cell_line_synonym` - Alternative names
- `cell_line_pub` - Publication references
- `cell_line_dbxref` - External database links
- `cell_line_feature` - Gene/feature associations
- `cell_line_relationship` - Parent/child relationships

### Examine Sample Data

```
Describe the cell_line table structure.
Show me a few example records.
```

**Example cell lines:**
- FBtc0000001 - Kc167 (famous Drosophila cell line)
- FBtc0000049 - ML-DmBG1
- FBtc0000051 - ML-DmBG2

```
For the Kc167 cell line, show me:
1. Its synonyms
2. Associated publications
3. External database references
```

**Discovery:** Cell line data is rich and well-curated:
- ~6,000 total synonyms
- ~7,300 publication associations
- ~1,250 external database references

## Part 3: Plan the CellLine Model

### Check Existing Models

```
Search the AGR schema for any existing CellLine class.
Does it already exist?
```

**Result:** No CellLine model exists in AGR yet! Perfect opportunity to create one.

### Find a Similar Model to Use as a Template

Now that we need to create a CellLine model, let's ask Claude for guidance on where to start:

```
I'm interested in modeling cell lines in LinkML for the AGR schema.
Cell lines are biological reagents used in research.
Based on what exists in this schema, which class would be a good template or starting point?
```

**Claude will likely suggest looking at the Antibody class** in `reagent.yaml` because:
- Antibodies are also biological reagents
- They have similar requirements (taxon, references, cross-references)
- They follow AGR patterns we can learn from

### Explore the Suggested Model

Now let's examine the Antibody class to understand its structure:

```
Read the Antibody class in reagent.yaml.
Show me:
1. What does it inherit from?
2. What slots does it define?
3. How are references and cross-references handled?
```

### Design Decisions

Based on our exploration:

**Parent class:** `GenomicEntity`
- Provides: taxon, curie, audit fields
- Appropriate for biological specimens

**Required fields:**
- `curie` (unique ID, e.g., FBtc0000001)
- `name` (primary name, e.g., Kc167)
- `taxon` (species of origin)

**Optional/multivalued:**
- `cell_line_synonyms` (alternative names)
- `references` (publications)
- `cross_references` (external database IDs)
- `originating_lab` (source laboratory)

## Part 4: Create the CellLine Model

### Step 1: Create a Git Branch

Before making changes to the schema, create a new branch (best practice!):

```
Create a new git branch called 'add-cell-line-model'
```

Claude will run `git checkout -b add-cell-line-model` for you.

### Step 2: Create the Basic CellLine Class

Now, instead of micromanaging every detail, ask Claude to create the class and let it figure out the structure:

```
I want to create a bare bones CellLine class for the AGR schema.
Please base it on the Antibody model we looked at earlier.
A cell line is a cultured cell population used in research.

Create the basic class structure and then tell me:
1. What you've added
2. Where you put it
3. What else you think would be good to add
```

**What Claude will do:**
- Decide whether to create a new `cell_line.yaml` file or add to an existing file
- Create the basic CellLine class inheriting from GenomicEntity
- Include essential fields like curie, name, taxon
- Explain its decisions and suggest next steps

**Example of what Claude might create:**

```yaml
classes:
  CellLine:
    is_a: GenomicEntity
    description: >-
      A cultured cell population derived from a multicellular organism,
      maintained under controlled conditions for scientific research.
    slots:
      - name
      - cell_line_synonyms
      - references
      - cross_references
    slot_usage:
      curie:
        required: true
      name:
        required: true
      taxon:
        required: true
```

### Step 3: Compare to Existing Classes and Validate with Real Data

Now let's see how our model compares to other classes and whether it can actually represent the data we explored:

```
Great! Now can you:
1. Compare our CellLine model to a few other existing AGR classes (like Antibody, Construct, or Gene)
2. Tell me how the FlyBase data we looked at earlier (Kc167 cell line with its synonyms, publications, and cross-references) would fit into this LinkML model

I want to make sure we've captured the right structure.
```

**What this does:**
- Claude will analyze how CellLine compares to similar classes
- It will map the real Kc167 data to the LinkML slots
- You'll see if anything is missing (like synonym handling, publication references)
- This is exactly how a real biocurator validates a new model!

**Example response you might get:**
- "Kc167's name goes in the `name` slot"
- "Its synonyms (Kc-167, KC167) go in `cell_line_synonyms`"
- "Publications would use the `references` slot"
- "FlyBase ID (FBtc0000001) is the `curie`"
- "But we might need to add support for external database cross-references..."

### Step 4: Validate Conventions

```
Review the CellLine model and check:
1. Does it follow AGR naming conventions?
2. Are all referenced types defined?
3. Is anything missing compared to the Antibody pattern?
```

Claude will check the model against AGR patterns and let you know if anything needs adjustment.

### Step 5: Add the DTO Class (if needed)

LinkML uses DTO (Data Transfer Object) classes for data ingest. Claude may have already created one, but if not:

```
Does our CellLine model have a corresponding DTO class?
If not, can you add a CellLineDTO class following the AGR pattern?
```

**What a DTO does:**
- Handles data import/ingest
- Uses specific naming (cell_line_curie instead of just curie)
- Includes _dtos suffix for related objects (synonym_dtos, cross_reference_dtos)

## Part 5: Generate Test Data

Now let's validate our model by generating test data using the real FlyBase data we explored earlier!

### Create Sample CellLine Data

Ask Claude to generate test data based on the FlyBase records:

```
Can you generate test data for our CellLine model using the Kc167 cell line data we explored from FlyBase?

If you need to, query the FlyBase database again to get:
- The cell line name and ID
- A few synonyms
- Some publication references
- Cross-references to external databases

Create the test data in the format that our LinkML model expects.
```

**What Claude will do:**
- Query FlyBase for Kc167 data (if needed)
- Format it according to our CellLine LinkML structure
- Show you example data in YAML or JSON format

**Example test data you might get:**

```yaml
- curie: "FB:FBtc0000001"
  name: "Kc167"
  taxon: "NCBITaxon:7227"  # Drosophila melanogaster
  cell_line_synonyms:
    - synonym_sgml: "Kc-167"
      synonym_type: "alternate_name"
    - synonym_sgml: "KC167"
      synonym_type: "alternate_name"
  cross_references:
    - referenced_curie: "ATCC:CRL-1963"
    - referenced_curie: "Cellosaurus:CVCL_0526"
  references:
    - reference_curie: "FB:FBrf0123456"
```

### Generate DTO Test Data (Optional)

If your model has a CellLineDTO class, you can also generate test ingest data:

```
Can you also create a sample CellLineDTO object that shows how this data would be ingested?
Use the DTO naming conventions (cell_line_curie, synonym_dtos, etc.)
```

**Why this matters:**
- Validates your model works with real data
- Shows the difference between the model and DTO representations
- Provides examples for data loading scripts
- Tests that all required fields are present

## Key Claude Code Patterns for LinkML

### Navigation

```
"Show me the gene.yaml file"
"Find where the 'taxon' slot is defined"
"Trace the inheritance chain for Allele"
```

### Understanding

```
"Explain what the 'range' attribute means in this slot"
"What's the difference between Gene and GeneDTO?"
"Why does this class use slot_usage?"
```

### Creation

```
"Create a new LinkML class for [entity type]"
"Add a new slot called [name] to [class]"
"Generate SQL from this LinkML model"
```

### Validation

```
"Does this follow AGR naming conventions?"
"Are all required slots defined?"
"Is this inheritance chain correct?"
```

## Best Practices

### ✅ DO:

**Start with exploration**
- Understand existing patterns before creating new ones
- Study similar classes (Antibody for CellLine)
- Check what's already defined

**Explore real data first**
- Query production databases when possible
- Understand actual data relationships
- Discover edge cases early

**Work incrementally**
- Basic class structure first
- Add complexity step-by-step
- Validate at each stage

**Use Claude Code's strengths**
- File navigation and search
- Pattern recognition
- Inheritance tracing

### ❌ DON'T:

**Assume knowledge**
- Explain domain terms to Claude
- Provide context about biological concepts
- Don't assume Claude knows your abbreviations

**Skip validation**
- Always check conventions
- Verify required fields
- Test generated SQL

**Work in isolation**
- Don't create models without checking real data
- Don't ignore existing patterns
- Don't forget about downstream users

## Troubleshooting

### "Can't find where a slot is defined"

Slots might be defined in imported files:

```
"Trace the 'references' slot through all imports. Where is it actually defined?"
```

### "Model validation fails"

Check inheritance chain:

```
"What slots does GenomicEntity provide? Am I duplicating any?"
```

### "Generated SQL doesn't match database"

LinkML generates normalized schemas; databases may denormalize:

```
"Show me how the FlyBase cell_line_synonym table relates to the main cell_line table"
```

## Resources

### Databases

- **FlyBase Public Database**: chado.flybase.org
  - User: flybase (no password)
  - Database: flybase
  - Port: 5432
  - Test: `psql -h chado.flybase.org -U flybase -d flybase`

### Documentation

- **AGR Schema**: https://github.com/alliance-genome/agr_curation_schema
- **AGR Schema Docs**: https://alliance-genome.github.io/agr_curation_schema/
- **LinkML Documentation**: https://linkml.io/linkml/
- **LinkML Tutorial**: https://linkml.io/linkml/intro/tutorial.html

### Tools

- **LinkML Validator**: `linkml-validate`
- **SQL Generator**: `gen-sql-ddl`
- **Python Classes**: `gen-python`
- **JSON Schema**: `gen-json-schema`

## Next Steps

You've learned how to explore and extend LinkML schemas with Claude Code. Continue with:

- **[Creating Slash Commands for API Lookups](claude-code-slash-commands.md)** - Build reusable workflows for ontology lookups
- **[Using MCPs for Ontology Lookups](claude-code-mcps.md)** - Connect to EBI's Ontology Lookup Service for integrated ontology queries

## Summary

In this tutorial, you:

✅ Cloned and explored the AGR LinkML schema repository
✅ Connected to FlyBase's public database
✅ Explored real cell line data (341 records)
✅ Created a new CellLine LinkML model from scratch
✅ Generated SQL schema from LinkML
✅ Queried real biological data

**This is exactly how professional biocuration modeling works** - understanding existing data, designing appropriate schemas, and validating with real-world requirements.

Claude Code accelerates this process by helping you navigate complex schemas, understand inheritance patterns, and validate your models against established conventions.
