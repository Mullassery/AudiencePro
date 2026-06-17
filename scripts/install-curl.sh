#!/bin/bash
# Install ClusterAudienceKit from pre-built wheel using curl
# Usage: bash install-curl.sh [platform] [python-version]
# Example: bash install-curl.sh macos-arm64 3.13

set -e

PYTHON_CMD=${PYTHON_CMD:=python3}
REPO="Mullassery/clusteraudiencekit"
RELEASE_TAG="v0.1.0"
TEMP_DIR=$(mktemp -d)

# Detect platform if not specified
PLATFORM="${1:=auto}"
PY_VERSION="${2:=313}"

echo "🚀 Installing ClusterAudienceKit from pre-built wheels..."
echo ""

# Auto-detect platform
if [ "$PLATFORM" = "auto" ]; then
    UNAME=$(uname -s)
    ARCH=$(uname -m)

    if [ "$UNAME" = "Darwin" ]; then
        if [ "$ARCH" = "arm64" ]; then
            PLATFORM="macos-arm64"
        else
            PLATFORM="macos-intel"
        fi
    elif [ "$UNAME" = "Linux" ]; then
        PLATFORM="linux-x86_64"
    else
        echo "❌ Unsupported platform: $UNAME"
        exit 1
    fi
fi

echo "📌 Platform detected: $PLATFORM"
echo "📌 Python version: $PY_VERSION"
echo ""

# Map platform to wheel filename
case "$PLATFORM" in
    "macos-arm64")
        WHEEL_PATTERN="cp${PY_VERSION}-cp${PY_VERSION}-macosx_11_0_arm64.whl"
        ;;
    "macos-intel")
        WHEEL_PATTERN="cp${PY_VERSION}-cp${PY_VERSION}-macosx_11_0_x86_64.whl"
        ;;
    "linux-x86_64")
        WHEEL_PATTERN="cp${PY_VERSION}-cp${PY_VERSION}-linux_x86_64.whl"
        ;;
    "windows-amd64")
        WHEEL_PATTERN="cp${PY_VERSION}-cp${PY_VERSION}-win_amd64.whl"
        ;;
    *)
        echo "❌ Unsupported platform: $PLATFORM"
        exit 1
        ;;
esac

WHEEL_NAME="clusteraudiencekit-0.1.0-${WHEEL_PATTERN}"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${RELEASE_TAG}/${WHEEL_NAME}"

echo "📥 Downloading: $WHEEL_NAME"
echo "   URL: $DOWNLOAD_URL"
echo ""

# Download wheel
if command -v curl &> /dev/null; then
    curl -L -o "$TEMP_DIR/$WHEEL_NAME" "$DOWNLOAD_URL"
elif command -v wget &> /dev/null; then
    wget -O "$TEMP_DIR/$WHEEL_NAME" "$DOWNLOAD_URL"
else
    echo "❌ Neither curl nor wget found"
    exit 1
fi

if [ ! -f "$TEMP_DIR/$WHEEL_NAME" ]; then
    echo "❌ Failed to download wheel"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "✅ Download complete"
echo ""

# Install wheel
echo "💾 Installing wheel..."
$PYTHON_CMD -m pip install "$TEMP_DIR/$WHEEL_NAME"

# Cleanup
rm -rf "$TEMP_DIR"

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
