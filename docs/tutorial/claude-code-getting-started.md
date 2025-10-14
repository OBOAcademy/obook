# Getting Started with Claude Code

Claude Code is Anthropic's official CLI tool that transforms Claude into a development environment assistant. Unlike web-based interfaces, Claude Code runs locally on your machine with direct access to your filesystem, terminal commands, and development tools.

**Official Documentation**: [Claude Code Overview](https://docs.claude.com/en/docs/claude-code/overview)

This document provides general background and information about Claude Code to help you understand its core concepts and capabilities. For hands-on lessons applying Claude Code to biocuration workflows, see the other parts of this tutorial: [Exploring LinkML Models with Claude Code](claude-code-linkml.md), [Creating Slash Commands for API Lookups](claude-code-slash-commands.md), and [Using MCPs for Ontology Lookups](claude-code-mcps.md). Please review this document to familiarize yourself with Claude Code before moving on to those practical lessons.

## What is Claude Code?

**Claude Code** is an interactive command-line interface that provides:

- **Direct file operations** - Read, write, and edit files conversationally
- **Command execution** - Run terminal commands with natural language
- **Tool integration** - Grep, glob, git operations, and more
- **Project awareness** - Understands your project structure and git status
- **Permission model** - You control what Claude can execute

**Key difference from web interfaces:**
- Web Claude: Upload files manually, copy/paste code, no direct execution
- Claude Code: Direct filesystem access, automatic tool selection, command execution

## Installation

Claude Code requires Node.js 18+ and is available via npm:

```bash
npm install -g @anthropics/claude-code
```

Verify installation:
```bash
claude --version
```

## Launching Claude Code

Start Claude Code in any directory:

```bash
claude
```

You'll see:
```
Claude Code vX.X.X
Type /help for commands or just start chatting!

Working directory: /your/current/path
Git status: Clean (on branch main)
```

Claude Code automatically detects:
- Current directory and file structure
- Git repository status
- Available tools and permissions

## Tool Overview

Claude Code has access to several built-in tools:

| Tool | Purpose | Example Use |
|------|---------|-------------|
| **Read** | Read file contents | Schema files, code, documentation |
| **Write** | Create new files | Scripts, config files, data |
| **Edit** | Modify existing files | Fix typos, update code, refactor |
| **Bash** | Execute commands | Git operations, build commands |
| **Grep** | Search file contents | Find patterns, search codebase |
| **Glob** | Find files by pattern | List all .yaml files |
| **WebSearch** | Search the web | Look up API documentation |

Claude automatically selects the appropriate tool based on your request.

## Permission Model

Claude Code will **ask permission** before:
- ❌ Writing or modifying files
- ❌ Executing shell commands
- ❌ Deleting anything

Permission dialog example:
```
Claude wants to run: `git status`
Allow? (yes/no/always):
```

**Options:**
- `yes` - Allow this once
- `no` - Deny this action
- `always` - Auto-approve this type of action for this session

**Security tip:** Start with individual approvals (`yes`) until you understand what Claude is doing!

## Essential Commands

Claude Code has special commands starting with `/`:

| Command | Purpose |
|---------|---------|
| `/help` | Show available commands |
| `/clear` | Clear conversation history |
| `/exit` | Exit Claude Code |
| `/reset` | Reset the session |

## Common Workflow Patterns

Below are some examples of how Claude Code works in different biocuration scenarios. These patterns demonstrate Claude Code's capabilities working with local files, databases, and APIs. Don't worry if some of the terminology seems unfamiliar—you'll learn about LinkML schemas, database queries, and API interactions in detail in the later parts of this tutorial. For now, focus on understanding the general workflow patterns and how Claude Code can assist at each step.

### Pattern 1: Explore → Understand → Modify

```
1. "What LinkML files are in this directory?"
2. "Read the CellLine class definition"
3. "Add a new slot called 'tissue_origin' with type string"
```

### Pattern 2: Search → Analyze → Report

```
1. "Find all files that reference BRCA1"
2. "Summarize how BRCA1 is used across these files"
3. "Create a markdown report of your findings"
```

### Pattern 3: Query → Transform → Export

```
1. "Query the database for all human genes"
2. "Convert the results to TSV format"
3. "Save it as human_genes.tsv"
```

## Best Practices

### ✅ DO:
- **Be specific** - "Read lines 10-50 of schema.yaml" vs "Read the file"
- **Iterate** - Build complexity step-by-step
- **Verify** - Ask Claude to show what changed
- **Use natural language** - No special syntax required

### ❌ DON'T:
- Blindly approve all permissions without reading
- Give vague instructions like "fix it"
- Assume Claude remembers files from previous sessions
- Skip verifying changes before committing

## Troubleshooting

### "Claude can't find the file"

Check your current directory:
```
What directory am I in? List all files here.
```

### "Permission denied"

Grant the necessary permissions when Claude asks. Claude explains what it needs and why.

### "Unexpected behavior"

Ask Claude to explain:
```
Can you explain what you just did step-by-step?
```

## Key Advantages for Biocuration

1. **Direct Database Access** - Query production databases conversationally
2. **LinkML Integration** - Read, understand, and modify schema files
3. **Batch Operations** - Process multiple files or records at once
4. **Git Integration** - Automatic git status, commit assistance
5. **Script Generation** - Create data validation or transformation scripts
6. **API Integration** - Query external APIs (UniProt, NCBI, etc.)

## Next Steps

Now that you understand Claude Code basics, explore more advanced features:

- **[Exploring LinkML Models with Claude Code](claude-code-linkml.md)** - Learn to navigate and extend AGR LinkML schemas
- **[Creating Slash Commands for API Lookups](claude-code-slash-commands.md)** - Build reusable workflows for ChEBI, GO, and other API lookups
- **[Using MCPs for Ontology Lookups](claude-code-mcps.md)** - Connect to EBI's Ontology Lookup Service for integrated ontology queries

## Resources

- **Claude Code Documentation**: https://docs.claude.com/en/docs/claude-code
- **GitHub Repository**: https://github.com/anthropics/claude-code
- **Installation Guide**: https://docs.claude.com/en/docs/claude-code/installation
- **MCP Servers**: https://github.com/modelcontextprotocol/servers

---

**Tip:** Claude Code shines for biocuration tasks that involve repetitive file operations, data validation, schema exploration, and database queries. Start with simple tasks and build up to complex workflows!

---

**Note on Content Generation**: This tutorial was developed with the assistance of Claude Code (Anthropic's AI-powered CLI tool) for content generation, organization, and technical accuracy verification. All examples and workflows have been tested and validated for educational purposes.
