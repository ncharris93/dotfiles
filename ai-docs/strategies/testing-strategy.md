# Testing Strategy Reference

This document defines behavior-driven testing practices for AI agents and development teams to ensure consistent, effective testing across projects and technologies.

## Core Principles

### 1. Behavior-Driven Testing Philosophy

**Tests should describe product behavior, not implementation details.**

Tests serve as executable specifications that stakeholders can understand. Focus on user behavior and business outcomes rather than technical implementation.

### 2. User-Centric Test Descriptions

Test descriptions should read like functional requirements:

```typescript
// ✅ GOOD - Describes user behavior and product requirements
describe('When user clicks email confirmation link', () => {
  it('should redirect to onboarding address step')
  it('should allow access to onboarding but not account settings')
  it('should not redirect back to login page')
})

// ❌ POOR - Tests implementation details
describe('Email confirmation component', () => {
  it('should call mapToApiResponseWithAuthSync method')
  it('should update emailVerified property from auth user')
  it('should use useCurrentAuthUser hook')
})
```

### 3. Test-Driven Development (TDD)

Follow the Red-Green-Refactor cycle:

1. **Red**: Write failing tests that describe desired user behavior
2. **Green**: Implement minimal code to make tests pass
3. **Refactor**: Improve code while keeping tests green

Focus on testing the **what** (user outcomes) rather than the **how** (implementation details).

## Test Structure Standards

### Given-When-Then Format

Structure tests using the universal BDD format:

```typescript
describe('When user submits signup form', () => {
  describe('with valid information', () => {
    // Given: Initial state/context
    // When: User action
    // Then: Expected outcome
    it('should create user account')
    it('should send welcome email')
    it('should redirect to onboarding')
  })

  describe('with invalid email', () => {
    it('should show validation error')
    it('should keep user on signup form')
    it('should highlight email field')
  })
})
```

### Naming Conventions

1. **Start with user context**: "When user [action/situation]"
2. **Group by scenarios**: Use nested describe blocks for different contexts
3. **Describe outcomes**: "should [observable result]"
4. **Use specific language**: Avoid vague terms like "works", "handles"

### Organization Patterns

Structure tests by user scenarios, not code structure:

```typescript
// ✅ EXCELLENT - Organized by user context
describe('When user awaits email confirmation after signup', () => {
  describe('showing email confirmation page', () => {
    it('should display their email address when provided')
    it('should show helpful guidance when no specific email available')
    it('should focus resend button for keyboard users')
  })

  describe('when user needs email resent', () => {
    it('should allow resending confirmation email')
    it('should prevent spam by implementing progressive delays')
    it('should handle email delivery failures gracefully')
  })

  describe('accessibility for users with assistive technology', () => {
    it('should provide proper screen reader support')
    it('should maintain proper heading hierarchy')
  })
})

// ❌ POOR - Organized by code structure
describe('EmailConfirmationComponent', () => {
  describe('render method', () => {
    it('should render email input')
    it('should render submit button')
  })
})
```

## Behavior-Driven Patterns

### Context-Driven Organization

Structure tests around user scenarios:

```typescript
describe('When user requests password reset', () => {
  describe('with valid email address', () => {
    it('should send password reset email')
    it('should show confirmation message')
    it('should redirect to login page')
  })

  describe('with unregistered email', () => {
    it('should show helpful error message')
    it('should suggest account creation')
    it('should not reveal email registration status')
  })

  describe('with rate limiting in effect', () => {
    it('should show rate limit message')
    it('should indicate when user can retry')
    it('should maintain security without frustration')
  })
})
```

### Observable Outcomes Focus

Test what users experience, not internal mechanics:

```typescript
// ✅ GOOD - Tests observable outcomes
it('should show success message when payment completes')
it('should disable submit button during form submission')
it('should redirect to dashboard after successful login')

// ❌ POOR - Tests internal mechanics
it('should call setState with loading: true')
it('should invoke handlePaymentSuccess callback')
it('should update localStorage with auth token')
```

### Environment-Specific Behavior

Test different contexts and environments:

