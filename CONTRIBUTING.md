# Contributing to AudiencePro

Thank you for your interest in contributing to AudiencePro! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful and constructive in all interactions. We're committed to providing a welcoming and inclusive environment.

## Getting Started

### Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/AudiencePro.git
cd AudiencePro
```

### Set Up Development Environment

```bash
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Python dependencies
pip install -e ".[dev]"

# Install maturin
pip install maturin

# Build the Rust extension
maturin develop
```

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes

- Follow [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- Use `cargo fmt` to format code
- Use `cargo clippy` to check for common mistakes

```bash
cargo fmt
cargo clippy --all-targets
```

### 3. Write Tests

- Add unit tests in `src/` alongside code
- Add integration tests in `tests/`
- Maintain >90% code coverage

```bash
# Run all tests
cargo test
pytest tests/

# Run with coverage
tarpaulin --out Html
```

### 4. Run Benchmarks

Performance regression tests:

```bash
cargo bench
```

### 5. Update Documentation

- Update docstrings for public APIs
- Update README.md if feature changes user-facing API
- Add examples in `examples/`

### 6. Commit Your Changes

```bash
git add .
git commit -m "Brief description of changes"
```

Follow [conventional commits](https://www.conventionalcommits.org/):
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `test:` Testing
- `perf:` Performance improvement
- `refactor:` Code refactoring
- `ci:` CI/CD changes
- `chore:` Build, dependencies

### 7. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Create a pull request with a clear description of:
- What the change does
- Why it's needed
- How it was tested

## Pull Request Guidelines

- Keep PRs focused on a single feature or fix
- Provide clear, concise commit messages
- Include tests for all new functionality
- Update documentation as needed
- Ensure all tests pass

### Review Process

- Maintainers will review within 7 days
- Respond to review comments
- Push updates to the same branch
- Get approval before merging

## Coding Standards

### Rust

- Use `rustfmt` (enforced in CI)
- Use `clippy` for linting
- Write clear, idiomatic Rust
- Prefer composition over inheritance
- Document public APIs with examples

Example:

```rust
/// Calculate RFM scores for customers.
///
/// # Arguments
/// * `transactions` - Customer transaction data
/// * `reference_date` - Date for recency calculation
///
/// # Returns
/// Vector of RFM scores
///
/// # Example
/// ```ignore
/// let rfm = calculate_rfm(transactions, Date::today())?;
/// ```
pub fn calculate_rfm(
    transactions: Vec<Transaction>,
    reference_date: Date,
) -> Result<Vec<RFMScore>> {
    // Implementation
}
```

### Python

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use type hints
- Use Black for formatting
- Use Ruff for linting

```bash
black src/
ruff check src/
mypy src/
```

## Testing

### Unit Tests (Rust)

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_rfm_calculation() {
        let transactions = vec![/* ... */];
        let rfm = calculate_rfm(transactions, reference_date).unwrap();
        assert_eq!(rfm.len(), 5);
    }
}
```

### Integration Tests (Python)

```python
import pytest
from audience_pro import AudienceSegmenter

def test_fit_predict_pipeline():
    segmenter = AudienceSegmenter(n_clusters=4)
    segments = segmenter.fit_predict(test_df)
    assert len(segments) == len(test_df)
    assert segments.min() >= 0
    assert segments.max() < 4
```

### Benchmarking

```bash
# Run benchmarks
cargo bench

# Compare against baseline
cargo bench -- --baseline=main
```

## Documentation

- Update docstrings for all public APIs
- Include examples in docstrings
- Update README.md for user-facing changes
- Add or update examples in `examples/`

## Reporting Issues

Use the GitHub issue tracker:

1. Check existing issues first
2. Include:
   - Clear description of the issue
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Environment (OS, Python version, etc.)
3. Use issue templates when available

## Suggesting Features

- Open an issue with "Feature Request" label
- Describe the feature and use case
- Explain why it's needed
- Link to similar features in other libraries

## License

By contributing, you agree that your contributions will be licensed under the same MIT license as the project.

## Questions?

- Open a GitHub Discussion
- Email: mullassery@gmail.com
- Check existing documentation and issues first

Thank you for contributing to AudiencePro!
