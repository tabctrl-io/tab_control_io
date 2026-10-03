#!/usr/bin/env bash
# MCP Tab Control Installer (Linux/macOS)

set -e

REPO="tabctrl-io/tab_control_go"
BINARY_NAME="mcp-tab-control"

# 1. Detect OS & Architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
    Linux*)     OS_NAME="Linux";;
    Darwin*)    OS_NAME="Darwin";;
    *)          echo "Unsupported OS: ${OS}"; exit 1;;
esac

case "${ARCH}" in
    x86_64)     ARCH_NAME="x86_64";;
    amd64)      ARCH_NAME="x86_64";;
    arm64)      ARCH_NAME="arm64";;
    aarch64)    ARCH_NAME="arm64";;
    *)          echo "Unsupported architecture: ${ARCH}"; exit 1;;
esac

echo "Detecting latest release for ${OS_NAME} ${ARCH_NAME}..."

# 2. Fetch Latest Release from GitHub API
LATEST_RELEASE=$(curl -sL "https://api.github.com/repos/${REPO}/releases/latest")
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep "browser_download_url.*${OS_NAME}_${ARCH_NAME}.tar.gz" | cut -d '"' -f 4)
VERSION=$(echo "$LATEST_RELEASE" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Could not find a matching binary for ${OS_NAME} ${ARCH_NAME} in the latest release."
    exit 1
fi

echo "Downloading ${VERSION}..."

# 3. Download and Extract
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
curl -sL "$DOWNLOAD_URL" -o "release.tar.gz"
tar -xzf release.tar.gz "$BINARY_NAME"

# 4. Install
INSTALL_DIR="/usr/local/bin"
if [ ! -w "$INSTALL_DIR" ]; then
    echo "Requires sudo privileges to install to $INSTALL_DIR"
    sudo mv "$BINARY_NAME" "$INSTALL_DIR/"
    sudo chmod +x "$INSTALL_DIR/$BINARY_NAME"
else
    mv "$BINARY_NAME" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/$BINARY_NAME"
fi

# Clean up
cd - > /dev/null
rm -rf "$TMP_DIR"

echo ""
echo "✅ Successfully installed ${BINARY_NAME} ${VERSION} to ${INSTALL_DIR}!"
echo ""
echo "--------------------------------------------------------"
echo "🚀 Getting Started"
echo "--------------------------------------------------------"
echo "1. Start the background daemon:"
echo "   $ mcp-tab-control start"
echo ""
echo "2. Add the following to your AI Agent's MCP config:"
echo "   {"
echo "     \"command\": \"mcp-tab-control\","
echo "     \"args\": [\"stdio\"]"
echo "   }"
echo "--------------------------------------------------------"
