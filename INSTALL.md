# Installation Guide for ClusterAudienceKit

ClusterAudienceKit can be installed using **pip**, **uv**, or **curl**. Choose the method that best fits your workflow.

## Quick Start

```bash
# Using pip
pip install clusteraudiencekit

# Using uv
uv pip install clusteraudiencekit

# Using curl (for local wheel)
curl -O https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
pip install ./clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
```

---

## Installation Methods

### 1. **pip** (Recommended for Most Users)

The standard Python package manager. Works with any Python environment.

```bash
# Install latest version from PyPI
pip install clusteraudiencekit

# Install specific version
pip install clusteraudiencekit==0.1.0

# Install with development dependencies
pip install clusteraudiencekit[dev]

# Install with documentation dependencies
pip install clusteraudiencekit[docs]

# Upgrade to latest version
pip install --upgrade clusteraudiencekit

# Install from GitHub (development)
pip install git+https://github.com/Mullassery/clusteraudiencekit.git
```

**Verify installation:**
```bash
python -c "from clusteraudiencekit import AudienceSegmenter; print(' ClusterAudienceKit installed!')"
```

---

### 2. **uv** (Fast Modern Alternative)

Ultra-fast Python package installer. If you don't have `uv` installed yet:

```bash
# Install uv first (if not already installed)
pip install uv

# Then install ClusterAudienceKit
uv pip install clusteraudiencekit

# Or use uv's project environment
uv pip install --python 3.11+ clusteraudiencekit
```

**Benefits of uv:**
-  10-100x faster than pip
-  Better dependency resolution
-  Works in virtual environments
-  Minimal dependency overhead

**Verify installation:**
```bash
uv run python -c "from clusteraudiencekit import AudienceSegmenter; print(' ClusterAudienceKit installed!')"
```

---

### 3. **curl** (For Downloaded Wheels)

Download pre-built wheels and install locally. Useful for air-gapped environments or offline installation.

#### Option A: Download from Releases

```bash
# For macOS ARM64 (Apple Silicon M1/M2/M3)
curl -L https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl -o clusteraudiencekit.whl

# For macOS Intel
curl -L https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_x86_64.whl -o clusteraudiencekit.whl

# For Linux
curl -L https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-linux_x86_64.whl -o clusteraudiencekit.whl

# For Windows
curl -L https://github.com/Mullassery/clusteraudiencekit/releases/download/v0.1.0/clusteraudiencekit-0.1.0-cp313-cp313-win_amd64.whl -o clusteraudiencekit.whl

# Install the downloaded wheel
pip install ./clusteraudiencekit.whl
```

#### Option B: Download from PyPI

```bash
# Download from PyPI CDN
curl -L https://files.pythonhosted.org/packages/.../clusteraudiencekit-0.1.0-cp313-cp313-macosx_11_0_arm64.whl -o clusteraudiencekit.whl

pip install ./clusteraudiencekit.whl
```

#### Option C: Download Source and Build

```bash
# Clone repository
curl -L https://github.com/Mullassery/clusteraudiencekit/archive/refs/heads/main.zip -o ClusterAudienceKit.zip
unzip ClusterAudienceKit.zip
cd ClusterAudienceKit

# Build from source (requires Rust)
pip install -e ".[dev]"
pytest tests/
```

**Verify installation:**
```bash
python -c "from clusteraudiencekit import AudienceSegmenter; print(' ClusterAudienceKit installed!')"
```

---

## Platform-Specific Information

### macOS

**Requirements:**
- Python 3.8+
- pip, uv, or curl

```bash
# Using Homebrew (optional)
brew install python@3.13

# Install ClusterAudienceKit
pip install clusteraudiencekit
```

**Supported Architectures:**
- ARM64 (Apple Silicon M1/M2/M3/M4)
- Intel x86_64

### Linux

**Requirements:**
- Python 3.8+ with pip
- glibc 2.17+ (most distributions have this)

