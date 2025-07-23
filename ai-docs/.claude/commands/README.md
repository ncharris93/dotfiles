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
- **Feature Status Tracking**: Organizes feature-spec.yml files by status (planned/in-progress/done)
- **Epic-Specific Context**: Each epic has its own folder structure and context isolation

## Command Flow

### 1. Gather Requirements (`/1-gather-requirements`)

**Purpose**: Deep understanding of user needs and context

**What it does**:
- Determines project type (MVP, POC, etc.)
- Explores the problem space through dialogue
- Creates comprehensive requirements document
- Stores context for subsequent commands

**Output**: 
- `./project-management/[epic-name]/requirements.md`
- `./project-management/[epic-name]/` folder structure with status subfolders
- Root `.project-context` file with meta documents configuration
- `./project-management/[epic-name]/.project-context` file with epic-specific context

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
- `./project-management/[epic-name]/epic.md`
- Epic document with feature breakdown and technical approach

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
- `./project-management/[epic-name]/planned/[feature-name]-spec.yml`
- Detailed feature specification with tasks and technical approach

**Next**: Suggests `/4-tdd-implementation [task-id]` (first task from the feature)

### 4. TDD Implementation (`/4-tdd-implementation [task-id]`)

**Purpose**: Implement individual tasks using behavioral test-driven development

**What it does**:
- Finds the feature containing the specified task_id
- Auto-moves feature-spec.yml from `planned/` to `in-progress/` (if first task)
- Updates specific task status from 'pending' to 'in-progress'
- Discovers test framework automatically
- Follows strict RED-GREEN-REFACTOR cycle
- Writes behavioral tests first (focused on task acceptance criteria)
- Implements minimal code to pass
- Maintains focus on single task scope
- Never deletes tests without good reason
- Marks task as 'completed' when done

**Output**: 
- Implemented code with full test coverage for the task
- Task marked as completed with completion date
- Status summary of other tasks in the feature
- Updated context with progress

**Next**: Suggests next task or `/5-verify-completion [task-id]` or `/5-verify-completion [feature-name]`

### 5. Verify Completion (`/5-verify-completion [task-id|feature-name]`)

**Purpose**: Verify task completion or full feature readiness

**What it does**:
- **Task Verification**: Confirms specific task implementation meets acceptance criteria
- **Feature Verification**: Ensures all tasks are complete and feature meets requirements
- Traces requirements to implementation
- Runs all quality checks
- Verifies test coverage
- Checks documentation
- Confirms operational readiness
- Auto-moves feature-spec.yml from `in-progress/` to `done/` (feature verification only)

**Output**: 
- Verification report (task or feature scope)
- Pass/Fail status
- Task completion confirmation OR Feature moved to done status
- Next steps (continue with tasks, verify feature, or create PR)

## Context Management

The workflow uses a dual-context approach for maximum flexibility:

**Root `.project-context` (project-wide meta documents):**
- `META_DOCS`: Comma-separated list of meta document paths to load for context

**Epic-specific `.project-context` (per epic folder):**
- `PROJECT_TYPE`: MVP, POC, Enterprise, etc.
- `DOCS_PATH`: Where artifacts are stored (./project-management)
- `EPIC_NAME`: This epic's name
- `REQUIREMENTS_PATH`: Path to this epic's requirements document
- `EPIC_PATH`: Path to this epic's planning document
- `LAST_IMPLEMENTED_TASK`: Most recent task implementation
- `LAST_IMPLEMENTED_FEATURE`: Most recent feature implementation

This approach ensures epic isolation while allowing project-wide meta document integration.

## Meta Document Configuration

When starting a new project, configure meta documents in command 1:

**Example configurations:**

```bash
# Standard ai-docs structure
META_DOCS=./ai-docs/strategies/code-style-strategy.md,./ai-docs/strategies/testing-strategy.md,./ai-docs/strategies/logging-strategy.md

# With architecture documentation
META_DOCS=./ai-docs/strategies/code-style-strategy.md,./ai-docs/strategies/testing-strategy.md,./ai-docs/context/architecture.md

# Custom project structure
META_DOCS=./docs/engineering-standards.md,./docs/api-guidelines.md,./compliance/security-requirements.md
```

All commands automatically load these documents for context, ensuring consistent implementation across all epics.

## Best Practices

1. **Start Fresh**: Begin with `/1-gather-requirements` for new features
2. **Sequential Flow**: Follow the numbered order for best results
3. **Project Type Matters**: MVP favors simplicity, Enterprise favors robustness
4. **Trust the Team Lead**: They prevent over-engineering
5. **Test First**: Never skip the TDD red phase
6. **Verify Often**: Run `/5-verify-completion` after major milestones

## Project Structure

Each epic creates a self-contained folder structure:

```
./project-management/[epic-name]/
├── .project-context          # Epic-specific context
├── requirements.md           # Initial requirements
├── epic.md                  # Epic planning document
├── planned/                 # Feature specs ready for implementation
│   └── [feature]-spec.yml   # Contains tasks with status: 'pending'
├── in-progress/            # Features currently being implemented
│   └── [feature]-spec.yml   # Contains tasks with mixed status: 'pending'/'in-progress'/'completed'
└── done/                   # Completed features
    └── [feature]-spec.yml   # All tasks have status: 'completed'
```

**Task Status Tracking within feature-spec.yml:**
```yaml
implementation:
  detailed_tasks:
    - id: 'login-api'
      status: 'completed'      # pending/in-progress/completed
      started_date: '2024-01-15'
      completed_date: '2024-01-16'
    - id: 'login-ui'
      status: 'in-progress'
      started_date: '2024-01-16'
    - id: 'validation'
      status: 'pending'
```

## Token Efficiency

This workflow minimizes token usage by:
- Epic-specific context isolation prevents information bleeding
- Using context persistence instead of re-parsing
- Status-based organization provides clear feature tracking
- Focusing personas only on relevant features

## Example Usage

```bash
# Start a new feature
/1-gather-requirements Add user authentication to our app

# After requirements are gathered
/2-epic-planning

# Refine the login feature (creates tasks: login-api, login-ui, validation)
/3-feature-refinement User Login

# Implement first task in the feature
/4-tdd-implementation login-api

# Verify the task works
/5-verify-completion login-api

# Continue with next task
/4-tdd-implementation login-ui

# Implement final task
/4-tdd-implementation validation

# Verify entire feature is complete (moves to done/)
/5-verify-completion User Login

# Ready for PR!
```

## Customization

- Personas can be modified in `/ai-docs/personas/`
- Add project-specific context to `CLAUDE.md`
- Extend commands by copying and modifying existing ones
