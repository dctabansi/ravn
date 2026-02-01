# ravn

**R**ecursive **A**daptive **V**alue **N**etwork — A multi-stage chess engine and full-stack platform built with Rust, Python, and Next.js.

---

## Architecture

```
┌───────────────────────────────────────────────────────────────────┐
│                             ravn-web                              │
│                    (Next.js / TypeScript UI)                      │
└─────────────────────────────────┬─────────────────────────────────┘
                                  │ HTTP / WebSocket
                                  ▼
┌───────────────────────────────────────────────────────────────────┐
│                             ravn-api                              │
│                     (Python / Litestar API)                       │
└─────────────────────────────────┬─────────────────────────────────┘
                                  │ PyO3 FFI (import ravn_engine)
                                  ▼
┌───────────────────────────────────────────────────────────────────┐
│                            ravn-engine                            │
│          (Rust Core Engine: Bitboards, Magic Moves, Search)       │
└─────────────────────────────────▲─────────────────────────────────┘
                                  │ PyO3 FFI / Self-Play & Eval
┌─────────────────────────────────┴─────────────────────────────────┐
│                            ravn-train                             │
│              (Python ML Training & Data Pipelines)                │
└───────────────────────────────────────────────────────────────────┘
```

## Monorepo Directory Structure

```text
ravn/
├── Cargo.toml                  # Rust workspace configuration
├── Cargo.lock                  # Rust workspace lockfile
├── pyproject.toml              # Unified uv workspace & linter configuration
├── uv.lock                     # Unified Python workspace lockfile
├── justfile                    # Task runner recipes
├── ravn-engine/                # Rust chess engine crate & PyO3 bridge (ravn_engine)
│   ├── Cargo.toml
│   ├── pyproject.toml          # Maturin build configuration
│   ├── engine_macros/          # Procedural macros crate
│   └── src/                    # Bitboards, magics, Zobrist hashing, eval, alpha-beta & TT search
├── ravn-api/                   # Python / Litestar backend package (uv_build)
│   ├── pyproject.toml
│   ├── src/
│   │   └── ravn_api/
│   └── tests/
├── ravn-train/                 # Python / ML training & data pipelines package (uv_build)
│   ├── pyproject.toml
│   └── src/
│       └── ravn_train/
└── ravn-web/                   # Next.js / TypeScript frontend package
    ├── package.json
    ├── tsconfig.json
    └── src/
```

## Getting Started

### Prerequisites

- **Rust** (Edition 2024 / stable toolchain via `rustup`)
- **Python** (`>=3.14`) managed with [`uv`](https://docs.astral.sh/uv/)
- **Node.js** (`>=20`) & `npm` / `pnpm`
- [`just`](https://github.com/casey/just) (optional command runner)

### Setup & Installation

Resolve the workspace lockfile, compile the `ravn-engine` PyO3 extension via `maturin`, and install all Python workspace packages (`ravn-api`, `ravn-train`, `ravn-engine`):

```bash
uv lock
uv sync
```

### Running Commands

#### API Backend (`ravn-api`)
```bash
uv run ravn-api
# or via just:
just dev
```

#### Rust Engine CLI (`ravn-engine`)
```bash
cargo run -p ravn-engine --bin ravn-cli
# or via just:
just run-cli
```

#### Frontend (`ravn-web`)
```bash
cd ravn-web
npm run build
```

#### Linting & Testing
```bash
# Rust linter
cargo clippy --workspace --all-targets --all-features

# Python linter
uv run ruff check .

# Run tests
cargo test --workspace
uv run pytest
```

## License

MIT License — see [LICENSE](LICENSE) for details.
