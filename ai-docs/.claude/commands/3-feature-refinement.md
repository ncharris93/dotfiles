# Technical Feature Refinement Session

You are facilitating a detailed technical refinement session for a specific feature from an epic. The engineering team will dive deep into implementation details.

## Variables:

feature_name: $ARGUMENTS
refinement_context: $ARGUMENTS

ARGUMENTS PARSING: Parse from "$ARGUMENTS":
- feature_name: Which feature to refine (name from epic)
- refinement_context: Any specific concerns to address (optional)

## Context Loading

```bash
# Load project context (meta documents)
source ./.project-context
# This provides: META_DOCS

# Load epic-specific context
source "$DOCS_PATH/[epic-name]/.project-context"
# This provides: PROJECT_TYPE, DOCS_PATH, EPIC_NAME, REQUIREMENTS_PATH, EPIC_PATH
```

**Load context from the following files before beginning:**
(Read all files listed in $META_DOCS for comprehensive project context)

## Pre-Refinement Setup

1. **Load Context**:
   - Read the epic document at $EPIC_PATH
   - Read requirements at $REQUIREMENTS_PATH
   - Identify the specific feature to refine from the epic
   - Check for any existing technical documentation

2. **Identify Technical Participants**:
   Based on the feature, determine which personas are critical:
   - Always include: Team Lead, QA Engineer
   - Feature-specific: Frontend, Backend, Data, DSO as needed

## Refinement Orchestration

### Phase 1: Feature Deep Dive

Have each relevant persona analyze the feature in detail:

**For Backend Engineer:**
```
Examine this feature and determine:
1. API endpoints needed (REST/GraphQL/gRPC)
2. Data models and database changes
3. Service layer architecture
4. External service integrations
5. Performance considerations
6. Caching strategy
```

**For Frontend Engineer:**
```
Analyze the UI/UX requirements:
1. Component architecture needed
2. State management approach
3. Data fetching patterns
4. User interaction flows
5. Accessibility requirements
6. Responsive design needs
```

**For Data Engineer:**
```
Consider data implications:
1. Data sources and pipelines
2. Storage requirements
3. Analytics and metrics needed
4. Data retention policies
5. Real-time vs batch processing
6. Data quality checks
```

**For QA Engineer:**
```
Plan testing approach:
1. Test scenarios and edge cases
2. Test data requirements
3. Automation strategy
4. Performance benchmarks
5. Regression test impacts
6. Accessibility testing needs
```

**For DSO Engineer:**
```
Assess operational needs:
1. Security controls required
2. Monitoring and alerting
3. Deployment strategy
4. Rollback procedures
5. Compliance checkpoints
6. Infrastructure requirements
```

### Phase 2: Technical Design Discussion

Facilitate a structured discussion to:

1. **API Contract Definition** (if applicable)
   ```yaml
   endpoint: /api/v1/[resource]
   method: POST
   request:
     schema: {}
   response:
     schema: {}
   errors: []
   ```

2. **Data Flow Mapping**
   - User action → Frontend → API → Backend → Database
   - Include all integration points

3. **Component Breakdown**
   - List every component/module to be created or modified
   - Define interfaces between components

4. **Technical Decisions**
   - Framework/library choices (check package.json first!)
   - Design patterns to apply
   - Performance optimizations

### Phase 3: Story Refinement

Break the feature into implementable stories:

1. **Vertical Slices** (preferred)
   - Each story delivers user value
   - Can be tested end-to-end
   - Independent deployment possible

2. **Technical Tasks** (if needed)
   - Infrastructure setup
   - Technical debt that blocks feature
   - Tooling or framework updates

For each story, define:
```yaml
story:
  title: "As a [user], I can [action]"
  technical_details:
    backend_work:
      - Task with acceptance criteria
    frontend_work:
      - Task with acceptance criteria
    data_work:
      - Task with acceptance criteria
  testing_approach:
    unit_tests: []
    integration_tests: []
    e2e_tests: []
  definition_of_done:
    - Code reviewed and approved
    - Tests passing (specify coverage)
    - Documentation updated
    - Monitoring in place
```

### Phase 4: Update Feature Spec

Create or update the feature-spec.yml file in the epic's `planned/` folder with refined details.

**File location**: `$DOCS_PATH/$EPIC_NAME/planned/[feature-name]-spec.yml`

```yaml
implementation:
  detailed_tasks:
    - id: '[feature-id]-task-1'
      owner: '[persona/team]'
      description: '[specific technical task]'
      acceptance_criteria:
        - '[Technical implementation detail]'
        - '[Test coverage requirement]'
      dependencies: ['[other-task-id]']
      code_spec: |
        Detailed implementation approach:
        1. [Step-by-step technical approach]
        2. [Key functions/components to create]
        3. [Integration points]
      estimated_hours: [number]
      
    - id: '[feature-id]-task-2'
      [continue pattern...]

  technical_decisions:
    - decision: '[What was decided]'
      rationale: '[Why this approach]'
      alternatives_considered: ['[option1]', '[option2]']
      
  api_contracts:
    - [Detailed API specifications]
    
  data_models:
    - [Schema changes needed]
    
  test_strategy:
    unit_test_targets:
      - '[Component/function to test]'
    integration_test_scenarios:
      - '[Scenario description]'
    e2e_test_cases:
      - '[User journey to test]'
```

### Phase 5: Identify Risks & Dependencies

Have the Team Lead consolidate:

1. **Technical Risks**
   - Performance bottlenecks
   - Scalability concerns
   - Technical debt introduced
   - Integration complexities

2. **Dependencies**
   - On other features
   - On external teams
   - On third-party services
   - On infrastructure changes

3. **Blockers**
   - What needs to be resolved before starting?
   - Who needs to be involved?

### Phase 6: Review & Estimation

1. **Story Point Estimation**
   - Each story gets points (complexity, not time)
   - Adjust for PROJECT_TYPE (MVP = prefer simpler)
   - Team consensus with Team Lead final say

2. **Capacity Check**
   - Can this fit in the planned sprint/phase?
   - Any resource constraints?

3. **Final Review**
   - Team Lead: Technical coherence
   - Product Owner: Alignment with requirements
   - QA: Testability confirmed
   - DSO: Operational readiness

## Output Summary

Present to the user:
- Number of stories created from the feature
- Total story points estimated
- Key technical decisions made
- Risks identified
- Dependencies that need coordination
- Updated feature-spec.yml location

## Next Steps

Inform the user:
- Continue with next feature: `/3-feature-refinement [next-feature-name]`
- Or proceed to implement first task: `/4-tdd-implementation [first-task-id]`
- Review and adjust the refined spec if needed

**Task IDs created**: List the task IDs that were created for easy reference

## Success Criteria

- Feature is broken into implementable stories
- Each story has clear technical approach
- All technical decisions are documented
- Test strategy is comprehensive
- Team has consensus on approach
- Epic document is updated with technical details