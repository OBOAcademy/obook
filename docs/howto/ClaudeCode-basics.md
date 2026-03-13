# Getting Started with Claude Code: A (super) Beginner's Guide

> _This document was created by Sabrina Toro and reviewed by Nico Matentzoglu, based on 1:1 sessions, workshops, and bootcamp training. The goal of this guide is to help curators and non-developers get started on their journey with Claude Code, from initial setup through everyday use, so they can confidently integrate it into their curation workflows. This document is a guideline and should not be considered as "the right way" to use Claude. Once more comfortable, Claude-code users should find the workflow that works best for them. It is also important to note that the field is changing very rapidely, and "best solutions" or "best practices" also change rapidely. 
Last reviewed March 2026_

---

## Part 1: What Is Claude Code?

Claude Code is an AI assistant that lives in your terminal (the text-based command window on your computer). It can read your files, help you write and edit code, plan tasks, and work alongside you on projects. Think of it as a very capable helper that sits inside your coding environment.

### Important Things to Keep in Mind

- Claude is not an oracle or an intelligent being. It is an extremely efficient tool. You should never rely on Claude alone to tell you *how* to do something — you need to provide it with context and information so it can help you find the answer.
- Claude is trained to please you. It will tend to agree with you and show you what you want to see. This means it is not always the best partner for debating ideas or getting pushback. Be aware of this.
- It is easy to go down a rabbit hole with Claude. Stay focused on your task.
- Claude cannot do work that you yourself cannot verify. For example, if you ask it to evaluate something, you need to explain and determine how this evaluation should be done. Claude can suggest evaluation paths that you might not have thought about, but ultimately, you will need to review, iterate, and decide on the best strategy.

---

## Part 2: Prerequisites

Before using Claude Code, you need:

1. **VS Code** or any other IDE (Integrated Development Environment) such as Cursor — this is your code editor. Download it from https://code.visualstudio.com if you don't have it.
2. **Claude Code installed** — follow the official installation instructions at https://github.com/anthropics/claude-code. Note: you will need a paid subscription to use Claude Code.
3. **GitHub Desktop installed** — download from desktop.github.com.

### Keeping Claude Code Up to Date

Run this command periodically in any terminal window to get the latest version:

```
brew upgrade claude-code
```

Note: it doesn't matter which folder you are in when you run this.

---

## Part 3: Getting Comfortable with the System

This section walks you through the basics: navigating VS Code, opening a terminal, starting Claude, understanding its modes, and managing sessions.

### 3.1 Walking Through VS Code

VS Code is where you will do most of your work. Here are the key things to know:

- **File explorer (left panel):** Shows all the files and folders in your project. Click to open files.
- **Editor (center):** Where you read and edit files.
- **Terminal (bottom panel):** Where you type commands and interact with Claude. Open it from the menu: Terminal → New Terminal.
- **Source control:** Changes you make to files show up here (and in GitHub Desktop, if you use it).

#### Exercise: Getting Comfortable with VS Code

1. Open a folder or repository in VS Code
2. Look at the file list on the left side — browse around to see what's there
3. Open a terminal window (Terminal menu → New Terminal)
4. Start Claude and ask it to make a small change (e.g., "Add 'you are all done' at the end of this document")
5. Observe how the change appears directly in the file in VS Code
6. If you use GitHub Desktop, open it and see how the change shows up there too (you can discard the change afterward)

### 3.2 Opening and Using Claude Code

1. Open VS Code
2. Navigate to the folder (repository) you want to work in
3. Open a terminal window
4. Type `claude` and press Enter

```
claude
```

That's it — Claude is now running and ready for you to chat with.

**Key point:** Wherever you start Claude is where it will work. Always open it from the root folder of your project. Claude can see all the files in that folder and its subfolders.

Once Claude is running, you simply type what you want in the terminal and press Enter. Claude will respond in the same terminal window.


#### Exercise: 
Ask Claude something. For example:
- "What files are in this project?"
- "Read the file README.md and summarize it for me"


