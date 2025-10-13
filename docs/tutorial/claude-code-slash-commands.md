# Creating Slash Commands for API Lookups

Slash commands are reusable workflows stored as markdown files that Claude Code can execute instantly. This tutorial shows you how to create custom commands for common biocuration tasks like ontology term lookups and database queries.

## Prerequisites

- Claude Code installed ([Getting Started guide](claude-code-getting-started.md))
- Basic understanding of REST APIs
- Familiarity with command line tools (curl)

## What You'll Learn

1. What slash commands are and why they're useful
2. Creating a ChEBI compound lookup command
3. Building a Gene Ontology (GO) term command
4. Command best practices and error handling
5. Sharing commands with your team

## What Are Slash Commands?

**Slash commands** are saved workflows that Claude Code can execute with simple `/command` syntax.

### Without Slash Commands

```
You: "Query the ChEBI API for compound CHEBI:15377 and format the results nicely"
Claude: *writes curl command, executes, parses JSON, formats output*

... later ...

You: "Query the ChEBI API for compound CHEBI:16761 and format the results nicely"
Claude: *does everything from scratch again*
```

### With Slash Commands

```
You: /chebi CHEBI:15377
Claude: *instant results*

You: /chebi CHEBI:16761
Claude: *instant results*
```

### Benefits

- **Faster** - No re-explaining the task
- **Consistent** - Same format every time
- **Reusable** - Save and share with team
- **Efficient** - Instructions stored locally, not in conversation

## Command Structure

Slash commands are markdown files stored in `.claude/commands/`:

```markdown
---
description: Brief description of what this command does
allowed_tools:
  - bash
---

Instructions for Claude go here.

Use $ARGUMENTS for command parameters.
```

**File location:**
- Project-specific: `.claude/commands/command-name.md`
- Global: `~/.claude/commands/command-name.md`

**Usage:** `/command-name` (filename without `.md`)

## Part 1: ChEBI Compound Lookup

### What is ChEBI?

