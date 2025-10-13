# Using MCPs for Ontology Lookups

Model Context Protocol (MCP) servers extend Claude Code with powerful integrations for bioinformatics workflows. This tutorial demonstrates how to use the EBI Ontology Lookup Service (OLS) MCP to query multiple ontologies through a single integrated interface.

## Prerequisites

- Claude Code installed ([Getting Started guide](claude-code-getting-started.md))
- Python 3.10+ with uv package manager
- Understanding of [slash commands](claude-code-slash-commands.md)
- Completion of [LinkML tutorial](claude-code-linkml.md) recommended

## What You'll Learn

1. What MCPs are and why they're powerful
2. Installing the OLS MCP server
3. Discovering OLS MCP capabilities through conversation
4. Querying multiple ontologies (GO, ChEBI, HP, MONDO)
5. Real-world ontology lookup workflows
6. MCP vs slash command decision criteria

## What is an MCP?

**MCP** = Model Context Protocol

MCPs are plugins that give Claude Code new capabilities through persistent connections to external services.

### MCP vs Slash Commands vs Built-in Tools

| Feature | Built-in Tools | Slash Commands | MCP Servers |
|---------|---------------|----------------|-------------|
| **File operations** | ✅ | ❌ | ❌ |
| **Simple APIs** | Via bash | ✅ | ❌ |
| **Complex APIs** | ❌ | Limited | ✅ |
| **Multiple ontologies** | ❌ | One at a time | ✅ |
| **Persistent connections** | ❌ | ❌ | ✅ |
| **Related tools grouped** | ❌ | ❌ | ✅ |
| **Rate limiting** | ❌ | ❌ | ✅ |

### When to Use Each

**Use built-in tools for:**
- Reading/writing files
- Running commands
- File system navigation

**Use slash commands for:**
- Simple API calls (ChEBI, GO lookups from Tutorial 3)
- One-off queries
- No authentication needed
- Single ontology lookups

**Use MCPs for:**
- Querying multiple ontologies from one interface
- Complex API integrations
- Persistent database connections
- Multiple related operations

## The OLS MCP Server

