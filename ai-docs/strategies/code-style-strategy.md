# Code Style Strategy Reference

This document outlines the comprehensive code style strategy for maintaining readable, maintainable, and consistent codebases. It serves as a reference for AI agents and development teams to ensure stylistic choices enhance code quality and developer experience.

## Core Principles

### 1. **Readability First**

Code should read like well-structured prose, with clear intent and minimal cognitive load. Every stylistic choice should prioritize human comprehension over cleverness or brevity.

### 2. **Consistency Over Preference**

Consistent patterns across the codebase reduce mental overhead and enable faster navigation. When multiple valid approaches exist, choose the one that aligns with existing patterns.

### 3. **Early Returns and Reduced Nesting**

Minimize nesting depth by using early returns and guard clauses. This creates clearer main logic paths and reduces cognitive complexity.

### 4. **Explicit Over Implicit**

Favor explicit type annotations, clear variable names, and obvious control flow over implicit behaviors that require deep contextual knowledge.

### 5. **Function Clarity and Simplicity**

Functions should have clear, single responsibilities with intuitive parameter patterns that minimize cognitive load.

### 6. **Single Responsibility Principle**

Each function should focus on doing one thing well. This improves testability, readability, and maintainability by making the function's purpose immediately clear.

### 7. **Progressive Enhancement**

Style choices should scale from simple cases to complex ones without breaking existing patterns or requiring significant refactoring.

## Function Design Essentials

### Single Responsibility and Parameter Management

**Core Rules:**

- Functions should do one thing and do it well
- Functions should have fewer than 3 arguments

```typescript
// ✅ GOOD - Single responsibility with <3 arguments
function validateUserEmail(email: string): ValidationResult {
  if (!email) return { isValid: false, error: 'Email is required' }
  if (!email.includes('@')) return { isValid: false, error: 'Email must contain @' }
  return { isValid: true }
}

// ✅ GOOD - Object parameter for 3+ related values
function updateProfile(params: {
  userId: string
  name: string
  email: string
  phone: string
}) {
  // Implementation
}

// ✅ GOOD - Main argument + options pattern
function logger.info(message: string, options: {
  meta?: Record<string, unknown>
  context?: RequestContext
}) {
  // Implementation
}

// ❌ AVOID - Multiple responsibilities + too many parameters
function createUserAndSendEmail(id: string, name: string, email: string, phone: string) {
  // Validation, creation, email sending, logging all mixed together
}
```

### Early Returns and Control Flow

Structure functions to handle edge cases first, leaving main logic clear:

```typescript
// ✅ GOOD - Early returns with single responsibility
function processUserData(user: User): ProcessedData {
  if (!user) return createEmptyData()
  if (!user.isActive) return createInactiveData(user)
  if (user.isNewUser) return processNewUser(user)

  // Main logic path is clear and unindented
  return processExistingUser(user)
}

// ❌ AVOID - Nested conditions
function processUserData(user: User): ProcessedData {
  if (user) {
    if (user.isActive) {
      if (!user.isNewUser) {
        return processExistingUser(user)
      }
    }
  }
}
```

### Independent If Statements Over Else-If Chains

When returning values, prefer independent `if` statements over `else if` chains for better readability and maintainability:

```typescript
// ✅ GOOD - Independent if statements with returns
function getUserStatus(user: User): string {
  if (!user.emailVerified) return 'pending-verification'
  if (!user.onboardingCompleted) return 'onboarding-required'
  if (user.isSuspended) return 'suspended'
  if (user.isTrialExpired) return 'trial-expired'

  return 'active'
}

// ✅ GOOD - Each condition is independent and clear
function calculateDiscount(user: User): number {
  if (user.isPremium) return 0.2
  if (user.isStudent) return 0.15
  if (user.isFirstTime) return 0.1

  return 0
}

// ❌ AVOID - Else-if chains when returning
function getUserStatus(user: User): string {
  if (!user.emailVerified) {
    return 'pending-verification'
  } else if (!user.onboardingCompleted) {
    return 'onboarding-required'
  } else if (user.isSuspended) {
    return 'suspended'
  } else if (user.isTrialExpired) {
    return 'trial-expired'
  } else {
    return 'active'
  }
}
```

**Benefits of this approach:**

- Each condition is visually independent and easy to scan
- Easier to reorder, add, or remove conditions
- Reduces indentation and improves readability
- Makes the "default" case explicit with a final `return`
- Eliminates the need for `else` when each branch returns

## Type Safety & Configuration

### Explicit Types and Union Types

```typescript
// ✅ GOOD - Explicit types for public APIs
function updatePreferences(
  userId: string,
  preferences: Partial<UserPreferences>
): Promise<void> {
  // Clear type contracts
}

// ✅ GOOD - Union types for controlled state
type LoadingState =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: UserData }
  | { status: 'error'; error: string }

// ❌ AVOID - any types
function processData(data: any): any {
  // Loses type safety
}
```

### Centralized Configuration

Never access environment variables directly:

```typescript
// ❌ INCORRECT - Direct environment variable access
const nodeEnv = process.env.NODE_ENV
const publicUrl = process.env.VITE_PUBLIC_URL

// ✅ CORRECT - Use centralized configuration
import { getConfig, isDevelopment } from '~/lib/config'
const config = getConfig()
const nodeEnv = config.nodeEnv
const publicUrl = config.publicUrl
```

