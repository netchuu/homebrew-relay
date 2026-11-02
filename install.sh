#!/bin/sh
# Installs the Relay Mac helper without Homebrew:
#   curl -fsSL https://raw.githubusercontent.com/netchuu/homebrew-relay/main/install.sh | sh
# Downloads the release for this Mac, checks it against SHA256SUMS and runs `relay install`, which copies
# it to ~/.relay/bin, adds the Claude Code hooks and starts it at login. No sudo needed.
set -eu

REPO="netchuu/homebrew-relay"
case "$(uname -s)" in Darwin) ;; *) echo "The Relay helper only runs on macOS for now." >&2; exit 1 ;; esac
case "$(uname -m)" in arm64) ARCH=arm64 ;; x86_64) ARCH=x64 ;; *) echo "Unsupported CPU: $(uname -m)" >&2; exit 1 ;; esac

VERSION="${RELAY_VERSION:-$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p' | head -1)}"
[ -n "$VERSION" ] || { echo "Couldn't find the latest release. Check your connection and try again." >&2; exit 1; }

NAME="relay-$VERSION-darwin-$ARCH"
BASE="https://github.com/$REPO/releases/download/v$VERSION"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Downloading Relay $VERSION ($ARCH)…"
curl -fsSL "$BASE/$NAME.tar.gz" -o "$TMP/$NAME.tar.gz"
curl -fsSL "$BASE/SHA256SUMS" -o "$TMP/SHA256SUMS"
EXPECTED="$(grep "$NAME.tar.gz" "$TMP/SHA256SUMS" | cut -d' ' -f1)"
ACTUAL="$(shasum -a 256 "$TMP/$NAME.tar.gz" | cut -d' ' -f1)"
[ -n "$EXPECTED" ] && [ "$EXPECTED" = "$ACTUAL" ] || { echo "The download doesn't match its checksum, so it wasn't installed. Try again." >&2; exit 1; }

tar -xzf "$TMP/$NAME.tar.gz" -C "$TMP"
"$TMP/$NAME/relay" install

mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.relay/bin/relay" "$HOME/.local/bin/relay"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) echo "Add ~/.local/bin to your PATH to use the relay command." ;; esac
echo "Installed. Now run: relay pair"
