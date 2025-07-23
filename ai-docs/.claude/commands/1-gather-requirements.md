# Gather and Understand Requirements

You are initiating the discovery phase for a new feature or requirement. Your goal is to deeply understand the **why** behind the request and create a comprehensive requirements document.

## Variables:

initial_request: $ARGUMENTS

## Context Persistence

Store project-wide and epic-specific context for use in subsequent commands:

**Root context (project-wide meta documents):**
```bash
echo "META_DOCS=[comma-separated-list-of-meta-doc-paths]" > ./.project-context
```

**Epic-specific context:**
```bash
echo "PROJECT_TYPE=$PROJECT_TYPE" > "$DOCS_PATH/[epic-name]/.project-context"
echo "DOCS_PATH=$DOCS_PATH" >> "$DOCS_PATH/[epic-name]/.project-context"
echo "EPIC_NAME=[epic-name]" >> "$DOCS_PATH/[epic-name]/.project-context"
echo "REQUIREMENTS_PATH=$DOCS_PATH/[epic-name]/requirements.md" >> "$DOCS_PATH/[epic-name]/.project-context"
echo "EPIC_PATH=$DOCS_PATH/[epic-name]/epic.md" >> "$DOCS_PATH/[epic-name]/.project-context"
```

## Phase 1: Initial Understanding

First, determine the project type and meta documentation:
- "Is this an MVP, POC, enterprise feature, or something else?"
- "What are the primary constraints (time, resources, quality)?"
- "What meta documents should inform this project's planning and implementation? (e.g., architecture docs, coding standards, testing strategies, etc.)"

Then engage in collaborative dialogue to understand:

1. **The Problem Space**
   - What specific problem are we solving?
   - Who experiences this problem? How often?
   - What is the current workaround or pain point?
   - What is the cost of NOT solving this problem?

2. **User Personas & Journeys**
   - Who are the primary users?
   - What are their goals and motivations?
   - What is their current journey?
   - How would this feature change their experience?

3. **Success Criteria**
   - How will we know this is successful?
   - What metrics matter?
   - What does "done" look like from the user's perspective?
   - Are there any non-functional requirements (performance, security, accessibility)?

4. **Scope & Constraints**
   - What is explicitly IN scope?
   - What is explicitly OUT of scope?
   - Are there technical, time, or resource constraints?
   - Are there dependencies on other systems or features?

## Phase 2: Validation Questions

Ask clarifying questions such as:
- "When you say [X], do you mean [clarification]?"
- "Have you considered [edge case]? How should that work?"
- "Is this similar to [existing feature]? How is it different?"
- "What happens if [failure scenario]?"

## Phase 3: Document Creation

Once you have sufficient clarity, create a requirements document.

Determine storage location and create project structure:
```bash
if [ -d "./project-management" ]; then
    DOCS_PATH="./project-management"
else
    echo "Where would you like to store project artifacts? (default: ./project-management)"
    # Wait for user input or use default
fi

REQUIREMENTS_PATH="$DOCS_PATH/[epic-name]/requirements.md"
```

**Create the epic-specific project structure:**
```
/project-management/[epic-name]/
├── .project-context
├── requirements.md
├── planned/
├── in-progress/
└── done/
```

The `.project-context` file should contain epic-specific context that will be used throughout the feature development lifecycle.

### Requirements Document Template:

```markdown
# [Feature Name] Requirements

**Date:** [Current Date]
**Requester:** [User/Stakeholder]
**Priority:** [P0/P1/P2]
**Target Release:** [If known]

## Executive Summary

[2-3 sentence summary of the feature and its business value]

## Problem Statement

### Current State
[Description of how things work today]

### Pain Points
- [Specific problem 1]
- [Specific problem 2]

### Desired State
[Vision of how things should work]

## User Personas

### Primary Users
- **[Persona Name]**: [Description, goals, needs]

### Secondary Users
- **[Persona Name]**: [Description, impact]

## Functional Requirements

### Core Features
1. **[Feature 1]**: [Description]
   - Acceptance: [How we verify this works]
   
2. **[Feature 2]**: [Description]
   - Acceptance: [How we verify this works]

### User Stories
- As a [user type], I want to [action] so that [benefit]
- As a [user type], I want to [action] so that [benefit]

## Non-Functional Requirements

### Performance
- [Latency requirements]
- [Throughput requirements]

### Security
- [Authentication/Authorization needs]
- [Data protection requirements]

### Accessibility
- [WCAG compliance level]
- [Specific accessibility needs]

## Success Metrics

### Quantitative
- [Metric 1]: [Current] → [Target]
- [Metric 2]: [Current] → [Target]

### Qualitative
- [User satisfaction measure]
- [Adoption criteria]

## Constraints & Dependencies

### Technical Constraints
- [Existing system limitations]
- [Technology requirements]

### Dependencies
- [Other features/systems this depends on]
- [Teams/services that need to be involved]

## Scope Definition

### In Scope
- [Explicitly included feature/behavior]

### Out of Scope
- [Explicitly excluded feature/behavior]

### Future Considerations
- [Things to consider for phase 2]

## Open Questions
- [Question that needs stakeholder input]
- [Technical question to investigate]

## Next Steps
1. Review with stakeholders
2. Create epic using `2-epic-planning` command
3. Technical feasibility assessment
```

## Phase 4: Confirmation

After creating the document:
1. Summarize the key requirements back to the user
2. Ask: "Does this accurately capture your requirements? What would you like to adjust?"
3. Make any necessary revisions
4. Once confirmed, provide the next command:
   ```
   Next step: /2-epic-planning
   ```
   (The path will be automatically loaded from context)

## Success Criteria for This Phase

- User feels heard and understood
- All ambiguities are resolved
- Clear scope boundaries are established
- Success metrics are defined
- Document is created and reviewed