### 3.3 Claude Modes

Claude has three modes. You switch between them by pressing **Shift + Tab**.

#### Default Mode (start here)
- Claude will **ask your permission** before making any changes to your files
- This is the safest mode for beginners
- Use this for most of your work

#### Plan Mode
- Claude will **not make any changes** at all
- It will only discuss, plan, and suggest what it *could* do
- Use this when you want to think through a problem before acting
- Great for creating a strategy or evaluation plan without accidentally changing anything

#### Accept Edits Mode
- Claude will make changes **without asking permission**
- Only use this once you are comfortable and trust what Claude is doing
- Always review changes afterward using `git diff`

**Recommendations for beginners:** 
- Stay in Default Mode until you feel confident. Use Plan Mode when you want to discuss a strategy without risk.
- Be cognizant of the authorization you give Claude. One should never blindly give full permission without understanding the consequences 

**Tips: what if I do not understand the permission it is asking for?** 
Ask Claude what it is doing or to explain the task. You can do this by either:
- selecting "no" and asking to explain the task
- type `/btw` at any point, even while Claude is running, and get an answer to a question
- type `Ctrl+E`; this will load an explanation. Use Tab to amend the options (and once the amendment has taken place, Claude will ask you again if it can proceed)




#### Exercise:
Switch from one mode to another by pressing **Shift + Tab**.


### 3.4 Closing and Restarting Claude

#### Closing Claude

Press **Control + C** twice. You must close Claude properly — if you don't, it stays running in the background.

#### Starting a Fresh Session

```
claude
```

This gives you a completely fresh start with no memory of previous conversations.

#### Continuing Where You Left Off

```
claude -c
```

The `-c` means "continue." Claude will reconnect to your previous session and remember the conversation.

#### Continuing an specific session

```
claude --session 9e9837498379874398374983749873984793874
```

The number is the session number from Claude. You can ask Claude to share this session number with you if you want to get back to it at a later point.


**When to start fresh vs. continue:**

| Start Fresh | Continue |
|---|---|
| New task or topic | Same task after a break |
| Claude seems confused | Need the previous context |
| It has been a long session | Short interruption |

#### Exercises:
Exercise 1:
- Ask something (or say something to Claude)
- close and reopen Claude using the "fresh start" option (ie type `claude`)
- Claude should say something like "you haven't asked me anything yet"

Exercise 2:
- Ask something (or say something to Claude)
- close and reopen Claude using the "start continue" option (ie type `claude -c`)
- Claude should show you the last question you asked (or the last thing you said)


#### Why Restarting Matters

Claude has a limited "attention span." The longer a session goes, the more it forgets what was said at the beginning. Over time, it may make mistakes or give confused answers. Restarting fresh clears this problem.

For a detailed approach to preserving progress across sessions (using summaries), see Part 6: Workflows, section 6.3.

---

## Part 4: Claude Setup and Security

This section covers how to configure Claude with context files (instructions it reads automatically) and settings files (hard guardrails on what it can and cannot do). Getting this right means Claude works the way you want from the moment you start it, and stays within the boundaries you set.

### 4.1 Context Files (CLAUDE.md)

Context files are instructions that Claude reads automatically every time it starts. They tell Claude about your project, your preferences, and your rules. You do not need to repeat this information every session.

There are three levels, from most specific to most general:

#### Level 1: CLAUDE.md (Project Level — Shared)

- Lives in the root folder of your project
- Shared with everyone who works on the project (it gets committed to the repository)
- Contains information about the project: what it is, how it's structured, what commands to use

**To create one for a new project**, you can ask Claude:

```
/init
```

This tells Claude to look at the project and create a CLAUDE.md with information about the repository structure, common commands, and other useful context. You can then edit it to add or correct information.

**Why have one?** You set it up once, and then every Claude session (for you and your teammates) starts with this shared understanding. When Claude makes errors, you can update the file to give it better context next time.

##### Exercise: Create a CLAUDE.md