```bash
# Ubuntu/Debian
sudo apt-get install python3-pip
pip install clusteraudiencekit

# Fedora/RHEL
sudo dnf install python3-pip
pip install clusteraudiencekit

# Arch
sudo pacman -S python-pip
pip install clusteraudiencekit
```

### Windows

**Requirements:**
- Python 3.8+ (from python.org or Microsoft Store)
- pip or uv

```bash
# Using Command Prompt or PowerShell
pip install clusteraudiencekit

# Or with uv
uv pip install clusteraudiencekit
```

---

## Development Installation

For development or contributing to ClusterAudienceKit:

```bash
# Clone the repository
git clone https://github.com/Mullassery/clusteraudiencekit.git
cd ClusterAudienceKit

# Install development dependencies
pip install -e ".[dev]"

pip install -e ".[dev]"

pytest tests/

# Run tests
pytest tests/

# Run linting
black . && ruff check .
mypy .

# Run benchmarks
pytest tests/ --benchmark-only
```

---

## Virtual Environments (Recommended)

It's best practice to install ClusterAudienceKit in a virtual environment:

### Using venv

```bash
# Create virtual environment
python -m venv audience-env

# Activate it
source audience-env/bin/activate  # macOS/Linux
# or
audience-env\Scripts\activate  # Windows

# Install ClusterAudienceKit
pip install clusteraudiencekit

# Deactivate when done
deactivate
```

### Using conda

```bash
# Create environment
conda create -n clusteraudiencekit python=3.13

# Activate it
conda activate clusteraudiencekit

# Install ClusterAudienceKit
pip install clusteraudiencekit

# Or use conda-forge if available
conda install -c conda-forge clusteraudiencekit
```

### Using uv with project config

```bash
# Create a new project with uv
uv init my-clusteraudiencekitject
cd my-clusteraudiencekitject

# Add ClusterAudienceKit as a dependency
uv add clusteraudiencekit

# Run your code
uv run python your_script.py
```

---

## Troubleshooting

### "ModuleNotFoundError: No module named 'clusteraudiencekit'"

**Solution:** Make sure you're not in the ClusterAudienceKit source directory when running Python.

```bash
# Don't do this:
cd ~/ClusterAudienceKit && python -c "import clusteraudiencekit"

# Do this instead:
cd ~ && python -c "import clusteraudiencekit"
```

### "ImportError: DLL load failed (Windows)"

**Solution:** Ensure you have the Visual C++ redistributables installed.

```bash
# Download from Microsoft:
# https://support.microsoft.com/en-us/help/2977003/
# Or use the installer bundled with Python
```

### "wheel incompatible with this Python"

**Solution:** Your Python version doesn't match the wheel version.

```bash
# Check your Python version
python --version

# Install compatible wheel
pip install --upgrade clusteraudiencekit
```

### Building from source fails

**Solution:** Ensure you have Rust installed:

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Update Rust
rustup update

# Try building again
pytest tests/
```

---

## Version Compatibility

| Python | Status | Notes |
|--------|--------|-------|
| 3.8 |  Supported | Oldest supported version |
| 3.9 |  Supported | |
| 3.10 |  Supported | |
| 3.11 |  Supported | Recommended |
| 3.12 |  Supported | Recommended |
| 3.13 |  Supported | Latest stable |
| 3.14+ |  Planned | Coming soon |

---

## Uninstall

To remove ClusterAudienceKit:

```bash
# Using pip
pip uninstall clusteraudiencekit

# Using uv
uv pip uninstall clusteraudiencekit
```

---

## Next Steps

After installation, check out:
- [Quick Start Guide](README.md#quick-start)
- [API Documentation](https://clusteraudiencekit.readthedocs.io/)
- [Examples](examples/)
- [Contributing Guide](CONTRIBUTING.md)

## Support

-  [Documentation](https://clusteraudiencekit.readthedocs.io/)
-  [Discussions](https://github.com/Mullassery/clusteraudiencekit/discussions)
-  [Report Issues](https://github.com/Mullassery/clusteraudiencekit/issues)
