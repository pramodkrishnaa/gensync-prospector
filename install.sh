#!/usr/bin/env bash
# GenSync Prospector installer (macOS / Linux)
# Copies the gensync skill pack into your Hermes skills directory.
set -euo pipefail

HOME_DIR="${HERMES_HOME:-$HOME/.hermes}"
SRC="$(cd "$(dirname "$0")" && pwd)/skills/gensync"
DEST="$HOME_DIR/skills/gensync"

mkdir -p "$HOME_DIR/skills"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

echo "Installed gensync skill pack to $DEST"
echo "Next: edit $DEST/CONTEXT.md, then ask Hermes to 'run gensync-lead-scout'."
