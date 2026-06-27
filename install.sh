#!/usr/bin/env sh
# ClusterAudienceKit installer — detects pip or uv and installs the package.
#
# Usage:
#   curl -sSfL https://raw.githubusercontent.com/Mullassery/ClusterAudienceKit/main/install.sh | sh

set -e

PACKAGE="clusteraudiencekit"

echo "Installing $PACKAGE..."

if command -v uv >/dev/null 2>&1; then
    echo "Detected uv — running: uv add $PACKAGE"
    uv add "$PACKAGE"
elif command -v pip3 >/dev/null 2>&1; then
    echo "Detected pip3 — running: pip3 install $PACKAGE"
    pip3 install "$PACKAGE"
elif command -v pip >/dev/null 2>&1; then
    echo "Detected pip — running: pip install $PACKAGE"
    pip install "$PACKAGE"
else
    echo ""
    echo "Error: no pip or uv found. Install one first:"
    echo "  pip:  https://pip.pypa.io/en/stable/installation/"
    echo "  uv:   curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

echo ""
echo "ClusterAudienceKit installed. Verify with:"
echo '  python -c "import clusteraudiencekit; print(clusteraudiencekit.__version__)"'
