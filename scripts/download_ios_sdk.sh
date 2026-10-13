#!/bin/bash
# Downloads Tpay.xcframework from the tpay-ios GitHub release into ios/Frameworks.
# The version is read from ios/flutter_tpay/Package.swift.
# Usage: bash scripts/download_ios_sdk.sh [version]
#   version - optional, sets the tpay-ios version in Package.swift before downloading

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PACKAGE_SWIFT="$ROOT_DIR/ios/flutter_tpay/Package.swift"
FRAMEWORKS_DIR="$ROOT_DIR/ios/Frameworks"

if [ $# -gt 0 ]; then
  sed -i.bak -E "s/(tpay-ios\.git\", exact: \")[^\"]+\"/\1$1\"/" "$PACKAGE_SWIFT"
  rm "$PACKAGE_SWIFT.bak"
fi

VERSION=$(sed -n -E 's/.*tpay-ios\.git", exact: "([^"]+)".*/\1/p' "$PACKAGE_SWIFT")
if [ -z "$VERSION" ]; then
  echo "error: tpay-ios version not found in $PACKAGE_SWIFT" >&2
  exit 1
fi

rm -rf "$FRAMEWORKS_DIR"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Fetching tpay-ios $VERSION manifest"
curl -fsSL -o "$TMP_DIR/Package.swift" "https://raw.githubusercontent.com/tpay-com/tpay-ios/$VERSION/Package.swift"
ZIP_URL=$(sed -n -E 's/.*url: *"([^"]+)".*/\1/p' "$TMP_DIR/Package.swift")
CHECKSUM=$(sed -n -E 's/.*checksum: *"([^"]+)".*/\1/p' "$TMP_DIR/Package.swift")
if [ -z "$ZIP_URL" ] || [ -z "$CHECKSUM" ]; then
  echo "error: url or checksum not found in tpay-ios $VERSION Package.swift" >&2
  exit 1
fi

echo "Downloading $ZIP_URL"
curl -fsSL -o "$TMP_DIR/Tpay.xcframework.zip" "$ZIP_URL"
ACTUAL_CHECKSUM=$(shasum -a 256 "$TMP_DIR/Tpay.xcframework.zip" | cut -d ' ' -f 1)
if [ "$ACTUAL_CHECKSUM" != "$CHECKSUM" ]; then
  echo "error: checksum mismatch, expected $CHECKSUM, got $ACTUAL_CHECKSUM" >&2
  exit 1
fi

unzip -q "$TMP_DIR/Tpay.xcframework.zip" "Precompiled/Tpay.xcframework/*" -d "$TMP_DIR"
mkdir -p "$FRAMEWORKS_DIR"
mv "$TMP_DIR/Precompiled/Tpay.xcframework" "$FRAMEWORKS_DIR/"

echo "Tpay.xcframework $VERSION saved to $FRAMEWORKS_DIR"
