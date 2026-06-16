#!/bin/bash
# Install AudiencePro using pip
# Usage: bash install-pip.sh [version]

set -e

VERSION="${1:=latest}"
PYTHON_CMD=${PYTHON_CMD:=python3}

echo "🚀 Installing AudiencePro with pip..."
echo "Python version: $($PYTHON_CMD --version)"

if [ "$VERSION" = "latest" ]; then
    echo "📦 Installing latest version from PyPI..."
    $PYTHON_CMD -m pip install --upgrade audience-pro
else
    echo "📦 Installing version $VERSION..."
    $PYTHON_CMD -m pip install "audience-pro==$VERSION"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Verify installation:"
$PYTHON_CMD -c "from audience_pro import AudienceSegmenter; print('✅ AudiencePro imported successfully!')"

echo ""
echo "📚 Next steps:"
echo "1. Check the documentation: https://github.com/Mullassery/AudiencePro"
echo "2. Run examples: python examples/basic_segmentation.py"
echo "3. Import and use: from audience_pro import AudienceSegmenter"
