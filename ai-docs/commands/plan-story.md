# Multi-Persona Feature Planning Orchestration

Think deeply about this story execution task. You are about to embark on a sophisticated iterative creation process.

## Variables:

feature_story_path: $ARGUMENTS
meta_information: $ARGUMENTS

ARGUMENTS PARSING: Parse the following arguments from "$ARGUMENTS":

feature_story_path - path to the markdown specification file for the feature story we're going to plan
meta_information - extra details about the plan to be taken into consideration before starting to plan

## Orchestration Instructions

You are the **Lead Orchestrator** managing a team of specialized engineering
personas to collaboratively plan this feature implementation. Your goal is to
produce a comprehensive `[[feature-name]]-spec.yml` file following the template
structure found in `project-management/feature-spec.yml`

The `[[feature-name]]-spec.yml` file should be placed in the appropriate
/project-management subfolder when completed

If any of the personas have questions that should be taken to a stakeholder
about any ambiguity, the orchestrator agent should ask any group question(s) and
wait for an answer before continuing with the discussion.

Ensure that if any 3rd party libraries are being used that you leverage the
Context7 MCP server to look up the documentation for the version of packages
listed in the relevant bill of materials file (package.json, for example)

### Phase 1: Concurrent Domain Analysis (Spawn 6 agents in parallel)

Create parallel sub-agents for each Persona found in /ai-docs/personas. Instruct
the personas to read relevant code and give their input on how to go about the
implementation based on what's important to them. The team lead persona should
have the final say in tasks to be undertaken, which is then prioritized by the
product-owner. You will orchestrate and facilitate this conversation, allowing
the personas to communicate with one another. It's important to remember to
current architecture goals between DDD and 12-factor apps. More details in
`ai-docs/context/architecture.md`

### Phase 2: Synthesis and Integration

After collecting all agent contributions:

1. **Merge all sections** into a unified feature-spec.yml
2. **Identify conflicts** between proposed solutions and resolve
   them
3. **Define task dependencies** and critical path
4. **Create architecture overview** that integrates all domain
   concerns
5. **Establish deployment phases** balancing risk and business
   needs
6. **Set clear ownership** for each implementation task

### Phase 3: Final Deliverable

Generate a complete `[[feature-name]]-spec.yml` file that includes:

- **Complete analysis** from all 6 domain perspectives
- **Unified implementation plan** with specific, actionable tasks
- **Clear ownership mapping** for each task
- **Deployment strategy** with phases and rollback plans
- **Success criteria** that satisfy all stakeholders
- **Risk mitigation** addressing concerns from all domains

an example outline of this file can be found in /project-management/feature-spec.yaml

### Output Format

Return the final `[[feature-name]]-spec.yml` content that I can use as a
specification for implementation. The orchestrator (you) will
then code the implementation based on this comprehensive spec.

### Success Criteria for This Planning Phase

- All 6 personas have contributed their domain expertise
- No major conflicts exist between proposed solutions
- Implementation tasks have clear acceptance criteria
- Deployment plan addresses security, quality, and business
  concerns
- Success metrics are measurable and comprehensive