1. Open the folder or repository (the root folder) in VS Code
2. In the terminal, type `/init` — this will automatically generate a CLAUDE.md file. Alternatively, ask Claude to create one for you.
3. **Test:** Review the generated file. Does it accurately summarize the project?
4. **Note:** Remember to update this file as you work on the project, and push it (along with any changes) to your repository.

#### Level 2: CLAUDE.local.md (Project Level — Personal)

- Lives in the root folder of your project, next to CLAUDE.md
- Only for you — it stays on your machine and is not shared
- Add it to your `.gitignore` so it doesn't get pushed to the repository
- Contains your personal preferences for this specific project

**Example content:**

```
Always tell me which git branch I am on.
Give me a short summary after each task.
Never add "Co-Authored-By Claude" to commits.
```

You don't need to write this in any special format. Plain text or markdown both work.

##### Exercise: Create a CLAUDE.local.md

1. Open the folder or repository (the root folder) in VS Code
2. Ask Claude: "Create a CLAUDE.local.md file that always reports which git branch I am on at the end of a conversation." (feel free to test another instruction of your choice.)
   - **Alternative:** Manually create a new file called `CLAUDE.local.md` in the project root and type the instruction yourself.
3. **Test:** Ask Claude something — anything. You should see the git branch reported at the end of the response.
4. **Note:** Remember to add this file to your `.gitignore` so it doesn't get pushed to the repository.

#### Level 3: CLAUDE.md in Your User Directory (Global — Personal)

- Located at `~/.claude/CLAUDE.md` (in your home directory)
- Applies to everything you do across all projects
- Only for you — stays on your machine

**Example content:**

```
Use terse messages.
Do not ever commit things under my name.
Stop adding pleasantries at the start of responses.
```

This is where you put preferences that apply no matter what project you're working on.

**Note:** After changing global files (settings or context), restart Claude to make sure the changes take effect.

##### Exercise: Create a Global CLAUDE.md

1. Open the `.claude` folder in your user directory (`~/.claude`). Note that this file might be hidden; you can press **Shift + Command + .** in a Mac to see these hidden folders.
2. Ask Claude to create a `CLAUDE.md` file in this user directory with a global instruction (e.g., "Always tell me how many tokens I used after a conversation"). Alternatively, manually create the file and add your instruction.
3. **Test:**
   - Open a different repository or folder and start Claude. If Claude is already open, close it (Control + C twice) and reopen it — this is needed for the changes to take effect.
   - Ask Claude something. You should see the instruction followed (e.g., token count reported at the end).

##### Extended Exercise: Customize Your Context Files

Add more instructions to any of these context files (local, global, and at the repository level), including instructions on things you *don't* want Claude to do. This is where you tailor Claude to your personal preferences and working style. Examples:

- "Never push or commit to GitHub"
- "Always explain your reasoning before making changes"
- "End every message with 'I am here to serve you, Your Highness'"

Experiment and have fun — there is no wrong answer here. You can always edit, add and remove items in these files at any time. 

### 4.2 Settings and Permissions

Beyond context files, you can set up guardrails that control what Claude is *allowed* or *denied* to do. These are stored in settings files, not in the CLAUDE.md files.

**The difference:**
- **CLAUDE.md** = context and instructions (Claude *should* follow these, but they are guidance)
- **Settings files** = hard guardrails (Claude *cannot* bypass these)

#### Setting Up Permissions

You can ask Claude directly:

> "Create a .claude folder and add a settings.local.json file and allow reading from this directory"

Or, permissions get created automatically the first time you approve something "for all sessions" when Claude asks for permission.

#### Settings Levels

- **Local** (`project/.claude/settings.local.json`) — rules for this project only
- **Global** (`~/.claude/settings.json`) — rules for all projects on your machine
- If local and global settings conflict, the **local** setting wins

##### Exercise: Set Up Local Settings

