# Build and run the API backend
dev: build
    uv run ravn-api

# Build the engine and sync workspace dependencies
build:
    uv sync

# Build with release optimizations
release:
    uv sync
    uv run maturin develop --release --manifest-path ravn-engine/Cargo.toml

# Build the engine CLI binary
cli:
    cargo build -p ravn-engine

# Run the engine CLI binary
run-cli: cli
    cargo run -p ravn-engine --bin ravn-cli

# Run Rust and Python linters
lint:
    cargo clippy --workspace --all-targets --all-features
    uv run ruff check .

# Run the Rust linter with extra-strict, highly opinionated rules
lint-pedantic:
    cargo clippy --workspace --all-targets --all-features -- -W clippy::pedantic

# Run all tests
test:
    cargo test --workspace --no-default-features
    uv run pytest

# Clean all build artifacts
clean:
    cargo clean
    -rm -rf .venv

# Remove lock files
clean-locks: clean
    rm uv.lock Cargo.lock
