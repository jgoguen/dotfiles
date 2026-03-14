---
description: Review the current code changes
---

Review the changes made in the currently checked out commit. Look for any
potential improvements, bugs, security issues, or areas that could be optimized.
Consider the following aspects:

- Code readability and maintainability
- Consistent naming conventions
- Adherence to coding standards and best practices
- Performance implications
- Security vulnerabilities
- Proper error handling and logging
- Test coverage and quality
- Tests cover edge cases and error scenarios
- Keep dependencies up to date
- Debug logging is disabled by default

Error handling best practices:

- Handle errors gracefully, don't let the program crash
- Use try-catch for operations that might fail
- Log errors with context to aid debugging
- Return meaningful error messages to users
- Differentiate between recoverable and unrecoverable errors
- Don't expose internal error details to end users

Security best practices:

- Validate and sanitize all user input to prevent injection attacks
- Use parameterized queries to prevent SQL injection
- Implement proper authentication and authorization checks
- Follow the principle of least privilege

Provide constructive feedback and suggestions for improvement. Order your review
comments to prioritize critical issues first, followed by less severe concerns
and suggestions for enhancement. If applicable, include specific code snippets
or examples to illustrate your points.