1. In your project, create a `.claude` folder and add a `settings.local.json` file that allows reading from the project directory. You can ask Claude to do this for you:
   > "Create a .claude folder and add a settings.local.json file and allow reading from this directory"
2. **Test:** Verify that Claude can read files in the project without prompting you for permission each time.

##### Exercise: Set Up Global Settings

1. Navigate to the `.claude` folder in your user directory (`~/.claude`)
2. Create or edit the `settings.json` file to add global permission rules (e.g., allowing read access everywhere, or denying commit/push actions)
3. **Test:** Open a different project and confirm your global settings apply.

##### Extended Exercise: Add More Permission Rules

Experiment with adding additional guardrails. Examples:

- Deny Claude from committing or pushing code
- Deny Claude from commenting on GitHub issues
- Allow Claude to run specific commands without asking

---

## Part 5: Skills
This section describes what Skills are, where they can be found, and created. There is a lot of more detailed information related to Skills, for example [here](xxxx)

### 5.1 What Are Skills?
Skills extend the ability of AI agents to do a given task in a reproducible way. They are
- instructions to teach an AI agent how to approach a specific task.
- Reusable documents written in natural language, mostly.
- Partially structured Markdown files with metadata and conventions.

Skills are NOT:
- code
- tooling for helping an AI agent use specific resources (see MCP later)
- storage for API keys or authorization tokens
- your full project docs

