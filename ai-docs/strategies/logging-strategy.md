# Logging Strategy Reference

This document defines a comprehensive logging strategy for production applications. It serves as a reference for AI agents and development teams to ensure consistent, effective logging practices across projects and technologies.

## Core Principles

### 1. Environment-Aware Logging

- **Development**: Human-readable logs with full context for debugging
- **Production**: Structured JSON logs optimized for aggregation and analysis
- **Client-side**: Never expose debug information in production browsers

### 2. Request Correlation

- Every request gets a unique identifier for end-to-end tracing
- User sessions are trackable across multiple requests
- Context propagates through all application layers

### 3. 12-Factor App Compliance

- All logs output to stdout for infrastructure handling
- No direct file writing or log rotation in application code
- Configuration via environment variables

### 4. Privacy by Design

- No PII (Personally Identifiable Information) in log messages
- Sanitization functions for sensitive data
- Audit trail compliance without privacy violations

## Logger Interface Standard

### Required Methods

Every logger should implement these four standard log levels:

- **error**: System errors, exceptions, critical failures
- **warn**: Warnings, authentication failures, recoverable issues
- **info**: Business events, user actions, system state changes
- **debug**: Detailed debugging information, performance metrics

### Message Structure

Each log entry should accept:

- **message**: Human-readable description of the event
- **metadata**: Structured data providing context (optional)

## Request Context Standard

### Context Information

Request context should include:

- **requestId**: Unique identifier for request correlation (UUID recommended)
- **userId**: Authenticated user ID (when available)
- **sessionId**: Session identifier for user tracking
- **clientIp**: Client IP address for security and analytics
- **userAgent**: User agent string for compatibility tracking
- **timestamp**: ISO 8601 formatted timestamp

### Context Injection

- Server-side: Context automatically injected into all log entries
- Client-side: Context forwarded with error reports to server
- Performance: Context injection should add <5ms overhead per request

## Log Format Standards

### Development Format (Human-Readable)

```
2024-01-15T10:30:00.000Z [INFO] [req_abc123] [user_xyz789] User completed action
  → action: login_success
  → sessionId: session_def456
  → duration: 250ms
```

### Production Format (Structured JSON)

```json
{
  "timestamp": "2024-01-15T10:30:00.000Z",
  "level": "info",
  "message": "User completed action",
  "requestId": "req_abc123",
  "userId": "user_xyz789",
  "sessionId": "session_def456",
  "meta": {
    "action": "login_success",
    "duration": 250
  }
}
```

## Client/Server Strategy

### Server-Side Logging

- **All environments**: Log to stdout (12-factor compliance)
- **Request context**: Auto-injected into every log entry
- **Performance**: <5ms overhead per request
- **Security**: Complete audit trail for compliance

### Client-Side Logging

- **Development**: Console logging for debugging (all levels)
- **Production**: No console output (security and performance)
- **Error reporting**: Client errors forwarded to server logging system
- **Detection**: Implement environment detection appropriate for your platform

## Common Logging Patterns

### Authentication Events

```
// Success
LOG_INFO: "User authentication successful"
META: { userId: "user123", method: "email_password", loginAttempts: 1 }

// Failure
LOG_WARN: "Authentication failed"
META: { email: "j***@example.com", reason: "invalid_password", attemptCount: 3 }
```

### Business Events

```
// User journey tracking
LOG_INFO: "User completed onboarding step"
META: { step: "profile_creation", completionTime: 45000, previousStep: "email_verification" }

// Feature usage
LOG_INFO: "Feature accessed"
META: { feature: "voice_call", userId: "user123", context: "campaign_participation" }
```

### Performance Monitoring

```
// API response times
LOG_DEBUG: "External API call completed"
META: { service: "third_party_service", endpoint: "/v1/users", duration: 250, status: 200 }

// Database queries
LOG_DEBUG: "Database query executed"
META: { operation: "findUser", duration: 45, rowsAffected: 1, table: "users" }
```

### Error Handling

```
// Application errors
LOG_ERROR: "Operation failed"
META: { operation: "processPayment", error: "Insufficient funds", userId: "user123" }

// System errors
LOG_ERROR: "System resource unavailable"
META: { resource: "database_connection", error: "Connection timeout", retryCount: 3 }
```

## Security Considerations

### Data Sanitization Principles

- **Email addresses**: Show only first character + domain (`j***@example.com`)
- **Phone numbers**: Mask middle digits (`+1-555-***-1234`)
- **Credit cards**: Show only last 4 digits (`****-****-****-1234`)
- **Sensitive fields**: Remove completely from logs (`password`, `ssn`, `apiKey`)

