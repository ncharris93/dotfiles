# Create User Story

You are initiating the first phase of a new feature's lifecycle: defining the **user story**.

This command generates a clear, concise, and user-centered story artifact suitable for Agile workflows. It reflects the **user’s perspective** — their goals, motivations, and interactions — not the technical implementation.

This story will later be handed off to the engineering team using `plan-story`.

## Variables:

epic: $EPIC  
story_context: $ARGUMENTS

ARGUMENTS PARSING:

- `epic`: The name or ID of the existing epic this story supports
- `story_context`: A high-level statement of the desired user-facing behavior or outcome (e.g. "users want to get SMS reminders for upcoming events")

---

## Step 1: Clarify the User Perspective

Before generating the story, ensure the following are well-understood:

- Who is the user or persona?
- What are they trying to accomplish?
- Why does it matter to them?
- What is the trigger or context for this behavior?
- How will success be observed from the user's point of view?

**If anything is unclear**, pause and ask the user directly. Do not assume.

---

## Step 2: Generate the User Story Artifact

Once there is enough clarity, generate a markdown file with the following format.
It should go in the correct folder under `/project-management/$EPIC/user-story-[user-story-slug]`

```md
# [User Story Title]

**Epic:** [epic-name]  
**User Persona:** [persona or role]  
**Status:** Proposed  
**Story Points:** TBD

## As a [type of user], I want to [do something], so that [benefit or outcome].

## Acceptance Criteria

- [ ] [Observable user-facing behavior or requirement]
- [ ] [Edge cases or alternate flows, if any]
- [ ] [Success conditions from user perspective]

## Context / Notes

[Optional: any relevant background or linked research]

## ADR Impact

[Yes/No] – If Yes, explain why this story _might_ require creating or updating an Architecture Decision Record, to be handled in the `plan-story` phase
```
