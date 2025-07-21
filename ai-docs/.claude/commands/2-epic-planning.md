# Multi-Persona Epic Planning Meeting

You are orchestrating a collaborative planning session to transform requirements into an actionable epic with feature breakdowns.

## Variables:

additional_context: $ARGUMENTS

## Context Loading

```bash
# Load project context from previous step
source ./.project-context
# This provides: PROJECT_TYPE, REQUIREMENTS_PATH, DOCS_PATH
```

## Pre-Meeting Setup

1. **Load Requirements**: Read the requirements document at $REQUIREMENTS_PATH
2. **Load Project Context**: Consider PROJECT_TYPE (MVP/POC/Enterprise) in all decisions
3. **Prepare Context**: Load relevant project context from CLAUDE.md and ai-docs/

## Meeting Orchestration

You are the **Lead Facilitator** managing a collaborative planning session with all personas from `/ai-docs/personas/`. 

**Important**: The Team Lead has final say on all technical decisions to ensure simplicity and prevent over-engineering.

Your goal is to produce a single epic document: `$DOCS_PATH/epics/[epic-name].md`

### Phase 1: Requirements Review & Clarification (All Personas)

Spawn parallel sub-agents for initial requirements analysis:

**Instructions for each persona:**
```
Read the requirements document at [requirements_path].
From your domain perspective, identify:
1. Key concerns or risks
2. Implementation considerations  
3. Questions that need clarification
4. Dependencies or prerequisites
5. Success criteria from your viewpoint
```

**Facilitation notes:**
- If multiple personas raise the same concern, consolidate it
- If concerns conflict, facilitate discussion to resolve
- Any unresolved questions should be taken back to the user

### Phase 2: Epic Breakdown Discussion

Lead a structured discussion where personas collaborate to:

1. **Define the Epic Scope** (Product Owner leads)
   - What is the overarching goal?
   - How does this map to business value?
   - What are the key milestones?

2. **Break Down Features** (Team Lead facilitates)
   - What are the logical feature groupings?
   - What is the minimal viable first iteration?
   - How do features depend on each other?

3. **Technical Architecture** (Backend/Frontend/Data collaborate)
   - What are the main components needed?
   - How will data flow through the system?
   - What are the integration points?

4. **Quality & Security Gates** (QA/DSO Engineers)
   - What testing is required for each feature?
   - What security reviews are needed?
   - How do we ensure compliance?

### Phase 3: Prioritization & Sequencing

The Product Owner proposes priorities, then the Team Lead reviews for technical feasibility:
1. Prioritize features by value and dependency
2. Define release phases (considering PROJECT_TYPE)
3. Identify the critical path
4. Team Lead has final say on technical approach

### Phase 4: Generate Artifacts

Create the epic document with this structure:

```markdown
# [Epic Name]

**Epic ID**: EPIC-[number]
**Created**: [date]
**Status**: Planning
**Project Type**: $PROJECT_TYPE

## Overview

[2-3 paragraph description from requirements executive summary]

## Business Value

[Product Owner's articulation of why this matters]

## Success Metrics

[Measurable outcomes from requirements]

## Feature Breakdown

### Feature 1: [Name]
**Priority**: P0
**Story Points**: [Estimate]

**Description**: [What this feature does]

**User Stories**:
- As a [user], I want to [action] so that [benefit]

**Acceptance Criteria**:
- [ ] [User-facing behavior]
- [ ] [Technical requirement]

**Technical Approach**: [High-level approach]

**Dependencies**: [Other features or systems]

### Feature 2: [Name]
[Same structure...]

## Technical Approach

[High-level architecture summary from technical personas]

## Risks & Mitigations

| Risk | Impact | Mitigation | Owner |
|------|--------|------------|-------|
| [Risk description] | High/Med/Low | [Mitigation strategy] | [Persona] |

## Timeline & Phases

### Phase 1: [Name] (Target: [Date])
- Feature 1
- Feature 3 (partial)

### Phase 2: [Name] (Target: [Date])
- Feature 2
- Feature 3 (completion)

## Open Questions

- [Any unresolved questions from the meeting]
```


### Phase 5: Review & Confirmation

1. Have the Team Lead review the technical coherence
2. Have the Product Owner confirm business alignment  
3. Have QA confirm testability
4. Have Security confirm compliance approach

Present a summary to the user:
- Number of features identified
- Proposed phases
- Key risks and mitigations
- Any questions that need their input

## Success Criteria

- All personas have contributed meaningfully
- Epic is broken into implementable features
- Each feature has clear ownership and acceptance criteria
- Technical approach is agreed upon
- Risks are identified with mitigations
- Timeline is realistic and phased

## Next Steps

Save context and provide next command:
```bash
echo "EPIC_PATH=$EPIC_PATH" >> ./.project-context
```

Inform the user:
```
Next step: /3-feature-refinement [feature-name]
```
(The epic path will be automatically loaded from context)