### Path Aliases and Import Organization

**Always check tsconfig.json for existing path aliases before creating imports.**

Reading the TypeScript configuration first ensures consistent import patterns and prevents unnecessary relative path complexity:

```typescript
// First, check tsconfig.json to understand the project's path mapping:
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@forescore/shared": ["../shared/types/index.ts"],
      "~/*": ["./src/*"]
    }
  }
}

// ✅ CORRECT - Use configured path aliases
import { UserEntity } from '~/domains/user/entities/User'
import { logger } from '~/lib/logger'
import { getConfig } from '~/lib/config'
import type { ConsentRequest } from '@forescore/shared'

// ❌ INCORRECT - Relative paths when aliases exist
import { UserEntity } from '../../../domains/user/entities/User'
import { logger } from '../../lib/logger'
import { getConfig } from '../../lib/config'
```

**Benefits of using path aliases:**

- **Consistent imports**: Same import path regardless of file location
- **Refactoring safety**: Moving files doesn't break import paths
- **Clear module boundaries**: Aliases indicate architectural layers
- **Reduced cognitive load**: No need to calculate relative path depths

**Path alias best practices:**

1. **Read tsconfig.json first**: Always check existing path configuration
2. **Use semantic prefixes** if tsconfig has aliases, use them when appropriate
3. **Avoid deep relative paths**: Use aliases for imports >2 levels deep
4. **Group imports logically**: External deps, path aliases, then relative imports

**When creating new modules:**

1. Check if tsconfig.json defines relevant path aliases
2. Use existing aliases consistently across the codebase
3. Consider proposing new aliases for frequently imported paths
4. Maintain the established import grouping patterns

## Naming & Error Handling

### Self-Documenting Names

```typescript
// ✅ GOOD - Clear, descriptive names
const unprocessedOrders = orders.filter(order => !order.isProcessed)
function calculateMonthlyRecurringRevenue(
  subscriptions: Subscription[]
): number {}
function sendWelcomeEmailToNewUser(user: User): Promise<void> {}

// ❌ AVOID - Unclear abbreviations
const items = orders.filter(o => !o.proc)
function calcMRR(subs: Subscription[]): number {}
function send(user: User): Promise<void> {}
```

### Specific Error Types

```typescript
// ✅ GOOD - Specific error classes
class UserNotFoundError extends Error {
  constructor(userId: string) {
    super(`User with ID ${userId} not found`)
    this.name = 'UserNotFoundError'
  }
}

// ✅ GOOD - Result pattern for expected failures
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E }

async function parseUserData(
  input: string
): Promise<Result<UserData, ValidationError>> {
  try {
    const validatedData = userDataSchema.parse(JSON.parse(input))
    return { success: true, data: validatedData }
  } catch (error) {
    return {
      success: false,
      error: new ValidationError('Invalid format', error),
    }
  }
}
```

## Quality Standards

### Code Review Checklist

- ✅ Function parameters follow <3 argument rule
- ✅ Early returns used to reduce nesting
- ✅ Variable names clearly express intent
- ✅ Type annotations present for public interfaces
- ✅ Error handling appropriate for failure scenarios
- ✅ No direct environment variable access
- ✅ Each function has single, clear responsibility
- ✅ Functions are easily testable in isolation

### Maintainability Metrics

- **Cyclomatic complexity**: <10 per function
- **Nesting depth**: Maximum 3 levels
- **Function length**: <50 lines preferred
- **Type coverage**: 100% for public APIs
- **Single responsibility**: One clear purpose per function

## Magic Strings vs Constants

### Decision Criteria

**Use Constants When:**

- **Cross-service values**: Used across API, database, business logic layers
- **Business domain concepts**: Core domain values that may evolve over time
- **External contracts**: Must match external APIs, database schemas, third-party systems

**Use Magic Strings When:**

- **UI-only component props**: Values with TypeScript type safety
- **Single-use labels**: Display text used in one location
- **Self-documenting values**: Clear, obvious strings like `'primary'`, `'large'`, `'disabled'`

### Examples

```typescript
// ✅ GOOD - Business domain constants (cross-service usage)
const consents = [{
  type: CONSENT_TYPES.CALL_CONSENT,        // Business rules + shared contract
  metadata: {
    subtype: CONSENT_SUBTYPES.RECORDING_CONSENT,  // Domain differentiation
    recording_type: RECORDING_TYPES.STREAMING     // Business behavior
  }
}]

// ✅ GOOD - UI magic strings (TypeScript enforced)
<FormButton
  variant="secondary"  // TypeScript prevents typos
  size="small"        // Self-documenting
>

// ❌ AVOID - Over-engineered UI constants
<FormButton
  variant={FORM_BUTTON_VARIANTS.SECONDARY}  // Unnecessary ceremony
  size={FORM_BUTTON_SIZES.SMALL}           // No architectural benefit
>
```

**Key Principle**: Constants should solve architectural problems (type safety gaps, cross-service consistency, business domain modeling), not create ceremony for values where TypeScript already provides safety.

## Conclusion

Code style should reduce cognitive load rather than showcase clever techniques. Every choice should make code easier to understand, debug, and modify. Functions that do one thing well are the foundation of maintainable systems. These guidelines should be adapted to specific contexts while maintaining the core principles of clarity, consistency, and focused responsibility.
