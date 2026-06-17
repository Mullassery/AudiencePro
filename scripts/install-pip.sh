#!/bin/bash
# Install ClusterAudienceKit using pip
# Usage: bash install-pip.sh [version]

set -e

VERSION="${1:=latest}"
PYTHON_CMD=${PYTHON_CMD:=python3}

echo "🚀 Installing ClusterAudienceKit with pip..."
echo "Python version: $($PYTHON_CMD --version)"

if [ "$VERSION" = "latest" ]; then
    echo "📦 Installing latest version from PyPI..."
    $PYTHON_CMD -m pip install --upgrade clusteraudiencekit
else
    echo "📦 Installing version $VERSION..."
    $PYTHON_CMD -m pip install "clusteraudiencekit==$VERSION"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Verify installation:"
$PYTHON_CMD -c "from clusteraudiencekit import AudienceSegmenter; print('✅ ClusterAudienceKit imported successfully!')"

echo ""
echo "📚 Next steps:"
echo "1. Check the documentation: https://github.com/Mullassery/clusteraudiencekit"
echo "2. Run examples: python examples/basic_segmentation.py"
echo "3. Import and use: from clusteraudiencekit import AudienceSegmenter"
