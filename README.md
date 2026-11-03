# Relay

[Relay](https://relay.relay-cloud.workers.dev) lets you answer Claude Code from your phone. When a session on
your Mac or Linux computer asks a question, wants a plan approved or needs permission to run something, it
shows up on your phone; you tap an answer and the session carries on. Everything between the phone and the
computer is end-to-end encrypted.

You need two things: the app on your phone, and the helper on the computer that runs Claude Code.

## 1. Install the app

**Android** (Android 10 or later):

1. On the phone, download
   [Relay-1.0.1.apk](https://github.com/netchuu/homebrew-tap/releases/download/android-1.0.1/Relay-1.0.1.apk)
   (27 MB).
2. Open it. Android asks you to allow installing apps from your browser or file manager ("Install unknown
   apps"); allow it once, then tap Install.
3. Optional, to check the download, compare its SHA-256 with the one on the
   [release page](https://github.com/netchuu/homebrew-tap/releases/tag/android-1.0.1).

**iPhone**: Relay for iOS is in App Store review and will be on the App Store soon.

## 2. Install the helper on your computer

One command, on macOS or Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/netchuu/homebrew-tap/main/install.sh | sh
```

Or with Homebrew (also on Linux):

```sh
brew install netchuu/tap/relay && relay pair
```

Both end with a QR code in the terminal.

## 3. Pair

Open Relay on the phone and point the camera at the QR code. (No camera? Under the QR code the terminal prints
a line starting with `{"v":2`; send it to your phone and paste it into the app's text field.)

Allow notifications when asked. That's it: start Claude Code as usual, and its questions reach your phone
whenever you're away from the computer.

Replies you send from the phone are typed into the session as if you typed them, in Zed's terminal, iTerm2 and
tmux. Elsewhere (Terminal.app, Warp, VS Code, the Claude desktop app) they still arrive, marked as coming from
"another session".

The first `relay pair` adds Relay's hooks to `~/.claude/settings.json` (keeping a backup) and starts the helper
at login. If you use Zed, it also sets Zed's terminal to start through Relay (your shell, prompt and `claude`
command stay the same), so new Zed terminal tabs take replies as typed input. A custom shell set in Zed is left
alone, and `relay uninstall` undoes it. To pair another phone later, run `relay pair` again.

## Updating and removing

- **Helper:** `brew upgrade netchuu/tap/relay && relay install`. Use the full name: Homebrew also has an
  unrelated app called "relay", and a plain `brew upgrade relay` fails with "Cask 'relay' is not installed".
  `relay install` restarts the helper on the new version.
  With the curl installer, run the same command again.
- **Android app:** download the new APK and install it over the old one; your pairing stays.
- **Remove the helper:** `relay uninstall`, then `brew uninstall relay`. Your data stays in `~/.relay` until you
  delete it.

## Requirements and notes

- macOS or Linux (x64 or arm64; WSL counts) and Claude Code 2.1.316 or later.
- The macOS binaries are signed and notarized by Apple. The Linux ones are checked against `SHA256SUMS` by the
  installer and by Homebrew. The Android app is signed with Relay's own key, so updates install over it.
- On Linux the helper runs as a systemd user service. On a server, run `sudo loginctl enable-linger $USER` so it
  keeps running after you log out; `relay install` reminds you. Without systemd it runs as a background process
  that you start again after a reboot with `relay restart`. Run Claude Code inside tmux so replies from the phone
  arrive as typed input. On Alpine, install `libstdc++` first.

Questions or problems: [support page](https://relay.relay-cloud.workers.dev/support).
