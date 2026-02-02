# MCPs for Bioinformatics

This tutorial demonstrates when and how to use MCPs (Model Context Protocol) for persistent connections and complex integrations. While skills handle most curation tasks, MCPs provide access to external systems that require live connections, complex authentication, or specialized protocols.

## Prerequisites

- Claude Code installed ([Getting Started guide](claude-code-getting-started.md))
- Completed Tutorials 1-3 (especially the Skills tutorial)
- Node.js 18+ installed (for running MCP servers)

## What You'll Learn

1. When skills aren't enough and you need MCPs
2. How MCPs extend Claude Code's capabilities
3. Installing and using the OLS MCP for ontology lookups
4. Finding and installing other bioinformatics MCPs

## Part 1: When Skills Aren't Enough (5 minutes)

### Quick Recap: Skills vs MCPs

In Tutorial 3, we learned that **skills teach Claude how to do things**. They're great for:
- Looking up compounds, genes, ontology terms
- Processing files and formatting data
- Decision support and workflows
- Sharing expertise via marketplaces

**But sometimes you need more power.**

### When You Need MCPs

**MCPs give Claude access to external systems.** Use them when you need:

| Need | Why MCP Helps |
|------|---------------|
| **Persistent connections** | Database sessions that stay open |
| **Complex authentication** | OAuth, token refresh, API key management |
| **Structured tool schemas** | Multiple related operations (31 NCBI tools!) |
| **Real-time data** | Live queries, not cached responses |
| **Specialized protocols** | Beyond simple HTTP/REST |