#### Structure of a Skill
- Skills follow formal open standard specifications (see https://agentskills.io/specification)
- Skills include
   - name and description: this is the only part of the Skill that the agents (eg Claude-code) will read when deciding whether or not to use a specific Skill
   - Body text: this explains what should be done and how (ie these are the instructions). This will be read ONLY when the Skill is used

**Notes**: 
- a Skill can refer to other Skills and other resources (eg scripts, reference documents, data files, etc)
- a Skill can be used by "any" agentic AI framework
- Skills are also helpful to document what NOT to do (eg do NOT add a contributor when creating a new term)


### 5.2 Finding and Installing Skills
There are a lot of places where Skills can be found and reused. 
For example: 
- AI4curation/curation-skills: https://github.com/ai4curation/curation-skills
- Anthropic official Skills repository: https://github.com/anthropics/skills
- Awesome Agent Skills (a meta-repository): https://github.com/VoltAgent/awesome-agent-skills

**How to find useful Skills? (and can I trust them?)** 
In the context of this (very) Beginner guidelines document, the simple answer is: talk to your colleagues (especially developers) who have more experience and have used and tested Skills. They can suggest or recommend useful and trustworthy Skills.

A list of useful Skills for curation tasks can be found here (link to come)

#### Installing a Skill
Example: let's install some Skills from the AI4Curation repository (https://github.com/ai4curation/curation-skills). These Skills include tools to use ODK and ROBOT.

- in Claude type: /plugin 
   This will open a window where one can navigate through several tabs (using the arrow or tab key) where the different Skills repository or marketplace can be found. 
- navigate to Marketplaces, and "Add MarketPlace". You can enter your market place source, in this example: https://github.com/ai4curation/curation-skills
- After your MarketPlace of choice is loaded, choose the plugin you want to install (eg editing-obo-ontologies)
Note that currently, one can only install one plugin at a time!! 
- Choose the level at which you want this Skill to be installed. It could be at any levels: local level (only for you on a specific repo), repo level (for all the teammates on the repo), or at the global level (for you across all repos) (see Part 4: Claude Setup and Security)

**Where are my installed Skills?**
- to see what Skills are available in your repo, you can go to Claude and type: /plugin , then navigate to "Installed"
- the Skills installed in a specific repository can be seen in the "settings.json" file in the .claude folder. The actual files are in the "plugins" folder of your computer folder ~/.claude.
- the Skills installed locally can be seen in the "settings.local.json" file in the .claude folder. The actual files are in the "plugins" folder of your computer folder ~/.claude.
- The Skills installed at the global level can be found in the "plugins" folder of your computer folder ~/.claude.

#### Exercise: Install a Skill

1. In Claude, type `/plugin` and navigate to the Marketplaces tab
2. Add the AI4Curation marketplace: https://github.com/ai4curation/curation-skills
3. Choose and install a Skill (e.g., editing-obo-ontologies)
4. **Test:** Type `/plugin` and navigate to "Installed" to confirm the Skill appears


**Keeping your Skills up-to-date**
As the AI models progress rapidly, Skills can also become out of date rapidly. It is therefore important to regularly update them. 
To update a skill (or enable the “automated update”), you can go to Claude and type:
- /plugin (this will open a chat with tabs)
- Select “marketplaces” (using the tab or arrow key)
- Select the marketplace of your choice
- Select “update” or “enable automated update”

### 5.3 Using Skills
- You can run a specific Skill by typing "/(name of the skill)". If an input is required, you can add it afterward. Claude will ask you if an input is required and you haven't submitted it
- You can also ask Claude to "use Skill X"

It is important to remember that 
- Claude is a good canvas to explore how to do some tasks, however, one cannot assume Claude knows how to use the tools and how to do things. While Skills help with learning "how to do" things, one might need to tell Claude which Skills to use.
- Claude only checks the name and description of a Skill to determine whether to use it or not. Once it has determined that it will use a Skill, it will load it, read it, and follow the instructions on how to use it.


### 5.4 Creating Skills
Sometimes, a task that we create (see Part 6: Workflows) can be reused to solve the same or similar issue in different context. For examples: add a new term in an ontology, analyze a github issue. In these cases, it is useful to turn this task into a Skill that can be shared with the rest of the team, and reused in these different contexts. 

**How to:**
- In a "clean" environment, create a task (see Part 6: Workflows) as specific as possible. Make sure to test this task, and iterate (testing and making changes) until the results are as expected. This step is the most important and the most time consuming step.
- When your task is created (ie you have a clear plan on what to do and what to execute), you can save this task as a markdown (.md) file and save it in your directory (.claude folder in your repository)
- Ask Claude to "create a Skill" based on the task.md and **based on the official most up-to-date documentation**. Claude will create it in the correct format and add it in the correct folder. 


**Tips**:
- It is ok (even preferable) to create several smaller Skills in order to create a "big Skill". For example, a Skill to "create a new ontology term" might include a Skill to check the ID to be used, check that the term does not already exist in the ontology, etc...
- One should be aware of **not overspecifying** a Skill. While it is crucial to be as specific as possible, a skill must be general enough to be reusable across projects and tasks. Therefore, one should be careful not to write the Skill in a way that is too specific to a particular resource or data set, especially if the intension is to reuse the Skill across different projects or tasks.

#### Other Resources
- https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf



### 5.5 Model Context Protocol (MCP)

MCP is a standardized system that allows agents like Claude to connect with external data sources, tools, and software applications. Instead of creating a Skill to explain how to use an API correctly, MCPs allow the connection to the external data sources more easily and "correctly". 
For example, the [OLS MCP server](https://www.ebi.ac.uk/ols4/mcp) allows Claude to access the information in OLS via an API, without us having to explain how to. 
You can add this MCP to your task, Skill, or CLAUDE.md to indicate that any ontology term ID should be found by going to OLS using the MCP.

For example: 

Useful MCP:
- [OLS MCP server](https://www.ebi.ac.uk/ols4/mcp)
- [PMC (for literature)](XXXX)

How to install:
- Ask Claude to install it by consulting the most up to date documentation





---

## Part 6: Workflows

This section describes recommended approaches for getting work done with Claude. These are based on Nico's workflow — **adapt them to what works best for you** once you're comfortable.

### 6.1 For Simple Tasks

For straightforward, well-defined tasks, just ask Claude directly in Default Mode:

> "Fix the typo in line 12 of README.md"

No special setup needed. Ask, review, approve.

### 6.2 For Complex Tasks

For bigger or more ambiguous tasks, a structured approach prevents wasted effort and keeps Claude focused.

#### Step 1: Start in a Clean Space

Consider creating a new folder for "thinking through" the problem, separate from the main project. This keeps your head clear and avoids premature changes to the codebase.

Example folder structure:

```
my-task/
  task.md          — description of the task (your brain dump)
  background/      — relevant papers, URLs, reference material
  data/            — files you need for the task
  .gitignore       — to exclude things you don't want tracked
```

#### Step 2: Write Down the Task in Your Own Words

Create a file (e.g., `task.md`) and describe what you want to do. It doesn't need to be formal — a brain dump is fine.

Example: "I want to validate the cross-references by comparing breed names and exact synonyms."

You can also ask Claude to help you refine this description: "Create an overview summary to describe the task so that Claude Code can understand it." Then review the result to make sure it makes sense and is complete.

#### Step 3: Plan Before You Act
This is the most important part of the workflow. 
You need to make sure you explain and describe exactly what needs to be done and how to do it. Remember: Claude is not an oracle, it needs to be told what to do and how to do it.
For example: if you ask it to evaluate, you need to explain how to do the evaluation. For example: use this specific skill, this is how to determine if X is correct, Y and Z are the same if XXX.

You can ask Claude to suggest how it would solve the issue, and have a back and forth discussion about changes in the plans, or about including the use of Skills. However, you are ultimately the expert and it is your responsibility to ensure that the solution offered makes sense

Note that it is helpful to switch to **Plan Mode** (Shift + Tab) for all your planning before making changes


**Important:** Review evaluation strategies carefully. Claude might suggest an approach you wouldn't have thought of, but you need to decide if you trust it. Remember — Claude cannot do work that you yourself cannot verify. If the plan includes an evaluation step, make sure you understand *how* the evaluation will work and whether you can confirm the results.

#### Step 4: Execute the Plan

Once the plan is solid, switch to **Default Mode** (and to the appropriate repository) and ask Claude to execute it:

> "Execute the plan we discussed"


#### Step 5: Review the Results

Use `git diff` to see what changed. Test the changes. Don't blindly trust the output.

### 6.3 Multi-Session Workflow (for tasks that span multiple days)

Large tasks often take more than one session. Since Claude's context degrades over long conversations, the trick is to preserve progress across fresh starts.

**End of a session:**

Ask Claude to save a summary before you close:

> "Create a summary of what we accomplished and save it to session-summary.md"

**Start of the next session:**

Start Claude fresh (just `claude`, not `claude -c`) and restore context:

> "Read session-summary.md and let's continue from there"

This gives you a clean context window with full knowledge of what was done before.


### 6.4 Tips for Effective Workflows

- **Break large tasks into smaller pieces.** Don't try to do everything at once. Validate each step before moving to the next.
- **Be specific about what you want.** Provide examples when possible.
- **Always review changes.** Use `git diff` to see exactly what changed. Test before committing.
- **Use Plan Mode for strategy, Default Mode for execution.** Don't go back and forth excessively between modes.
- **Restart Claude regularly.** Start fresh when switching major tasks. Use `-c` only for short interruptions on the same task.
- **Keep context files updated.** When Claude makes errors, update your CLAUDE.md to give it better context next time.

---

## Quick Reference

| Action | How |
|---|---|
| Start Claude | `claude` |
| Continue previous session | `claude -c` |
| Close Claude | Control + C (twice) |
| Switch modes | Shift + Tab |
| Update Claude | `brew upgrade claude-code` |
| Initialize project context | `/init` |
| Browse/install Skills | `/plugin` |
| Run a specific Skill | `/(skill-name)` |

| File | Location | Purpose |
|---|---|---|
| CLAUDE.md | Project root | Shared project context |
| CLAUDE.local.md | Project root | Your personal project preferences |
| ~/.claude/CLAUDE.md | Home directory | Your global preferences |
| .claude/settings.local.json | Project root | Project permission guardrails |
| ~/.claude/settings.json | Home directory | Global permission guardrails |

---
