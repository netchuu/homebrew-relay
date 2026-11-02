# Relay for Mac

This is the Mac side of [Relay](https://relay.relay-cloud.workers.dev), an iPhone app for answering Claude Code
while you're away from your desk. The helper watches your Claude Code sessions through hooks, sends their
questions, plans and permission requests to your phone, and brings your answers back.

## Install

```sh
brew install netchuu/relay/relay
relay install
relay pair
```

Without Homebrew:

```sh
curl -fsSL https://raw.githubusercontent.com/netchuu/homebrew-relay/main/install.sh | sh
```

`relay install` adds Relay's hooks to `~/.claude/settings.json` (keeping a backup) and starts the helper at login.
`relay pair` shows a QR code to scan with the iPhone app.

To update, run `brew upgrade relay`, then `relay install` again so the running helper picks up the new version.
To remove it, run `relay uninstall`, then `brew uninstall relay`. Your data stays in `~/.relay` until you delete
it.

You need macOS and Claude Code 2.1.316 or later. The binaries here are signed and notarized by Apple.

Questions or problems: [support page](https://relay.relay-cloud.workers.dev/support).
