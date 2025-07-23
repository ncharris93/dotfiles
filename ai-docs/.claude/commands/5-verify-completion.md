# Verify Feature Completion

You are verifying that the implemented feature meets all requirements and is ready for release.

## Variables:

target: $ARGUMENTS

ARGUMENTS PARSING: Parse from "$ARGUMENTS":
- target: Either a task_id (e.g., "task-1") for task verification, or feature_name for full feature verification

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

## Verification Process

### Phase 1: Requirements Traceability

1. **Determine Verification Scope**
   - If target is a task_id: Verify specific task implementation
   - If target is a feature_name: Verify all tasks in feature are complete
   
2. **Load Documents**
   - Read requirements at $REQUIREMENTS_PATH
   - Read epic at $EPIC_PATH
   - **Find the feature-spec.yml containing the target**:
     - Search `$DOCS_PATH/$EPIC_NAME/in-progress/` for the relevant feature file
     - If target is task_id, find which feature contains that task
     - If target is feature_name, load that feature's spec file

3. **Create Traceability Matrix**
   
   **For Task Verification:**
   ```markdown
   | Task Acceptance Criteria | Implementation | Tests | Status |
   |--------------------------|----------------|-------|--------|
   | User can login with email | auth.js:23 | ✓ 2 | DONE |
   | Error shown for invalid credentials | auth.js:45 | ✓ 1 | DONE |
   ```
   
   **For Feature Verification:**
   ```markdown
   | Task ID | Description | Implementation | Tests | Status |
   |---------|-------------|----------------|-------|--------|
   | task-1  | Login API   | auth.js:23     | ✓ 3   | DONE   |
   | task-2  | Login UI    | LoginForm.tsx  | ✓ 5   | DONE   |
   | task-3  | Validation  | validator.js   | ✓ 2   | DONE   |
   ```

4. **Identify Gaps**
   - Any task acceptance criteria not implemented?
   - Any acceptance criteria not tested?
   - Any scope creep detected?

### Phase 2: Technical Verification

Run comprehensive checks using discovered tools:

```bash
# 1. All Tests Pass
echo "Running full test suite..."
npm test # or discovered command

# 2. Test Coverage Meets Standards
echo "Checking test coverage..."
npm test -- --coverage
# Verify coverage meets project minimums (usually 80%+)

# 3. Code Quality Checks
echo "Running linting..."
npm run lint # or discovered command

echo "Running type checking..."
npm run type-check # or discovered command

# 4. Build Successfully
echo "Running build..."
npm run build # or discovered command

# 5. No Security Vulnerabilities
echo "Checking for vulnerabilities..."
npm audit # or security scan tool

# 6. Performance Benchmarks (if applicable)
echo "Running performance tests..."
# Run any performance test suites
```

### Phase 3: Integration Testing

Verify the feature works in context:

1. **API Integration** (if applicable)
   - Test all endpoints with real requests
   - Verify error handling
   - Check response formats

2. **UI Integration** (if applicable)
   - Manual testing of user flows
   - Cross-browser compatibility
   - Accessibility verification

3. **Data Flow**
   - End-to-end data flow testing
   - Database state verification
   - Event/message handling

### Phase 4: Documentation Review

Ensure all documentation is complete:

- [ ] API documentation updated
- [ ] README updated with new features
- [ ] CHANGELOG entry added
- [ ] Configuration docs updated
- [ ] Deployment notes added
- [ ] User guides updated (if applicable)

### Phase 5: Operational Readiness

Verify deployment and monitoring:

1. **Deployment Configuration**
   - Environment variables documented
   - Infrastructure requirements met
   - Migration scripts ready (if needed)

2. **Monitoring & Alerts**
   - Metrics being collected
   - Alerts configured
   - Dashboards updated

3. **Rollback Plan**
   - Rollback procedure documented
   - Feature flags configured (if used)
   - Database rollback scripts ready

### Phase 6: Final Review Checklist

Go through each item systematically:

**Code Quality**
- [ ] No TODO comments remain
- [ ] No console.log/print debug statements
- [ ] No hardcoded values that should be config
- [ ] Error messages are user-friendly
- [ ] Code follows project conventions

**Security**
- [ ] No secrets in code
- [ ] Input validation implemented
- [ ] Authentication/authorization correct
- [ ] OWASP top 10 considered

**Performance**
- [ ] Queries optimized
- [ ] Caching implemented where needed
- [ ] Bundle size acceptable
- [ ] Load time within requirements

**Testing**
- [ ] Unit tests comprehensive
- [ ] Integration tests cover workflows
- [ ] Edge cases tested
- [ ] Error scenarios tested

**User Experience**
- [ ] UI responsive on all devices
- [ ] Accessibility standards met
- [ ] Loading states implemented
- [ ] Error states user-friendly


## Verification Report

Generate a comprehensive report:

```markdown
# Feature Verification Report

**Feature**: [Name]
**Date**: [Current Date]
**Verified By**: Claude Code

## Executive Summary
[2-3 sentences on completion status]

## Requirements Coverage
- Total Requirements: X
- Implemented: X (100%)
- Test Coverage: X%

## Technical Health
- Build: ✅ PASSING
- Tests: ✅ X tests passing
- Lint: ✅ No issues
- Security: ✅ No vulnerabilities
- Performance: ✅ Meets benchmarks

## Findings
### Completed Successfully
- [List of what works well]

### Minor Issues (non-blocking)
- [Any minor issues found]

### Recommendations
- [Suggestions for improvement]

## Ready for Release
- [ ] All requirements implemented
- [ ] All tests passing
- [ ] Code quality verified
- [ ] No security issues
- [ ] Documentation complete

## Next Steps
1. [Immediate next action]
2. [Follow-up items]
```

## Output Summary

Provide the user with:
- Overall verification status (PASS/FAIL)
- Requirements coverage percentage
- Test coverage percentage
- Any blocking issues found
- Recommendations for resolution
- Whether feature is ready for release

## Completion Actions

**If Task Verification PASSED:**
1. **Confirm task status is marked as 'completed' in feature-spec.yml**
2. **Display task completion summary**
3. **Show remaining tasks in this feature**

**If Feature Verification PASSED (all tasks completed):**
1. **Verify all tasks in feature have status 'completed'**
2. **Move feature-spec.yml from `$DOCS_PATH/$EPIC_NAME/in-progress/` to `$DOCS_PATH/$EPIC_NAME/done/`**
3. **Update feature metadata with completion date**
4. **Display epic status overview showing completed feature**

## Next Steps

```
Verification complete!

If TASK verification PASSED: 
- Continue with next task: /4-tdd-implementation [next-task-id]
- Or verify whole feature: /5-verify-completion [feature-name]

If FEATURE verification PASSED: 
- Feature moved to done/ - Continue with next feature or create PR

If FAILED: 
- Fix task issues: /4-tdd-implementation [task-id]
- Re-run verification after fixes
```

## Success Criteria

Verification is successful when:
- All requirements are implemented and tested
- All technical quality gates pass
- No critical issues remain
- Documentation is complete
- Feature is ready for production