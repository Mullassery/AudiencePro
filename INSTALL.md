# Installation Guide for AudiencePro

AudiencePro can be installed using **pip**, **uv**, or **curl**. Choose the method that best fits your workflow.

## Quick Start

```bash
# Using pip
pip install audience-pro

# Using uv
uv pip install audience-pro

# Using curl (for local wheel)
curl -O https://github.com/Mullassery/AudiencePro/releases/download/v0.1.0/audience_pro-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
pip install ./audience_pro-0.1.0-cp313-cp313-macosx_11_0_arm64.whl
```

---

## Installation Methods

### 1. **pip** (Recommended for Most Users)

The standard Python package manager. Works with any Python environment.

```bash
# Install latest version from PyPI
pip install audience-pro

# Install specific version
pip install audience-pro==0.1.0

# Install with development dependencies
pip install audience-pro[dev]

# Install with documentation dependencies
pip install audience-pro[docs]

# Upgrade to latest version
pip install --upgrade audience-pro

# Install from GitHub (development)
pip install git+https://github.com/Mullassery/AudiencePro.git
```

**Verify installation:**
```bash
python -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro installed!')"
```

---

### 2. **uv** (Fast Modern Alternative)

Ultra-fast Python package installer. If you don't have `uv` installed yet:

```bash
# Install uv first (if not already installed)
pip install uv

# Then install AudiencePro
uv pip install audience-pro

# Or use uv's project environment
uv pip install --python 3.11+ audience-pro
```

**Benefits of uv:**
- ⚡ 10-100x faster than pip
- 🔒 Better dependency resolution
- 📦 Works in virtual environments
- 🎯 Minimal dependency overhead

**Verify installation:**
```bash
uv run python -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro installed!')"
```

---

### 3. **curl** (For Downloaded Wheels)

Download pre-built wheels and install locally. Useful for air-gapped environments or offline installation.

#### Option A: Download from Releases

```bash
# For macOS ARM64 (Apple Silicon M1/M2/M3)
curl -L https://github.com/Mullassery/AudiencePro/releases/download/v0.1.0/audience_pro-0.1.0-cp313-cp313-macosx_11_0_arm64.whl -o audience_pro.whl

# For macOS Intel
curl -L https://github.com/Mullassery/AudiencePro/releases/download/v0.1.0/audience_pro-0.1.0-cp313-cp313-macosx_11_0_x86_64.whl -o audience_pro.whl

# For Linux
curl -L https://github.com/Mullassery/AudiencePro/releases/download/v0.1.0/audience_pro-0.1.0-cp313-cp313-linux_x86_64.whl -o audience_pro.whl

# For Windows
curl -L https://github.com/Mullassery/AudiencePro/releases/download/v0.1.0/audience_pro-0.1.0-cp313-cp313-win_amd64.whl -o audience_pro.whl

# Install the downloaded wheel
pip install ./audience_pro.whl
```

#### Option B: Download from PyPI

```bash
# Download from PyPI CDN
curl -L https://files.pythonhosted.org/packages/.../audience_pro-0.1.0-cp313-cp313-macosx_11_0_arm64.whl -o audience_pro.whl

pip install ./audience_pro.whl
```

#### Option C: Download Source and Build

```bash
# Clone repository
curl -L https://github.com/Mullassery/AudiencePro/archive/refs/heads/main.zip -o AudiencePro.zip
unzip AudiencePro.zip
cd AudiencePro

# Build from source (requires Rust)
pip install maturin
maturin develop
```

**Verify installation:**
```bash
python -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro installed!')"
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

# Install AudiencePro
pip install audience-pro
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
pip install audience-pro

# Fedora/RHEL
sudo dnf install python3-pip
pip install audience-pro

# Arch
sudo pacman -S python-pip
pip install audience-pro
```

### Windows

**Requirements:**
- Python 3.8+ (from python.org or Microsoft Store)
- pip or uv

```bash
# Using Command Prompt or PowerShell
pip install audience-pro

# Or with uv
uv pip install audience-pro
```

---

## Development Installation

For development or contributing to AudiencePro:

```bash
# Clone the repository
git clone https://github.com/Mullassery/AudiencePro.git
cd AudiencePro

# Install development dependencies
pip install -e ".[dev]"

# Install maturin for building Rust extensions
pip install maturin

# Build the Rust extension
maturin develop

# Run tests
pytest tests/

# Run linting
cargo fmt
cargo clippy

# Run benchmarks
cargo bench
```

---

## Virtual Environments (Recommended)

It's best practice to install AudiencePro in a virtual environment:

### Using venv

```bash
# Create virtual environment
python -m venv audience-env

# Activate it
source audience-env/bin/activate  # macOS/Linux
# or
audience-env\Scripts\activate  # Windows

# Install AudiencePro
pip install audience-pro

# Deactivate when done
deactivate
```

### Using conda

```bash
# Create environment
conda create -n audience-pro python=3.13

# Activate it
conda activate audience-pro

# Install AudiencePro
pip install audience-pro

# Or use conda-forge if available
conda install -c conda-forge audience-pro
```

### Using uv with project config

```bash
# Create a new project with uv
uv init my-audience-project
cd my-audience-project

# Add AudiencePro as a dependency
uv add audience-pro

# Run your code
uv run python your_script.py
```

---

## Troubleshooting

### "ModuleNotFoundError: No module named 'audience_pro'"

**Solution:** Make sure you're not in the AudiencePro source directory when running Python.

```bash
# Don't do this:
cd ~/AudiencePro && python -c "import audience_pro"

# Do this instead:
cd ~ && python -c "import audience_pro"
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
pip install --upgrade audience-pro
```

### Building from source fails

**Solution:** Ensure you have Rust installed:

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Update Rust
rustup update

# Try building again
maturin develop
```

---

## Version Compatibility

| Python | Status | Notes |
|--------|--------|-------|
| 3.8 | ✅ Supported | Oldest supported version |
| 3.9 | ✅ Supported | |
| 3.10 | ✅ Supported | |
| 3.11 | ✅ Supported | Recommended |
| 3.12 | ✅ Supported | Recommended |
| 3.13 | ✅ Supported | Latest stable |
| 3.14+ | ⏳ Planned | Coming soon |

---

## Uninstall

To remove AudiencePro:

```bash
# Using pip
pip uninstall audience-pro

# Using uv
uv pip uninstall audience-pro
```

---

## Next Steps

After installation, check out:
- [Quick Start Guide](README.md#quick-start)
- [API Documentation](https://audience-pro.readthedocs.io/)
- [Examples](examples/)
- [Contributing Guide](CONTRIBUTING.md)

## Support

- 📖 [Documentation](https://audience-pro.readthedocs.io/)
- 💬 [Discussions](https://github.com/Mullassery/AudiencePro/discussions)
- 🐛 [Report Issues](https://github.com/Mullassery/AudiencePro/issues)
- 📧 Email: mullassery@gmail.com