[ChEBI](https://www.ebi.ac.uk/chebi/) (Chemical Entities of Biological Interest) is a database of molecular entities focused on "small" chemical compounds.

### Step 1: Discover What's Available

Before creating a command, we need to understand what the ChEBI API offers. Ask Claude:

```
I want to create a slash command to look up ChEBI compounds.
Can you help me explore what's available in the ChEBI API?

Please go to the ChEBI API documentation:
https://www.ebi.ac.uk/chebi/backend/api/docs/

Tell me:
1. What endpoints are available?
2. What data can I get back for a compound?
3. What would be useful to display in a slash command?
```

**Claude will help you discover:**
- Available endpoints (compound lookup, search, structure, etc.)
- What data fields are returned (name, formula, mass, synonyms, definitions, structures, etc.)
- Which fields would be most useful for biocuration

### Step 2: Get the OpenAPI Specification (Optional)

For more detail, you can have Claude analyze the complete API specification:

```
Can you fetch the OpenAPI specification from:
https://www.ebi.ac.uk/chebi/backend/api/schema/

Help me understand what I can learn about compounds from this API.
What information is available for each compound?
```

**This helps you:**
- See all the data ChEBI tracks for compounds
- Understand what biological/chemical information is available
- Make informed decisions about what to include in your command

### Step 3: Decide What to Display

Based on what you discovered, ask Claude:

```
Based on the ChEBI API, I want to create a /chebi command.
For a biocurator, what would be the most useful information to display?

I'm thinking:
- Compound name
- Chemical formula
- Definition

What else should I include?
```

### Step 4: Create the Command

Now that you know what's available, create the command:

```
Create a slash command file: .claude/commands/chebi.md

The command should:
- Accept a ChEBI ID as $ARGUMENTS (e.g., CHEBI:15377)
- Query the ChEBI REST API endpoint: /chebi/backend/api/public/compound/$ARGUMENTS/
- Display the most useful fields we discussed
- Format output in a readable table
- Handle errors gracefully
```

### Example Implementation

Claude Code will create something like:

```markdown
---
description: Look up ChEBI chemical compound information by ID
allowed_tools:
  - bash
---

Query ChEBI for compound: $ARGUMENTS

Steps:
1. Validate the ChEBI ID format (should be CHEBI:XXXXX)
2. Use curl to fetch JSON from:
   https://www.ebi.ac.uk/chebi/backend/api/public/compound/$ARGUMENTS/
3. Parse the JSON response
4. Display the key fields (name, formula, mass, definition, synonyms)
5. Format as a readable table
6. If ID is invalid or network fails, show helpful error message
```

### Test It

```
/chebi CHEBI:15377
```

**Expected output:**

```
ChEBI Compound: CHEBI:15377
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Name:       Water
Formula:    H₂O
MW:         18.015 g/mol
Definition: An oxygen hydride consisting of an oxygen atom
            that is covalently bonded to two hydrogen atoms.
Synonyms:   H2O, HOH, oxidane, dihydrogen oxide
```

## Part 2: Gene Ontology (GO) Term Lookup

### What is GO?

The [Gene Ontology](http://geneontology.org/) provides structured vocabularies for:
- Biological Process (BP)
- Molecular Function (MF)
- Cellular Component (CC)

**Two APIs are available:**
- **QuickGO** (https://www.ebi.ac.uk/QuickGO/) - Great for searching GO terms
- **Gene Ontology API** (https://api.geneontology.org/) - Detailed term information and relationships

### Step 1: Explore QuickGO API (No OpenAPI Spec)

QuickGO doesn't have an OpenAPI specification, but we can still explore it! When there's no spec, just copy-paste the documentation.

Go to: https://www.ebi.ac.uk/QuickGO/api/index.html

Copy the "Gene Ontology" section (the list of endpoints) and ask Claude:

```
I want to create a /go command for searching and looking up GO terms.
Here's the QuickGO API documentation I copied:

[Paste the endpoint list here]

Help me understand:
1. Which endpoint would be best for searching GO terms by name?
2. Which endpoint would give me detailed information about a specific GO ID?
3. What information can I get back about each term?
```

**Key insight:** When there's no OpenAPI spec, copy-paste documentation and Claude will parse it for you!

### Step 2: Explore Gene Ontology API

Now check what the Gene Ontology API offers:

```
Can you also explore the Gene Ontology API at:
https://api.geneontology.org/

Tell me:
1. What endpoints are available?
2. How is this different from QuickGO?
3. Which API should I use for what purpose?
```

### Step 3: Decide Your Approach

Based on what you learned, ask Claude to help you decide:

```
Based on both APIs, I want to create a /go command that:
- Can search for GO terms by name (e.g., "apoptosis")
- Can look up a specific GO ID (e.g., GO:0008150)
- Shows useful information for biocuration

Which API should I use for search vs lookup?
What information should I display?
```

**Typical decision:**
- Use **QuickGO** `/ontology/go/search` for finding terms
- Use **Gene Ontology API** or QuickGO `/ontology/go/terms/{ids}` for detailed lookups

### Step 4: Create the Command

Now create the command with Claude's help:

```
Create a slash command: .claude/commands/go.md

Based on what we discussed:
- If $ARGUMENTS looks like a GO ID (GO:XXXXXXX), do a lookup
- If $ARGUMENTS is text, do a search
- Display the most useful information for biocurators
- Handle errors for invalid inputs
```

### Example Implementation

Claude might create a smart command that handles both search and lookup:

```markdown
---
description: Search or look up Gene Ontology terms
allowed_tools:
  - bash
---

Process GO query: $ARGUMENTS

Steps:
1. Check if $ARGUMENTS is a GO ID (GO:XXXXXXX) or search term
2. For GO ID:
   - Use QuickGO or GO API to get term details
   - Display: name, namespace, definition, relationships
3. For search term:
   - Use QuickGO search endpoint
   - Display: top 5 matching terms with IDs
4. Format output clearly
5. Handle invalid inputs or API errors
```

### Test It

**Search by name:**
```
/go apoptosis
```

**Expected output:**
```
GO Term Search: "apoptosis"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. GO:0006915 - apoptotic process
   Definition: A programmed cell death process...

2. GO:0097190 - apoptotic signaling pathway
   Definition: A series of molecular signals...

3. GO:0043065 - positive regulation of apoptosis
   Definition: Any process that activates...
```

**Lookup by ID:**
```
/go GO:0008150
```

**Expected output:**
```
Gene Ontology Term: GO:0008150
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Name:       biological_process
Namespace:  biological_process
Definition: A biological process represents a specific
            objective that the organism is genetically
            programmed to achieve.

Parent Terms:
  (This is a root term)
```

## Best Practices

### ✅ DO: Make Commands Self-Documenting

Include clear descriptions and examples:

```markdown
---
description: Look up ChEBI compound by ID (e.g., /chebi CHEBI:15377)
---
```

### ✅ DO: Handle Errors

Always validate input and handle failures:

```
1. Check if $ARGUMENTS is provided
2. Validate ID format (CHEBI:XXXXX or GO:XXXXXXX)
3. Handle network failures (curl timeout)
4. Handle invalid IDs (404 responses)
5. Show helpful error messages
```

### ✅ DO: Format Output Consistently

Use tables or structured formats for readability:

```
Term Name:    value
Definition:   value
━━━━━━━━━━━━━━━━━━━━━
```

### ❌ DON'T: Hardcode Values

**Bad:**
```
Query https://api.example.com/term/GO:0008150
```

**Good:**
```
Query https://api.example.com/term/$ARGUMENTS
```

## Advanced Command Features

### Multiple Arguments

Commands can accept multiple parameters:

```markdown
---
description: Compare two GO terms
---

Compare GO terms: $ARGUMENTS

Parse $ARGUMENTS as two GO IDs:
1. First GO ID (e.g., GO:0008150)
2. Second GO ID (e.g., GO:0009987)

Show hierarchical relationship and shared annotations.
```

**Usage:** `/compare-go GO:0008150 GO:0009987`

### Command Options

Support flags for different output formats:

```
/search-chebi "glucose" --limit 5 --format table
```

### Chaining Commands

Use command outputs in conversation:

```
/go GO:0008150

Based on that GO term, what ChEBI compounds are related?
```

## Sharing Commands with Your Team

### Version Control

Commands are just markdown files - commit them to git:

```bash
git add .claude/commands/chebi.md
git add .claude/commands/go.md
git commit -m "Add ontology lookup commands"
git push
```

Team members who clone the repo will have the commands automatically!

### Global vs Project Commands

**Project-specific** (`.claude/commands/`):
- Specific to this repository
- Shared via git
- Available when working in this project

**Global** (`~/.claude/commands/`):
- Available in all projects
- Personal commands
- Not shared via git

## Common Use Cases for Biocuration

### Ontology Term Lookups

- `/chebi` - Chemical compounds
- `/go` - Gene Ontology terms
- `/mondo` - Disease Ontology (MONDO)
- `/hp` - Human Phenotype Ontology
- `/uberon` - Anatomical structures

### Database Queries

- `/uniprot` - Protein information
- `/ncbi-gene` - Gene records
- `/pubmed` - Literature search
- `/omim` - Genetic disorders

### Data Validation

- `/validate-gene-symbols` - Check gene symbol formats
- `/check-taxon` - Validate NCBI taxon IDs
- `/verify-refs` - Check publication references

### Format Conversion

- `/gff-to-json` - Convert GFF3 to JSON
- `/fasta-stats` - Analyze FASTA files
- `/tsv-to-linkml` - Generate LinkML from TSV

## Troubleshooting

### "Command not found"

Check the filename matches:
- `.claude/commands/chebi.md` → `/chebi`
- `.claude/commands/go.md` → `/go`

### "API returns HTML instead of JSON"

Add proper headers to curl:

```bash
curl -H "Accept: application/json" https://api.example.com/...
```

### "Command is slow"

- Add result limits: `--limit 10`
- Cache frequent queries
- Consider using an MCP server for complex integrations

## Hands-On Exercise

### Challenge: Create a UniProt Lookup Command

**Task:** Create a `/uniprot` command that looks up protein information.

**Requirements:**
- Accept a UniProt ID (e.g., P04637)
- Query UniProt API: `https://www.uniprot.org/uniprot/$ID.xml`
- Display: protein name, organism, function, sequence length
- Show associated GO terms

**API documentation:** https://www.uniprot.org/help/api

**Hints:**
1. Start with just the protein name
2. Add more fields incrementally
3. Test with real IDs:
   - P04637 = Human p53
   - P12345 = Mouse p53

**Solution approach:**

Ask Claude:
```
Create a /uniprot command that:
- Accepts a UniProt ID
- Fetches XML from https://www.uniprot.org/uniprot/$ID.xml
- Parses and displays protein name, organism, function, length
- Shows associated GO terms
- Handles invalid IDs gracefully
```

## Common API Endpoints for Biocuration

```
ChEBI:     https://www.ebi.ac.uk/chebi/
GO:        http://api.geneontology.org/api/
UniProt:   https://www.uniprot.org/uniprot/
NCBI Gene: https://eutils.ncbi.nlm.nih.gov/entrez/eutils/
PubMed:    https://eutils.ncbi.nlm.nih.gov/entrez/eutils/
PubChem:   https://pubchem.ncbi.nlm.nih.gov/rest/pug/
MONDO:     http://purl.obolibrary.org/obo/mondo.owl
HPO:       https://hpo.jax.org/api/
```

## Resources

### Official Documentation

- **Claude Code Commands**: https://docs.claude.com/en/docs/claude-code/slash-commands
- **ChEBI Web Services**: https://www.ebi.ac.uk/chebi/webServices.do
- **GO API**: http://api.geneontology.org/
- **UniProt API**: https://www.uniprot.org/help/api

### Example Command Libraries

- **OBO Academy Commands**: (Coming soon - contribute your commands!)
- **Alliance Genome Commands**: Repository-specific ontology lookups
- **FlyBase Curator Commands**: Drosophila-specific validations

## Next Steps

You've learned how to create reusable slash commands for common biocuration tasks. For even more powerful integrations, learn about:

- **[Using MCPs for Ontology Lookups](claude-code-mcps.md)** - Connect to EBI's Ontology Lookup Service for integrated queries across GO, ChEBI, HP, MONDO, and 200+ other ontologies through a single interface

## Summary

In this tutorial, you learned:

✅ What slash commands are and why they're useful
✅ How to create ChEBI and GO lookup commands
✅ Best practices for error handling and formatting
✅ How to share commands with your team via git
✅ Common biocuration use cases for commands

**Slash commands are perfect for:**
- Repetitive API lookups
- Standardized formatting
- Team workflow standardization
- Quick ontology term reference

**For more complex integrations** (persistent connections, multiple related tools, authentication), consider using MCP servers covered in the next tutorial.

---

**Pro tip:** Start building a library of commands for your most common tasks. After a few weeks, you'll have a powerful toolkit that makes biocuration significantly faster!
