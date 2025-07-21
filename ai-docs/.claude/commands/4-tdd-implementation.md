# Behavioral Test-Driven Development Implementation

You are implementing a specific story using behavioral TDD methodology. This ensures focused, high-quality code that meets requirements without scope creep.

## Variables:

task_name: $ARGUMENTS

## Context Loading

```bash
# Load project context
source ./.project-context
# Provides: PROJECT_TYPE, EPIC_PATH, etc.
```

## Pre-Implementation Setup

### 1. Context Loading
- Read the epic document at $EPIC_PATH
- Find the specific task named "$task_name"
- Load acceptance criteria and technical approach
- Consider PROJECT_TYPE in implementation choices

### 2. Test Framework Discovery
```bash
# Discover test framework and commands
echo "Discovering test setup..."

# Check for test commands in package.json, Makefile, etc.
if [ -f "package.json" ]; then
    grep -E '"(test|spec)"' package.json
elif [ -f "Makefile" ]; then
    grep -E '^test' Makefile
elif [ -f "Cargo.toml" ]; then
    echo "Rust project detected - using cargo test"
fi

# Check for test directories
ls -la | grep -E '(test|spec|__tests__|tests)'

# Look for test configuration files
ls -la | grep -E '(jest|mocha|pytest|vitest|cypress)'
```

### 3. Code Style Discovery
- Check for linting configuration
- Review existing code patterns
- Identify naming conventions
- Note import styles and file organization

## TDD Implementation Cycle

### Phase 1: Write Behavioral Test (RED)

Start with a test that describes the expected behavior:

**For API endpoints:**
```javascript
describe('POST /api/resource', () => {
  it('should create a resource when given valid data', async () => {
    // Arrange
    const validData = { /* based on spec */ };
    
    // Act
    const response = await request(app)
      .post('/api/resource')
      .send(validData);
    
    // Assert
    expect(response.status).toBe(201);
    expect(response.body).toMatchObject({
      id: expect.any(String),
      ...validData
    });
  });
  
  it('should return 400 when required field is missing', async () => {
    // Test for error cases based on acceptance criteria
  });
});
```

**For UI components:**
```javascript
describe('ResourceForm', () => {
  it('should submit form when all fields are valid', async () => {
    // Arrange
    render(<ResourceForm onSubmit={mockSubmit} />);
    
    // Act
    await userEvent.type(screen.getByLabelText('Name'), 'Test Name');
    await userEvent.click(screen.getByRole('button', { name: 'Submit' }));
    
    // Assert
    expect(mockSubmit).toHaveBeenCalledWith({
      name: 'Test Name'
    });
  });
});
```

**For business logic:**
```python
def test_calculate_discount_applies_percentage_correctly():
    # Arrange
    order = Order(total=100.00)
    discount = PercentageDiscount(10)
    
    # Act
    discounted_total = discount.apply(order)
    
    # Assert
    assert discounted_total == 90.00
```

### Phase 2: Run Test and Verify Failure

```bash
# Run the specific test
npm test -- --testNamePattern="should create a resource"
# or
pytest path/to/test_file.py::test_function_name
# or
cargo test test_function_name
```

Ensure the test fails for the right reason (not compilation errors).

### Phase 3: Implement Minimal Code (GREEN)

Write the simplest code that makes the test pass:

1. **Create necessary files/modules**
2. **Implement just enough to pass**
3. **Don't add extra functionality**
4. **Follow existing patterns**

Example progression:
```javascript
// Step 1: Make it compile
export function createResource(data) {
  return null;
}

// Step 2: Make it return something
export function createResource(data) {
  return { id: '123', ...data };
}

// Step 3: Make it actually work (if needed)
export async function createResource(data) {
  const resource = await db.resources.create({
    data: data
  });
  return resource;
}
```

### Phase 4: Refactor (REFACTOR)

Once green, improve the code:
- Extract common patterns
- Improve naming
- Add appropriate error handling
- Ensure code follows project standards

But always keep tests green!

### Phase 5: Add Next Test

Based on acceptance criteria, add the next test:
- Error cases
- Edge cases  
- Additional requirements

**IMPORTANT**: Once a test is written and passing, do NOT delete it without a very good reason. Tests are your safety net.

Repeat the cycle until all acceptance criteria are met.

## Implementation Checklist

For each story, ensure:

- [ ] All acceptance criteria have corresponding tests
- [ ] Tests are behavioral (test what, not how)
- [ ] Code handles error cases appropriately
- [ ] Code follows project conventions
- [ ] No unused code or over-engineering
- [ ] Documentation/comments where necessary
- [ ] Integration points are tested

## Code Quality Gates

After implementing each piece:

1. **Run all tests**
   ```bash
   npm test
   # or discovered test command
   ```

2. **Run linting**
   ```bash
   npm run lint
   # or discovered lint command
   ```

3. **Run type checking** (if applicable)
   ```bash
   npm run type-check
   # or discovered type check command
   ```

4. **Check test coverage**
   ```bash
   npm test -- --coverage
   # Ensure new code is covered
   ```

## Progress Tracking

After each test-implement cycle:
1. Update your mental model of progress
2. Check if any new edge cases were discovered
3. Verify you're still aligned with the spec

## Completion Criteria

The story is complete when:
- All acceptance criteria have passing tests
- All tests are green
- Code passes linting and type checking
- Coverage is adequate (check project standards)
- Code is refactored and clean
- No TODO comments remain

## Final Steps

1. **Run full test suite** to ensure no regressions
2. **Run build** to ensure it compiles
3. **Review changes** to ensure focus was maintained
4. **Update epic** if any clarifications were discovered

## Summary Output

Provide the user with:
- Number of tests written
- Code coverage achieved
- Files created/modified
- Any deviations from the spec and why
- Suggestions for next story to implement

## Next Steps

Save progress:
```bash
echo "LAST_IMPLEMENTED_TASK=$task_name" >> ./.project-context
```

```
Next step options:
- Implement another task: /4-tdd-implementation [next-task-name]
- Verify completion: /5-verify-completion
- All tasks done? Create PR with git
```

## Important Principles

1. **Test First**: Never write implementation before test
2. **One Test at a Time**: Don't write multiple tests at once
3. **Minimal Implementation**: Just enough to pass
4. **Refactor Under Green**: Only refactor when tests pass
5. **Stay Focused**: Don't implement beyond the story scope