```typescript
describe('When user submits signup form', () => {
  describe('in production environment requiring email verification', () => {
    it('should guide user to email confirmation page')
    it(
      'should show success toast positioned to avoid password manager interference'
    )
  })

  describe('in development environment with immediate access', () => {
    it('should take user directly to onboarding')
    it('should show standard success notification')
  })
})
```

## Implementation Patterns

### Universal Test Structure

This pattern works across all testing frameworks and languages:

```typescript
describe('[User Context]', () => {
  describe('[Specific Scenario]', () => {
    beforeEach(() => {
      // Setup: Arrange test data and state
    })

    it('should [observable outcome]', () => {
      // Given: Initial state (often in beforeEach)
      // When: User action or system event
      // Then: Assert observable outcome
    })

    afterEach(() => {
      // Cleanup: Reset state if needed
    })
  })
})
```

### Test Data Factory Pattern

Use factory functions to eliminate duplication and improve test maintainability:

```typescript
// ✅ GOOD - Test-scoped factory with overrides
const createTestUser = (
  overrides: Partial<Parameters<typeof User.createNew>[0]> = {}
) => {
  const defaults = {
    id: 'user-id',
    email: 'user@example.com',
    phone: '+12345678901',
    name: 'Test User',
  }

  return User.createNew({ ...defaults, ...overrides })
}

// Usage - override only what matters for each test
const user = createTestUser() // Uses all defaults
const duplicateUser = createTestUser({ email: 'duplicate@example.com' })

// ❌ AVOID - Repetitive inline object creation
const user = User.createNew({
  id: 'user-id',
  email: 'user@example.com',
  phone: '+12345678901',
  name: 'Test User',
}) // Repeated dozens of times across test file
```

**Benefits**: Single source of truth, reduced duplication, highlights test intent through selective overrides.

### Common Testing Patterns

**Setup and Teardown:**

```typescript
describe('When user manages shopping cart', () => {
  let user: User
  let cart: ShoppingCart

  beforeEach(() => {
    user = createTestUser()
    cart = new ShoppingCart()
  })
})
```

**Assertion Patterns:**

```typescript
// Behavior verification
expect(response.status).toBe('success')
expect(user.notifications).toContain('Welcome email sent')
expect(page.url).toMatch('/onboarding/address')

// State verification
expect(form.isSubmitting).toBe(false)
expect(errorMessage.isVisible).toBe(true)
expect(submitButton.isDisabled).toBe(true)
```

**Mock and Stub Patterns:**

```typescript
describe('When external service is unavailable', () => {
  it('should show helpful error message to user', () => {
    // Mock external dependency
    jest
      .spyOn(emailService, 'send')
      .mockRejectedValue(new Error('Service unavailable'))

    // Test user-observable behavior
    // Verify graceful degradation
  })
})
```

### Avoiding Excessive Mocking (Red Flag)

**Excessive mocking is often a red flag indicating over-engineered or poorly designed tests.**

When tests require extensive mocking of internal dependencies, it usually signals:

- **Testing implementation details instead of behavior**
- **Overly complex or tightly coupled code**
- **Tests that will break when refactoring implementation**
- **Missing focus on user-observable outcomes**

**Guidelines for Appropriate Mocking:**

1. **Mock external boundaries only**: Network calls, file system, third-party APIs
2. **Preserve business logic**: Don't mock internal domain logic
3. **Focus on failure modes**: Mock external failures to test error handling
4. **Maintain behavior realism**: Mocked responses should reflect real service behavior

**When extensive mocking is needed, consider:**

- **Architectural refactoring**: Separate concerns to reduce coupling
- **Integration testing**: Test larger units with fewer mocks
- **Test-driven design**: Let test complexity guide better code structure

## Application Examples

### Web Applications

```typescript
describe('When user clicks "Save Draft" button', () => {
  it('should save form data to local storage')
  it('should show "Draft saved" confirmation')
  it('should keep user on current page')
  it('should preserve form state after page refresh')
})
```

### API Services

