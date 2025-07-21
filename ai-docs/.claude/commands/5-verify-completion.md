# Verify Feature Completion

You are verifying that the implemented feature meets all requirements and is ready for release.

## Variables:

verification_focus: $ARGUMENTS

## Context Loading

```bash
# Load project context
source ./.project-context
# Provides: PROJECT_TYPE, REQUIREMENTS_PATH, EPIC_PATH
```

## Verification Process

### Phase 1: Requirements Traceability

1. **Load Documents**
   - Read requirements at $REQUIREMENTS_PATH
   - Read epic at $EPIC_PATH

2. **Create Traceability Matrix**
   ```markdown
   | Requirement | Story/Task | Implementation | Tests | Status |
   |-------------|------------|----------------|-------|--------|
   | User can X  | TASK-001   | module.js:45   | ✓ 3   | DONE   |
   | System validates Y | TASK-002 | api.js:78 | ✓ 5   | DONE   |
   | Performance < 2s | TASK-003 | [multiple] | ✓ 1   | DONE   |
   ```

3. **Identify Gaps**
   - Any requirements not implemented?
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

## Next Steps

```
Verification complete!

If PASSED: Create PR with git
If FAILED: /4-tdd-implementation [task-to-fix]
```

## Success Criteria

Verification is successful when:
- All requirements are implemented and tested
- All technical quality gates pass
- No critical issues remain
- Documentation is complete
- Feature is ready for production