From [Anthropic's documentation](https://claude.com/blog/skills-explained):

> "MCP connects Claude to data; Skills teach Claude what to do with that data."

**They work together:**
- An MCP connects Claude to your database
- A skill teaches Claude your data model and query patterns

---

## Part 2: Understanding MCPs (5 minutes)

### What is an MCP?

**MCP** = [Model Context Protocol](https://modelcontextprotocol.io/)

Think of MCPs as **plugins** or **extensions** that give Claude Code new capabilities.

**Analogy:**
- **Claude Code** = Your web browser
- **MCPs** = Browser extensions (like ad-blockers, password managers)
- Each MCP adds specific new capabilities

### How MCPs Work

```
┌─────────────────────┐
│   Claude Code       │
│   "Find GO:0008150" │
└──────────┬──────────┘
           │
           │ Uses MCP Tool
           ↓
┌─────────────────────┐
│   OLS MCP Server    │  ← Runs on your machine
│   (ontology tools)  │
└──────────┬──────────┘
           │
           │ Queries API
           ↓
┌─────────────────────┐
│   OLS API           │
│   (EBI servers)     │
└─────────────────────┘
```

### Built-in vs MCP Tools

**Built-in tools (what Claude Code has by default):**
- Read/Write/Edit files
- Run bash commands
- Search with grep
- Web search
- File navigation

**MCP tools (what you can add):**
- **OLS** - Ontology Lookup Service queries
- **NCBI Datasets** - 31 tools for genomes, genes, taxonomy
- **PostgreSQL** - Direct database connections
- **Custom APIs** - Your lab's internal services

---

## Part 3: Skills vs MCPs - When to Use Each (5 minutes)

Now that you understand what MCPs are, you might be wondering: "Wait, skills also let Claude interact with external data. What's the difference?"

### The Core Distinction

From the [Anthropic documentation](https://code.claude.com/docs/en/features-overview):

> "MCP gives Claude the ability to interact with external systems. Without MCP, Claude can't query your database or post to Slack."
>
> "Skills give Claude knowledge about how to use those tools effectively, plus workflows you can trigger with `/<name>`."

**In short:**
- **Skills** = Instructions on *how* to do things
- **MCPs** = *Access* to external tools and data

### How They Work Together

From the docs: "An MCP server connects Claude to your database. A skill teaches Claude your data model, common query patterns, and which tables to use for different tasks."

| Use Case | MCP Does | Skill Does |
|----------|----------|------------|
| Database queries | Connects to database | Documents schema, query patterns |
| Jira management | API authentication | Workflow rules, transition logic |
| Ontology lookup | (not always needed) | Query patterns, output formatting |

### When Skills Are Enough

For most curation tasks, skills work fine:

- API lookups (like our ChEBI skill)
- Processing files (GAF, TSV, YAML)
- Decision support and workflows
- Format conversions

### When You Need MCPs

Use MCPs when you need:

- **Persistent database connections** - Direct SQL queries
- **Complex authentication** - OAuth, institutional SSO
- **Stateful connections** - Sessions that persist across requests
- **Specialized tools** - 31 NCBI tools, browser control, etc.

### The Practical Rule

**Start with skills.** If you find yourself needing persistent connections, complex auth, or specialized protocols, then consider an MCP.

---

## Part 4: The OLS MCP - Ontology Lookups (15 minutes)

### Why an MCP for Ontologies?

In Tutorial 3, we created a ChEBI lookup skill. Skills work great for simple lookups!

**But the OLS MCP provides:**
- Structured search across **250+ ontologies**
- Parent/child term navigation
- Cross-ontology queries
- Semantic similarity searches
- Consistent response format

### What is OLS?

The [Ontology Lookup Service (OLS)](https://www.ebi.ac.uk/ols4/) from EBI provides access to:
- Gene Ontology (GO)
- Human Phenotype Ontology (HP)
- Chemical Entities of Biological Interest (ChEBI)
- Disease Ontology (DO)
- And 250+ more ontologies!

The [OLS MCP server](https://github.com/seandavi/ols-mcp-server) was created by Sean Davis (NCI/NIH, CU Cancer Center) specifically to prevent LLMs from hallucinating ontology terms.

### Step 1: Install the OLS MCP

**Ask Claude:**
```
Can you help me install the OLS MCP server?
I want to be able to look up ontology terms directly.
```

Claude will:
- Check if you have Node.js installed
- Clone the OLS MCP repository
- Build and configure it
- Add it to your Claude Code configuration

### Step 2: Restart Claude Code

After installation, restart to load the new MCP:

```
/exit
claude
```

You should see:
```
✓ Loaded MCP: ols (6 tools)
```

### Step 3: Try It Out

**Search for a term:**
```
Using the OLS MCP, search for "apoptosis" in the Gene Ontology
```

**Get term details:**
```
Get detailed information about GO:0006915
```

**Find parent terms:**
```
What are the parent terms of GO:0006915?
```

**Cross-ontology search:**
```
Search for "diabetes" across all ontologies
```

### OLS MCP Tools

| Tool | What it does |
|------|--------------|
| `search_terms` | Search for terms across ontologies |
| `get_term_info` | Get detailed info about a specific term |
| `get_term_children` | Get child terms |
| `get_term_ancestors` | Get parent/ancestor terms |
| `get_ontology_info` | Get info about an ontology |
| `find_similar_terms` | Find semantically similar terms |

### Skill + MCP: Better Together

You can create a skill that uses your MCP more effectively:

**Ask Claude:**
```
Create a skill called /ontology that uses the OLS MCP.

When I give it a term ID or search term, it should:
- Look up the term details
- Show me the parent terms for context
- Format the output nicely

This skill should make use of the OLS MCP tools.

Use your claude-code-guide to look up the correct skill format,
then create this skill for me.
```

**The MCP provides access; the skill provides methodology!**

### Try Your New Skill

Once Claude creates the skill, test it out:

```
/ontology GO:0006915
```

You should see the term details, definition, synonyms, and parent hierarchy for "apoptotic process" - all formatted nicely by your skill using the OLS MCP under the hood.

---

## Part 5: Other Bioinformatics MCPs (5 minutes)

### Available MCPs

The MCP ecosystem is growing. Here are some relevant to bioinformatics:

| MCP | What it does | Repository |
|-----|--------------|------------|
| **OLS** | Ontology lookups | github.com/ctabone/ols-mcp-server |
| **NCBI Datasets** | Genomes, genes, taxonomy | github.com/modelcontextprotocol/servers |
| **PostgreSQL** | Database queries | github.com/modelcontextprotocol/servers |
| **Filesystem** | File operations | Built-in |

### Finding MCPs

**MCP Server Registry:** https://github.com/modelcontextprotocol/servers

**Ask Claude:**
```
What MCPs are available for bioinformatics work?
```

### Installing Other MCPs

The process is similar for most MCPs:

1. Clone the repository
2. Install dependencies (`npm install`)
3. Build (`npm run build`)
4. Add to your configuration
5. Restart Claude Code

**Ask Claude to help:**
```
I want to install the NCBI Datasets MCP.
Can you help me set it up?
```

---

## Part 6: MCP Best Practices (5 minutes)

### Security

**DO:**
- Store API keys in MCP environment variables
- Never commit API keys to git
- Use `.gitignore` for sensitive configs

**DON'T:**
- Hardcode keys in configuration files
- Share API keys via chat/email

### Performance

**DO:**
- Only install MCPs you actually use
- Use skills for simple API calls (lower overhead)
- Check MCP status with `/mcp`

**DON'T:**
- Install every MCP you find (slower startup)
- Use MCP for one-time lookups (skill is simpler)

### Choosing Skills vs MCPs

| Task | Best Tool | Why |
|------|-----------|-----|
| Simple API lookup | Skill | Just needs curl |
| Complex ontology navigation | MCP | Multiple related operations |
| One-off formatting | Skill | Quick to create |
| Database queries | MCP | Persistent connection |
| Decision support | Skill | Encodes expertise |

---

## Troubleshooting

### "MCP failed to load"

**Ask Claude:**
```
The OLS MCP isn't loading. Can you help me debug it?
```

Claude will check:
- Is Node.js installed?
- Was the build successful?
- Is the path in configuration correct?

### "MCP tools not appearing"

**Try:**
```
/mcp
```

This shows which MCPs are loaded and their tools.

### "Slow MCP responses"

Some MCPs query external APIs. Slow responses usually mean:
- The external API is slow
- Network issues
- Large result sets

**Ask Claude:**
```
Can you limit the OLS search to just 5 results?
```

---

## Key Takeaways

**MCPs for persistent connections** - Databases, authenticated APIs

**Skills for workflows** - Decision support, formatting, methodology

**They work together** - MCP provides access, skill provides expertise

**Start with skills** - Add MCPs when you need the extra power

**OLS MCP is great for curation** - 250+ ontologies at your fingertips

---

## Resources

### MCP Resources

- **MCP Specification**: https://modelcontextprotocol.io/
- **MCP Server Registry**: https://github.com/modelcontextprotocol/servers
- **OLS MCP**: https://github.com/seandavi/ols-mcp-server

### Documentation

- **Claude Code MCP Docs**: https://code.claude.com/docs/en/mcp
- **OLS API**: https://www.ebi.ac.uk/ols4/

---

## What's Next?

**You've completed all 4 tutorials!**

### The Full Tutorial Arc

```
Tutorial 1: Learn Claude Code basics
    ↓
Tutorial 2: Explore AGR LinkML Schema
    ↓
Tutorial 3: Create Skills & Use Marketplaces
    ↓
Tutorial 4: MCPs for External Systems
```

### What You Can Do Now

- Navigate and modify LinkML schemas
- Create custom skills for your workflows
- Share tools via marketplaces
- Connect to external systems via MCPs
- Combine skills + MCPs for powerful integrations

---

**Congratulations! You're now a Claude Code power user!**

**Remember:** Start with skills, add MCPs when needed!
