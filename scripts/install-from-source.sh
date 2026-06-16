#!/bin/bash
# Install AudiencePro from source
# Usage: bash install-from-source.sh

set -e

echo "🚀 Installing AudiencePro from source..."
echo ""

# Check for Rust
if ! command -v rustc &> /dev/null; then
    echo "❌ Rust not found. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
fi

echo "✅ Rust version: $(rustc --version)"
echo "✅ Cargo version: $(cargo --version)"
echo ""

# Check for Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found"
    exit 1
fi

echo "✅ Python version: $(python3 --version)"
echo ""

# Install maturin if not present
echo "📦 Checking maturin..."
if ! python3 -m pip show maturin &> /dev/null; then
    echo "Installing maturin..."
    python3 -m pip install maturin
fi

echo "✅ maturin installed"
echo ""

# Clone if needed
if [ ! -d "AudiencePro" ]; then
    echo "📥 Cloning AudiencePro repository..."
    git clone https://github.com/Mullassery/AudiencePro.git
fi

cd AudiencePro

echo ""
echo "🔨 Building and installing..."
maturin develop

echo ""
echo "✅ Installation complete!"
echo ""
echo "Verify installation:"
python3 -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro imported successfully!')"

echo ""
echo "📚 Development resources:"
echo "1. Run tests: pytest tests/"
echo "2. Format code: cargo fmt"
echo "3. Check with clippy: cargo clippy"
echo "4. Run benchmarks: cargo bench"
echo "5. View examples: ls examples/"
