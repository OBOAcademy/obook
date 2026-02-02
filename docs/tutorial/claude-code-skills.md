# Skills for Biocuration Workflows

This tutorial demonstrates how to create reusable skills that help with everyday curation tasks. Skills let you encode your expertise into workflows that Claude can follow consistently, saving time on repetitive lookups and decisions.

## Prerequisites

- Claude Code installed ([Getting Started guide](claude-code-getting-started.md))
- Familiarity with Claude Code basics from Tutorials 1 & 2

## What You'll Learn

1. What skills are and why they save you time
2. Creating a ChEBI lookup skill from scratch
3. Enhancing skills with Python scripts for batch processing
4. Sharing skills via git and marketplaces

## Part 1: What is a Skill? (5 minutes)

### The Problem

As a biocurator, you probably do the same kinds of lookups over and over:

- "What's this ChEBI compound?"
- "Which GO evidence code should I use here?"
- "Is this gene symbol correct in UniProt?"

Each time, you might:
1. Open a browser
2. Go to the database website
3. Type in your search
4. Navigate through results
5. Copy what you need back to your annotation

**Skills let Claude do this for you, the same way every time.**

### What is a Skill?

A **skill** is a saved set of instructions that Claude can follow. Think of it like:
- A recipe Claude can follow
- A workflow you've captured
- Your expertise written down

**Without a skill:**
```
You: Can you look up the ChEBI compound for water?
Claude: *figures out how to do it*

... an hour later ...

You: Can you look up the ChEBI compound for glucose?
Claude: *figures it out again from scratch*
```

**With a skill:**
```
You: /chebi water
Claude: *instantly follows saved workflow*

You: /chebi glucose
Claude: *instant again!*
```

### What's In a Skill?

At its simplest, a skill starts as instructions in a markdown file. But skills can grow to include:
- **Reference material** - Documentation Claude consults
- **Scripts** - Python or shell scripts for data processing
- **Templates** - Output formats Claude follows
- **Dynamic context** - Live data pulled when the skill runs

**The key thing:** You don't have to write code. Claude can help you create and enhance skills. You describe what you want, Claude builds it.