The [Ontology Lookup Service (OLS)](https://www.ebi.ac.uk/ols4/) from the European Bioinformatics Institute (EBI) provides access to hundreds of biomedical ontologies through a single API. The OLS MCP server brings this power directly into Claude Code.

**Note:** The OLS MCP server is listed in the [official MCP servers registry](https://github.com/modelcontextprotocol/servers), a curated collection of community-maintained MCP servers for various use cases. The registry is a great place to discover other MCP servers for different workflows.

### What It Provides

**7 tools for ontology exploration:**

1. **search_terms** - Search across ontologies
2. **get_term_info** - Get detailed term information
3. **get_ontology_info** - Get ontology metadata
4. **search_ontologies** - Find available ontologies
5. **get_term_children** - Get child terms
6. **get_term_ancestors** - Get parent/ancestor terms
7. **find_similar_terms** - Find related terms using embeddings

### Ontologies Available

OLS provides access to hundreds of ontologies, including:

- **GO** (Gene Ontology) - Biological processes, molecular functions, cellular components
- **ChEBI** (Chemical Entities of Biological Interest) - Small molecules and biochemistry
- **HP** (Human Phenotype Ontology) - Human phenotypic abnormalities
- **MONDO** (Monarch Disease Ontology) - Diseases and medical conditions
- **UBERON** - Anatomical structures across species
- **CL** (Cell Ontology) - Cell types
- **And 200+ more ontologies**

### Benefits

**Compared to Tutorial 3's slash commands:**
- **Multiple ontologies** - Query GO, ChEBI, HP, MONDO from one place
- **No manual curl** - Claude handles everything
- **Structured data** - Automatic JSON parsing
- **Advanced features** - Term relationships, hierarchies, similarity search
- **Official EBI service** - Maintained by European Bioinformatics Institute

## Installing the OLS MCP Server

### Step 1: Install with Claude MCP Add

The OLS MCP server is published on PyPI and can be installed using Claude Code's built-in MCP manager:

```bash
claude mcp add --transport stdio ols-mcp-server -- ols-mcp-server
```

**What this does:**
- Installs the OLS MCP server using Python's uv package manager
- Configures it in your `~/.claude/.claude.json` file
- Sets up stdio transport (communication via stdin/stdout)
- Makes 7 OLS tools available to Claude Code

### Step 2: Restart Claude Code

After installation, restart Claude Code to load the MCP:

```bash
# Exit current session
exit

# Start new session
claude

# You should see:
✓ Loaded MCP: ols-mcp-server (7 tools)
```

**Verification:**
- Look for "ols-mcp-server" in the startup messages
- You should see "7 tools" listed
- If you don't see this, check the troubleshooting section below

### GitHub Repository

The OLS MCP server is open source:
- **Repository**: https://github.com/seandavi/ols-mcp-server
- **Developer**: Sean Davis
- **License**: MIT

## Part 1: Understanding What the OLS MCP Can Do

Before diving into specific examples, let's explore what the OLS MCP server is capable of. The best way to learn is to ask Claude!

### Discovering Available Capabilities

Now that you've installed the OLS MCP, you can ask Claude Code to explain what it can do. Try these conversational queries:

**Ask Claude:**
```
What can I do with the OLS MCP server? What tools does it provide?
```

**Claude will explain:**
- The 7 tools available (search_terms, get_term_info, etc.)
- What each tool does
- When you might use each one

**Ask Claude:**
```
What ontologies can I query using the OLS MCP?
Show me some examples of what's available.
```

**Claude will tell you:**
- Major ontologies: GO, ChEBI, HP, MONDO, UBERON, CL
- What each ontology covers
- How to specify which ontology to query

**Ask Claude:**
```
How do I search for terms across different ontologies?
Can you show me the difference between searching GO vs ChEBI?
```

**Claude will demonstrate:**
- How to search specific ontologies
- The differences between biological ontologies (GO) and chemical ontologies (ChEBI)
- How to interpret search results

### Understanding Term Information

**Ask Claude:**
```
What kind of information can I get about a specific ontology term?
What's the difference between searching for a term and getting detailed info about it?
```

**Claude will explain:**
- `search_terms` finds terms matching your query
- `get_term_info` retrieves complete details for a specific term ID
- What metadata is available (definitions, synonyms, relationships, cross-references)

### Exploring Hierarchies

**Ask Claude:**
```
Can I see how terms are related to each other?
How do I explore parent/child relationships in ontologies?
```

**Claude will show you:**
- `get_term_children` for finding subtypes
- `get_term_ancestors` for finding parent terms
- How hierarchies help understand biological classifications

### Why This Matters

By asking Claude these exploratory questions, you learn:
- What's possible with the OLS MCP
- How to formulate effective queries
- Which tool to use for different tasks
- How ontologies are structured

**This exploratory approach is exactly how you'll work with MCPs in practice** - asking questions, discovering capabilities, and building up your understanding naturally.

Now let's apply this knowledge to real examples!

## Part 2: Exploring Gene Ontology (GO)

Let's start by exploring GO terms, which describe biological processes, molecular functions, and cellular components.

### Search for GO Terms

Ask Claude:
```
Using the OLS MCP, search for GO terms related to "apoptosis".
Show me the top 5 results with their descriptions.
```

**What happens:**
- Claude uses the `search_terms` tool
- Specifies ontology "go" (Gene Ontology)
- Returns structured results with term IDs and descriptions

**Example results:**
```
Found 369 apoptosis-related terms in GO:

1. GO:0006915 - apoptotic process
   A programmed cell death process which begins when a cell
   receives an internal or external signal

2. GO:0097194 - execution phase of apoptosis
   The specific phase of apoptosis characterized by
   cell morphological changes

3. GO:0043065 - positive regulation of apoptotic process
   Any process that activates or increases the frequency
   of cell death by apoptosis
```

### Get Detailed Term Information

Ask Claude:
```
Using OLS, get detailed information about GO:0006915.
Show me the full definition, synonyms, and relationships.
```

**What happens:**
- Uses `get_term_info` tool
- Returns complete term metadata
- Shows synonyms, relationships, cross-references

**Example results:**
```
GO:0006915 - apoptotic process

Definition:
A programmed cell death process which begins when a cell
receives an internal or external signal

Synonyms:
- apoptosis
- programmed cell death
- cell suicide
- type I programmed cell death

Relationships:
- is_a: GO:0012501 (programmed cell death)
- part_of: GO:0008219 (cell death)
```

### Connection to Tutorial 3

Remember the `/go` slash command from Tutorial 3? The OLS MCP provides similar functionality but with access to **all OLS ontologies** through one interface instead of querying individual APIs.

## Part 3: Exploring Chemical Entities (ChEBI)

ChEBI provides structured information about small molecules and their biological roles.

### Search for Chemical Compounds

Ask Claude:
```
Search ChEBI via OLS for terms related to "glucose".
Show molecular formulas where available.
```

**Example results:**
```
Found 977 glucose-related terms in ChEBI:

1. CHEBI:17234 - glucose
   An aldohexose used as a source of energy and metabolic intermediate
   Formula: C6H12O6

2. CHEBI:4167 - D-glucose
   The D-enantiomer of glucose
   Formula: C6H12O6

3. CHEBI:15903 - glucose-6-phosphate
   A compound central to carbohydrate metabolism
   Formula: C6H13O9P
```

### Compare to Tutorial 3

In Tutorial 3, you created a `/chebi` slash command that queried a single ChEBI ID. The OLS MCP allows you to:
- Search across all ChEBI terms
- Access related ontology information
- Explore term hierarchies
- Find similar compounds

## Part 4: Exploring Human Phenotype Ontology (HP)

HP describes phenotypic abnormalities in human disease.

### Search for Phenotypes

Ask Claude:
```
Search the Human Phenotype Ontology via OLS for "diabetes".
Show the definitions.
```

**Example results:**
```
Found 35 diabetes-related terms in HP:

1. HP:0000819 - Diabetes mellitus
   A group of abnormalities characterized by hyperglycemia
   and glucose intolerance

2. HP:0005978 - Type 2 diabetes mellitus
   A multifactorial disorder of glucose homeostasis caused
   by a lack of sensitivity to insulin

3. HP:0100560 - Transient neonatal diabetes mellitus
   A form of diabetes presenting in the neonatal period
   that is transient
```

### Get Term Hierarchy

Ask Claude:
```
Using OLS, show me the child terms (subtypes) of HP:0000819
(Diabetes mellitus).
```

**What happens:**
- Uses `get_term_children` tool
- Shows the hierarchical structure of disease terms
- Helps understand disease classification

## Part 5: Cross-Ontology Workflows

One of MCP's greatest strengths is combining information from multiple sources.

### Example: Gene to Disease to Phenotype

Ask Claude:
```
Let's explore the connections between biological processes and disease:

1. Search GO for "insulin secretion"
2. Search MONDO for "diabetes" diseases
3. Search HP for diabetes phenotypes
4. Help me understand how these connect
```

**What happens:**
- Claude queries three different ontologies
- Identifies connections between biological processes, diseases, and phenotypes
- Provides integrated view of the biology

**This demonstrates:**
- Why MCPs are more powerful than individual slash commands
- How integrated access accelerates research
- The value of querying multiple ontologies together

## Real-World Workflow: Comprehensive Term Analysis

Let's analyze a biological process using OLS.

### Step 1: Find Relevant Terms

```
Search OLS for GO terms related to "DNA repair".
Show me the most relevant 5 terms.
```

### Step 2: Get Detailed Information

```
For the top result, get the complete term information
including relationships and cross-references.
```

### Step 3: Explore Hierarchy

```
Show me the parent terms (ancestors) to understand where
this process fits in the GO hierarchy.
```

### Step 4: Find Related Chemistry

```
Search ChEBI for compounds involved in DNA repair.
Look for terms like "nucleotide" or "base excision".
```

### Step 5: Connect to Disease

```
Search MONDO for diseases related to DNA repair defects.
Show how these connect to the GO terms we found.
```

**Result:** Comprehensive understanding of DNA repair combining:
- GO: Biological processes
- ChEBI: Chemical compounds involved
- MONDO: Associated diseases
- HP: Clinical phenotypes

## Why MCPs Are Powerful for Biocuration

### Integrated Access

Instead of:
```
/go apoptosis          # Query GO
/chebi glucose         # Query ChEBI
/mondo diabetes        # Query MONDO
```

With OLS MCP:
```
Search OLS across GO, ChEBI, and MONDO for related terms
about insulin signaling and diabetes
```

### Persistent Connection

- MCP maintains connection to OLS
- No repeated authentication
- Faster queries
- Rate limiting handled automatically

### Structured Workflows

MCPs enable multi-step research:
1. Find biological process in GO
2. Identify related compounds in ChEBI
3. Connect to diseases in MONDO
4. Explore phenotypes in HP
5. Generate comprehensive report

## MCP Best Practices

### When to Use MCPs vs Slash Commands

**Use MCPs when:**
- Querying multiple ontologies
- Need term relationships and hierarchies
- Building complex research workflows
- Want integrated cross-ontology search

**Use Slash Commands when:**
- Simple one-off lookup (from Tutorial 3)
- Know exact term ID
- Don't need relationships
- Simpler is better for the task

**Real example:**
- Quick lookup: `/chebi CHEBI:15377` (slash command)
- Research workflow: "Search ChEBI and GO for glucose metabolism terms" (MCP)

### Performance

✅ **DO:**
- Use MCPs for exploratory research
- Query multiple ontologies together
- Let Claude handle the integration

❌ **DON'T:**
- Install unnecessary MCPs (slower startup)
- Use MCP for single-term lookups when slash command is faster
- Query massive result sets without limits

## Troubleshooting

### "MCP failed to load"

**Check:**
1. Is Python 3.10+ installed? (`python3 --version`)
2. Is uv package manager available? (`uv --version`)
3. Check logs: `~/.claude/logs/mcp.log`

**Common fixes:**
```bash
# Reinstall OLS MCP
claude mcp remove ols-mcp-server
claude mcp add --transport stdio ols-mcp-server -- ols-mcp-server

# Verify installation
claude mcp list
```

### "Can't find term/ontology"

**Try:**
- Use different search terms (symbol vs full name)
- Check spelling and formatting
- Try partial matches
- Verify ontology abbreviation (GO, ChEBI, HP, not go, chebi, hp)

**Example:**
```
# Might not work:
"Find apoptosis"

# Better:
"Search GO ontology for apoptosis"
"Find apoptosis terms in Gene Ontology via OLS"
```

### "No results returned"

**Check:**
- Is ontology abbreviation correct? (GO, ChEBI, HP, MONDO)
- Try broader search terms
- Verify ontology is available in OLS
- Check if term exists in that specific ontology

## Complete Tutorial Arc

### The Full Journey

```
Tutorial 1: Learn Claude Code basics
    ↓
Tutorial 2: Explore LinkML schemas (data structure)
    ↓
Tutorial 3: Create API lookup slash commands (simple queries)
    ↓
Tutorial 4: Install OLS MCP for integrated ontology access!
```

**You can now:**
- ✅ Navigate and modify LinkML schemas
- ✅ Query ontologies with simple slash commands
- ✅ Use professional bioinformatics APIs via MCPs
- ✅ Perform integrated multi-ontology research
- ✅ Build comprehensive biological knowledge workflows

## Connection to Previous Tutorials

### Tutorial 2: LinkML Schemas
- Tutorial 2: You explored LinkML models (structure of data)
- Tutorial 4: OLS MCP queries the actual ontology data those models reference

### Tutorial 3: Slash Commands
- Tutorial 3: Created `/chebi` and `/go` for individual lookups
- Tutorial 4: OLS MCP provides integrated access to all ontologies

**Evolution:**
- Simple lookups → Slash commands
- Complex workflows → MCP servers
- Both have their place in your toolkit!

## Key Advantages of MCPs

**Integrated Ontology Access**
- Multiple ontologies (GO, ChEBI, HP, MONDO) through one interface
- Cross-ontology search and comparison
- Hierarchical relationships and term ancestry

**Connects Everything Together**
- Tutorial 2: LinkML schemas → Tutorial 4: Query data those schemas describe
- Tutorial 3: Slash commands for simple APIs → Tutorial 4: MCPs for complex workflows
- Combines multiple ontologies for comprehensive biological understanding

**Real-World Research Workflows**
- Search across ontologies simultaneously
- Explore term relationships and hierarchies
- Connect biological processes to diseases to phenotypes
- Build comprehensive knowledge graphs

**Official EBI Service**
- Maintained by European Bioinformatics Institute
- Access to 200+ biomedical ontologies
- Production-grade reliability
- Regularly updated

## Resources

### OLS MCP Server

**GitHub Repository:**
- Repository: https://github.com/seandavi/ols-mcp-server
- Developer: Sean Davis
- Installation: `claude mcp add --transport stdio ols-mcp-server -- ols-mcp-server`

**EBI Ontology Lookup Service:**
- Website: https://www.ebi.ac.uk/ols4/
- Documentation: https://www.ebi.ac.uk/ols4/help
- Available ontologies: https://www.ebi.ac.uk/ols4/ontologies

### Official MCP Resources

- **MCP Specification**: https://modelcontextprotocol.io/ - Official protocol specification and documentation
- **MCP Server Registry**: https://github.com/modelcontextprotocol/servers - Curated collection of community-maintained MCP servers covering databases, APIs, file systems, development tools, and more. Browse here to discover MCP servers for your workflows beyond ontology lookups.
- **Python SDK**: https://github.com/modelcontextprotocol/python-sdk - Build your own MCP servers in Python
- **TypeScript SDK**: https://github.com/modelcontextprotocol/typescript-sdk - Build your own MCP servers in TypeScript

### Ontology Resources

- **Gene Ontology**: http://geneontology.org/
- **ChEBI**: https://www.ebi.ac.uk/chebi/
- **Human Phenotype Ontology**: https://hpo.jax.org/
- **MONDO**: https://mondo.monarchinitiative.org/
- **OBO Foundry**: http://obofoundry.org/

### Configuration

- **CLI Config**: `~/.claude/.claude.json`
- **Desktop Config**: `~/.config/claude/claude_desktop_config.json`
- **Logs**: `~/.claude/logs/`

## Summary

In this tutorial, you learned:

✅ What MCPs are and why they're powerful for bioinformatics
✅ How to install the OLS MCP server with one command
✅ Querying multiple ontologies (GO, ChEBI, HP, MONDO)
✅ Building integrated cross-ontology research workflows
✅ When to use MCPs vs slash commands

**MCPs provide integrated access to biomedical ontologies directly in your development environment. You now have:**

- Access to 200+ ontologies through one interface
- Cross-ontology search and exploration capabilities
- Term relationships and hierarchies
- Integration with your existing slash commands from Tutorial 3

**This is how modern biocuration research works** - combining data from multiple ontologies (GO, ChEBI, HP, MONDO) to gain comprehensive insights into genes, diseases, phenotypes, and biological processes.

---

**Congratulations! You've completed all four Claude Code tutorials for biocuration!**

You now have the skills to:
- Navigate complex schemas and databases
- Automate repetitive biocuration tasks
- Query professional bioinformatics APIs
- Build reproducible research workflows

**Keep exploring, building, and sharing your workflows with the OBO community!**