### Audit Trail Requirements

- All authentication attempts (success/failure)
- Authorization decisions for protected resources
- Data access and modification events
- System configuration changes
- Security-relevant user actions

### PII Protection

- Implement sanitization functions for all user-generated content
- Use field allowlists rather than blocklists for sensitive data
- Log data access patterns without exposing actual data
- Ensure compliance with privacy regulations (GDPR, CCPA, etc.)

## Performance Optimization

### Lazy Evaluation

- Avoid expensive operations unless logging level is active
- Use conditional logging for heavy serialization
- Implement lazy string formatting where possible

### Async Logging

- Consider asynchronous logging for high-throughput applications
- Use queuing mechanisms for batch processing
- Avoid blocking application threads with logging operations

### Resource Management

- Reuse logger instances rather than creating new ones
- Implement proper cleanup for request context
- Monitor memory usage in long-running applications

## Testing Strategy

### Unit Testing

- Verify log format consistency (development vs production)
- Test context injection and extraction
- Validate PII sanitization functions
- Measure logging performance impact

### Integration Testing

- Test request correlation across application layers
- Validate user session tracking end-to-end
- Verify security event logging completeness
- Test client error reporting to server

### Performance Testing

- Measure logging overhead per request
- Test context injection performance
- Validate memory usage patterns
- Test log aggregation service compatibility

## Deployment Considerations

### Environment Configuration

```bash
# Development
LOG_LEVEL=debug
LOG_FORMAT=human

# Production
LOG_LEVEL=info
LOG_FORMAT=json
LOG_CONTEXT_TIMEOUT=5000
```

### Monitoring Integration

- Log aggregation service configuration
- Alert thresholds for error rates
- Performance monitoring for logging overhead
- Context injection success rate tracking

## Migration Strategy

### From Legacy Logging

1. **Identify**: Find all unstructured logging statements
2. **Replace**: Migrate to structured logger calls
3. **Enhance**: Add context and metadata
4. **Validate**: Ensure no PII exposure
5. **Monitor**: Track logging performance impact

### Gradual Rollout

1. **Phase 1**: Infrastructure setup (middleware, logger)
2. **Phase 2**: Core services (auth, API routes)
3. **Phase 3**: Business logic (user flows, features)
4. **Phase 4**: Full application coverage

## Success Metrics

### Technical Metrics

- **Request correlation**: 100% of requests have unique IDs
- **Context injection**: All logs include request context
- **Performance**: <5ms logging overhead per request
- **Format consistency**: 100% structured logs in production
- **Coverage**: All application layers use structured logging

### Business Metrics

- **Debug efficiency**: 50% reduction in troubleshooting time
- **Security visibility**: Complete audit trail coverage
- **User journey tracking**: End-to-end session correlation
- **Feature insights**: Actionable analytics from log data

## Common Pitfalls

### Avoid These Patterns

- **Sensitive data exposure**: Never log passwords, API keys, or PII
- **String concatenation**: Use structured metadata instead
- **Per-request logger creation**: Reuse logger instances
- **Ignoring log levels**: Respect configured logging levels
- **Blocking operations**: Avoid synchronous I/O in logging

### Best Practices

- **Sanitize sensitive data**: Use appropriate sanitization functions
- **Use structured metadata**: Provide context as key-value pairs
- **Reuse logger instances**: Minimize object creation overhead
- **Respect log levels**: Honor configured logging verbosity
- **Async where appropriate**: Consider async logging for performance

## Implementation Patterns

### Request Context Middleware

Implement middleware that:

1. Generates unique request identifier
2. Extracts user context from authentication
3. Injects context into logger for request lifecycle
4. Cleans up context after request completion

### Client Error Reporting

Implement client-side error reporting that:

1. Captures client-side errors with context
2. Forwards errors to server logging system
3. Includes user session information
4. Respects production logging policies

### Log Aggregation Integration

Configure log aggregation that:

1. Parses structured JSON logs
2. Indexes by request ID and user ID
3. Enables correlation across services
4. Provides search and alerting capabilities

## Conclusion

This logging strategy provides a foundation for consistent, effective logging across projects and technologies. It balances development experience with production requirements while maintaining security and performance standards.

**Key Takeaways:**

- Focus on structured logging with consistent formats
- Implement request correlation for end-to-end tracing
- Prioritize security and privacy in all logging decisions
- Optimize for performance without sacrificing observability
- Test logging implementations thoroughly

Remember: Good logging is an investment in maintainability, security, and operational excellence. It should enhance debugging efficiency without compromising user privacy or system performance.

Adapt specific implementations to your framework and infrastructure needs while preserving these core principles.
