# Claude Code Feature Development Workflow

This directory contains a sequential command workflow for transforming user requirements into fully implemented, tested features using multi-persona collaboration and behavioral TDD.

## Overview

The workflow consists of 5 numbered commands that build upon each other:

1. **Gather Requirements** → 2. **Epic Planning** → 3. **Feature Refinement** → 4. **TDD Implementation** → 5. **Verify Completion**

## Key Features

- **Context Persistence**: Commands share context through `.project-context` file
- **Project-Aware**: Adapts approach based on project type (MVP, POC, Enterprise)
- **Multi-Persona Collaboration**: Uses 6 engineering personas for comprehensive planning
- **Behavioral TDD**: Ensures focused, test-driven implementation
- **Minimal Artifacts**: Only creates 2 documents (requirements.md and epic.md)

## Command Flow

### 1. Gather Requirements (`/1-gather-requirements`)

**Purpose**: Deep understanding of user needs and context

**What it does**:
- Determines project type (MVP, POC, etc.)
- Explores the problem space through dialogue
- Creates comprehensive requirements document
- Stores context for subsequent commands

**Output**: 
- `./project-management/requirements/[feature]-requirements.md`
- `.project-context` file with PROJECT_TYPE and paths

**Next**: Automatically suggests `/2-epic-planning`

### 2. Epic Planning (`/2-epic-planning`)

**Purpose**: Transform requirements into actionable epic with features

**What it does**:
- Loads requirements from context
- Facilitates multi-persona planning meeting
- Product Owner drives business value
- Team Lead has final say on technical approach
- Breaks down into prioritized features

**Output**: 
- `./project-management/epics/[epic-name].md`
- Updated `.project-context` with EPIC_PATH

**Next**: Suggests `/3-feature-refinement [feature-name]`

### 3. Feature Refinement (`/3-feature-refinement [feature-name]`)

**Purpose**: Deep technical planning for specific features

**What it does**:
- Loads epic from context
- Technical personas collaborate on implementation
- Defines tasks, API contracts, test strategy
- Updates epic document with technical details
- Team Lead ensures simplicity

**Output**: 
- Updated epic.md with refined feature details
- Technical decisions and approach documented

**Next**: Suggests `/4-tdd-implementation [task-name]`

### 4. TDD Implementation (`/4-tdd-implementation [task-name]`)

**Purpose**: Implement tasks using behavioral test-driven development

**What it does**:
- Discovers test framework automatically
- Follows strict RED-GREEN-REFACTOR cycle
- Writes behavioral tests first
- Implements minimal code to pass
- Maintains focus on acceptance criteria
- Never deletes tests without good reason

**Output**: 
- Implemented code with full test coverage
- Updated context with progress

**Next**: Suggests next task or `/5-verify-completion`

### 5. Verify Completion (`/5-verify-completion`)

**Purpose**: Ensure feature meets all requirements

**What it does**:
- Traces requirements to implementation
- Runs all quality checks
- Verifies test coverage
- Checks documentation
- Confirms operational readiness

**Output**: 
- Verification report
- Pass/Fail status
- Next steps (PR creation or fixes needed)

## Context Management

The workflow uses `.project-context` file to persist:
- `PROJECT_TYPE`: MVP, POC, Enterprise, etc.
- `REQUIREMENTS_PATH`: Path to requirements document
- `DOCS_PATH`: Where artifacts are stored
- `EPIC_PATH`: Path to current epic
- `LAST_REFINED_FEATURE`: Most recent refinement
- `LAST_IMPLEMENTED_TASK`: Most recent implementation

## Best Practices

1. **Start Fresh**: Begin with `/1-gather-requirements` for new features
2. **Sequential Flow**: Follow the numbered order for best results
3. **Project Type Matters**: MVP favors simplicity, Enterprise favors robustness
4. **Trust the Team Lead**: They prevent over-engineering
5. **Test First**: Never skip the TDD red phase
6. **Verify Often**: Run `/5-verify-completion` after major milestones

## Token Efficiency

This workflow minimizes token usage by:
- Eliminating duplicate artifacts (no separate spec.yml)
- Using context persistence instead of re-parsing
- Updating documents in-place vs creating new ones
- Focusing personas only on relevant features

## Example Usage

```bash
# Start a new feature
/1-gather-requirements Add user authentication to our app

# After requirements are gathered
/2-epic-planning

# Refine the login feature
/3-feature-refinement User Login

# Implement the first task
/4-tdd-implementation Create login API endpoint

# Continue with more tasks...
/4-tdd-implementation Add login form component

# Verify everything works
/5-verify-completion

# Ready for PR!
```

## Customization

- Personas can be modified in `/ai-docs/personas/`
- Add project-specific context to `CLAUDE.md`
- Extend commands by copying and modifying existing ones