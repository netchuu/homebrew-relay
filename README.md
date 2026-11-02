# Relay for Mac and Linux

This is the computer side of [Relay](https://relay.relay-cloud.workers.dev), an iPhone app for answering Claude Code
while you're away from your desk. The helper watches your Claude Code sessions through hooks, sends their
questions, plans and permission requests to your phone, and brings your answers back.

## Install

One command, on macOS or Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/netchuu/homebrew-tap/main/install.sh | sh
```

Or with Homebrew (also on Linux):

```sh
brew install netchuu/tap/relay && relay pair
```

Either way you end up looking at a QR code: scan it with the Relay app and you're done. The first `relay pair`
adds Relay's hooks to `~/.claude/settings.json` (keeping a backup) and starts the helper at login.

To update, run `brew upgrade relay`, then `relay install` again so the running helper picks up the new version.
To remove it, run `relay uninstall`, then `brew uninstall relay`. Your data stays in `~/.relay` until you delete
it.

You need macOS or Linux (x64 or arm64; WSL counts) and Claude Code 2.1.316 or later. The macOS binaries are
signed and notarized by Apple. The Linux ones are checked against `SHA256SUMS` by the installer and by Homebrew.

On Linux the helper runs as a systemd user service. On a server, run `sudo loginctl enable-linger $USER` so it
keeps running after you log out; `relay install` reminds you. Without systemd it runs as a background process
that you start again after a reboot with `relay restart`. Run Claude Code inside tmux so replies from the phone
arrive as typed input. On Alpine, install `libstdc++` first.

Questions or problems: [support page](https://relay.relay-cloud.workers.dev/support).