**Bonus:** Skills follow an open standard ([agentskills.io](https://agentskills.io)) - they work in Claude Code, Claude.ai, and other AI tools. Your investment in skills isn't locked to one platform. See the [official skills documentation](https://code.claude.com/docs/en/skills) for more details.

Here's a simple skill to start:

```markdown
---
name: chebi
description: Look up information about a chemical compound in ChEBI
---

Look up the ChEBI compound: $ARGUMENTS

Go to the ChEBI database and find:
- The compound name
- Chemical formula
- Definition
- Common synonyms

Show me the results in a simple table.
```

The `$ARGUMENTS` is replaced with whatever you type after `/chebi`.

---

## Part 2: Your First Skill - ChEBI Lookup (10 minutes)

[ChEBI](https://www.ebi.ac.uk/chebi/) (Chemical Entities of Biological Interest) is a database of molecular entities. Let's create a skill to look up compounds.

### Step 1: Create a Simple Skill

**Ask Claude:**
```
I'd like to create a skill that looks up compounds in ChEBI.

When I type /chebi followed by a compound name or ID,
you should look it up and show me the basic information.

Use your claude-code-guide to look up the correct skill format,
then create this skill for me.
```

Claude will:
- Create the skill file
- Figure out how to query ChEBI
- Set it up so you can use `/chebi`

> **Tip:** Notice how we asked Claude to **"use your claude-code-guide"** first. When you ask Claude to check its own documentation before a task, it brings the relevant information into its working memory. This helps Claude follow the correct formats and patterns, especially for Claude Code-specific features like skills.

### Step 2: Test It

**Type:**
```
/chebi water
```

**You should see something like:**
```
ChEBI Compound: CHEBI:15377
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Name:       water
Formula:    H2O
Definition: An oxygen hydride consisting of an oxygen
            atom bonded to two hydrogen atoms.
Synonyms:   H2O, oxidane, dihydrogen oxide
```

### Step 3: Improve It

**Did errors show up?** Sometimes lookups fail or have issues. If Claude hit errors during the lookup, just ask it to fix the skill:

**Ask Claude:**
```
The ChEBI lookup had some errors. Can you update the skill
to fix those and make it work more reliably?
```

Claude will update the skill file, and future lookups should work better.

**Want different output?** Just tell Claude what you'd prefer:

**Ask Claude:**
```
Can you update the /chebi skill to also show:
- The molecular weight
- Links to related compounds
- The ChEBI URL so I can click through

Also, if I give it a CHEBI ID instead of a name,
it should still work.
```

Claude updates the skill, and your improvements are saved for next time.

### Step 4: Try More Compounds

```
/chebi glucose
/chebi CHEBI:17234
/chebi caffeine
```

You didn't need to know anything about APIs, JSON, or web requests. You just described what you wanted.

---

## Part 3: Enhancing Skills with Python Scripts (10 minutes)

### When You Need More Power

Sometimes you need to process data that's too complex for simple lookups:
- Parse a file format
- Transform data between formats
- Do calculations
- Generate reports

**Skills can include Python scripts** that Claude runs for you.

### Example: Batch ChEBI Lookup

You have a list of compound names and need ChEBI IDs for all of them.

**Ask Claude:**
```
I often need to look up a list of compounds and get their ChEBI IDs.

Can you enhance the /chebi skill so that if I give it a file
with one compound per line, it looks them all up?

Add a Python script to handle the batch processing.

Give me back a table with the compound name, ChEBI ID,
and formula for each one.
```

Claude creates a Python script to handle the batch processing and updates the skill to use it.

**Then you can use it like:**
```
/chebi compounds.txt
```

### Check What Was Created

**Ask Claude:**
```
Show me what's in the chebi skill folder now.
```

You might see:
```
~/.claude/skills/chebi/
├── SKILL.md              # Main instructions
└── scripts/
    └── batch_lookup.py   # Python script for batch processing
```

### Key Point: You Don't Write the Scripts

You describe what you want. Claude writes and updates the Python scripts. If something doesn't work:

```
The batch lookup is timing out on large files.
Can you make it process in smaller batches?
```

Claude fixes the script for you.

---

## Part 4: Sharing Skills with Your Team (5 minutes)

### Where Skills Live

**Your personal skills (all projects):**
```
~/.claude/skills/
```

**Project-specific skills (shared via git):**
```
your-project/.claude/skills/
```

### Share with Your Curation Team

Skills are folders you can share through git - just like any other project files.

**Ask Claude:**
```
Can you copy my personal /chebi skill into this project's
.claude/skills/ folder so my team can use it too?
```

Then commit to git:
```
git add .claude/skills/
git commit -m "Add ChEBI lookup skill for the team"
git push
```

Now everyone on your team can use `/chebi`.

### Skill Libraries

Organizations can maintain libraries of skills for their curators:
- Common lookups for your MOD's databases
- Annotation workflows
- QC checks
- Report generation

---

## Part 5: Marketplaces - Sharing Skills at Scale (5 minutes)

> **Note:** The Alliance marketplace shown below is for **internal Alliance developers only** and is not intended for public use. It's included here as an example to demonstrate the potential of marketplaces. Your organization can create your own marketplace using the same approach.

### What is a Marketplace?

A [marketplace](https://code.claude.com/docs/en/plugin-marketplaces) is a curated collection of skills that you can install with a single command.

**Think of it like:**
- An app store for Claude Code
- A way to share your team's workflows
- Version-controlled skill distribution

### Why Marketplaces Matter

**Without marketplaces:**
```
"Hey, I made this great Jira skill!"
"Cool, can you send me the files?"
*emails zip file*
"Where do I put these?"
"It's not working..."
```

**With marketplaces:**
```
/plugin marketplace add alliance-genome/agr_claude_code
/plugin install alliance-jira@alliance-plugins
```

Done! Everyone gets the same version, updates are easy.

### Adding a Marketplace

```
/plugin marketplace add alliance-genome/agr_claude_code
```

### Browsing and Installing

```
/plugin browse                              # See what's available
/plugin install my-skill@marketplace-name   # Install a skill
/plugin marketplace update                   # Get updates
```

### Creating Your Own Marketplace

Any organization can create a marketplace:

1. Create a GitHub repository
2. Add a `marketplace.json` file with your skill catalog
3. Add your skills in a `plugins/` directory
4. Share with your team: `/plugin marketplace add your-org/your-repo`

---

## Part 6: Demo - The Alliance Jira Skill (5 minutes)

### A Production Skill in Action

The **Alliance of Genome Resources** maintains a Jira skill that our team uses daily. This demonstrates what a mature, production-quality skill looks like.

> **Note:** The Jira skill is for **internal Alliance use only** - it's configured for our specific Jira projects (KANBAN, SCRUM, AGRHELP). However, the **code is open source** and available at [github.com/alliance-genome/agr_claude_code](https://github.com/alliance-genome/agr_claude_code). Your organization can use it as a template for your own Jira or GitHub skills.

### What the Skill Can Do

**Quick ticket creation:**
```
/jira Create a task on the Kanban board: "Update ChEBI mapping for new compound class"
```

**Finding tickets by component:**
```
/jira Find open epics with the AI Curation component on the Kanban board
```

**Status checks:**
```
/jira What's the status of KANBAN-912?
/jira What tickets am I working on on the Kanban board?
```

> **Note:** The Blue Team at the Alliance uses this same skill for sprint management - reviewing what's in the current sprint, tracking completions, etc. The skill adapts to different board workflows.

### Skill Structure (Advanced Example)

```
skills/jira/
├── SKILL.md              # Main instructions (282 lines!)
├── setup.md              # First-time setup guide
├── operations/
│   ├── search-tickets.md   # Search patterns
│   ├── create-tickets.md   # Creating tickets
│   └── update-tickets.md   # Status changes
└── reference/
    ├── projects.md         # Project IDs
    ├── issue-types.md      # Bug, Task, Story
    └── statuses.md         # Status transitions
```

**Key patterns demonstrated:**
- Modular files (Claude loads only what's needed)
- Reference data for IDs and transitions
- Safety rules ("Only modify tickets assigned to you")
- Setup workflow for credentials

### For Your Organization

You can create similar skills for:
- **Your Jira instance** - customize for your projects
- **GitHub Issues** - ticket tracking via GitHub
- **Internal tools** - any system with an API

The Alliance Jira skill is a template you can adapt!

---

## Common Issues & Solutions

### "Skill not found"

**Ask Claude:**
```
I typed /chebi but it says skill not found.
Can you check where my skills are and fix this?
```

### "The lookup isn't finding my compound"

**Ask Claude:**
```
/chebi isn't finding "3-phosphoglycerate" -
can you try alternative names or partial matching?
```

### "I want to change how the output looks"

**Just tell Claude:**
```
Can you update /chebi to show the output
as a markdown table instead?
```

### "The batch processing is too slow"

**Tell Claude:**
```
The batch lookup is slow on my 500-compound file.
Can you make it faster?
```

---

## Key Takeaways

**Skills save time** - Create once, use forever

**Just describe what you want** - Claude figures out the technical details

**Add reference material** - Skills consult official documentation

**Python scripts when needed** - Claude writes them for you

**Share via git or marketplaces** - Team productivity at scale

**Start with skills** - Many curation tasks don't need MCPs

---

## Quick Reference

### Creating a Skill

**Say:**
```
Create a skill called /[name] that [does what you want].
```

### Testing a Skill

**Just type:**
```
/[name] [your input]
```

### Improving a Skill

**Say:**
```
Update the /[name] skill to also [new capability]
```

### Skill Ideas for Biocurators

The `/chebi` skill we built is just the start. You could create similar skills for:
- Gene Ontology term lookups
- UniProt protein information
- Ortholog checking across species
- PubMed reference lookups

---

## Resources

### Claude Code Documentation

- **Skills**: https://code.claude.com/docs/en/skills
- **Marketplaces**: https://code.claude.com/docs/en/plugin-marketplaces
- **MCPs**: https://code.claude.com/docs/en/mcp

### Bioinformatics Resources

- **ChEBI Database**: https://www.ebi.ac.uk/chebi/

### Alliance Resources

- **Alliance Marketplace**: https://github.com/alliance-genome/agr_claude_code

### Standards

- **Agent Skills Open Standard**: https://agentskills.io

---

## Next Steps

Ready to connect Claude Code to external systems with persistent connections?

→ **[MCPs for Bioinformatics](claude-code-mcps.md)**: Learn about MCPs (Model Context Protocol) for database connections, complex authentication, and specialized bioinformatics tools!

---

**Great work!**

You can now:
- Create skills for your curation workflows
- Enhance skills with Python scripts for batch processing
- Share skills with your team via git
- Install skills from marketplaces