```typescript
describe('When client requests user profile', () => {
  describe('with valid authentication', () => {
    it('should return user profile data')
    it('should include privacy-filtered information')
    it('should respond within acceptable time limits')
  })

  describe('with invalid authentication', () => {
    it('should return 401 unauthorized')
    it('should include helpful error message')
    it('should not leak sensitive information')
  })
})
```

## Quality Guidelines

### FIRST Principles

Tests should be:

- **Fast**: Execute quickly to enable rapid feedback
- **Independent**: No dependencies between tests
- **Repeatable**: Consistent results in any environment
- **Self-validating**: Clear pass/fail without manual inspection
- **Timely**: Written just before or with production code

### Test Smells

**Common issues to avoid:**

- Implementation coupling: Tests break when refactoring
- Unclear descriptions: Vague or technical language
- Brittle tests: Sensitive to unrelated changes
- Long setup: Complex test data preparation
- Multiple assertions: Testing multiple behaviors

### Refactoring Example

```typescript
// ❌ BEFORE - Implementation coupled
describe('UserService', () => {
  it('should call database.save with user object', () => {
    // Tests implementation detail
  })
})

// ✅ AFTER - Behavior focused
describe('When user completes registration', () => {
  it('should create user account with provided information', () => {
    // Tests user-observable outcome
  })
})
```

## Common Pitfalls

### Avoid These Patterns

**Testing Implementation Details:**

```typescript
// ❌ AVOID - Testing internal mechanics
it('should call getUserById with correct parameters')
it('should update component state with fetched data')
it('should trigger useEffect on mount')

// ✅ PREFER - Testing user experience
it('should show user profile information')
it('should display loading spinner while fetching')
it('should show error message if user not found')
```

**Vague Test Descriptions:**

```typescript
// ❌ AVOID - Vague and uninformative
it('should work correctly')
it('should handle user input')
it('should manage state')

// ✅ PREFER - Specific and actionable
it('should save form data when user clicks submit')
it('should validate email format before submission')
it('should reset form after successful submission')
```

**Code Structure-Based Organization:**

```typescript
// ❌ AVOID - Organized by code structure
describe('UserService', () => {
  describe('createUser method', () => {
    it('should call database')
    it('should return user object')
  })
})

// ✅ PREFER - Organized by user scenarios
describe('When new user registers', () => {
  describe('with valid information', () => {
    it('should create user account')
    it('should send welcome email')
  })
})
```

### Best Practices

- **User-focused descriptions**: Always describe what users experience
- **Observable outcomes**: Test visible behavior, not internal state
- **Scenario organization**: Group by user contexts and situations
- **Accessibility considerations**: Include tests for keyboard users, screen readers
- **Edge case scenarios**: Describe edge cases as user situations
- **Stakeholder language**: Use terms that business users understand

## Quality Checklist

Before writing tests, ask:

- [ ] Would a product owner understand what this test verifies?
- [ ] Does the test describe user behavior or business outcomes?
- [ ] Can I refactor the implementation without breaking this test?
- [ ] Does the test failure message clearly indicate what user flow is broken?
- [ ] Are edge cases described as user scenarios?
- [ ] Does the test cover accessibility requirements?
- [ ] Is the test description specific and actionable?
- [ ] Does the test verify observable outcomes rather than internal state?

## Key References

- **Dan North** - Creator of Behavior-Driven Development (BDD)
- **Kent Beck** - Test-Driven Development pioneer
- **"Specification by Example" by Gojko Adzic** - Collaborative approach to building software
- **Given-When-Then Structure** - BDD scenario format
- **Red-Green-Refactor** - TDD development cycle

## Conclusion

Effective testing focuses on user behavior rather than implementation details. Write tests that serve as living documentation, organize by user scenarios, and use behavior-driven descriptions that stakeholders can understand.

**Key Takeaways:**

- Focus on user behavior, not implementation details
- Use Given-When-Then structure for clarity
- Organize tests by user scenarios, not code structure
- Write descriptions that stakeholders can understand
- Test observable outcomes, not internal mechanics

Adapt specific implementations to your framework needs while preserving these core principles.
