# txtodo Homebrew tap

`brew install aaronmyatt/tap/txtodo` — todo.sh-compatible CLI with real-time, end-to-end-encrypted
multi-device sync (https://github.com/aaronmyatt/txtodo). Ships `txtodo` (the CLI), `txtodod` (the
sync daemon) and `txtodo-tui` (the ratatui client), macOS arm64/x86_64.

`brew install --cask aaronmyatt/tap/txtodo-desktop` — the Tauri desktop app, macOS arm64/x86_64.
Depends on the `txtodo` formula above (bundles `txtodod` as a sidecar too, but the formula install
guarantees a working daemon on `$PATH` regardless). Unsigned/not notarized yet — Gatekeeper will
flag it "unidentified developer" until an Apple Developer ID cert is provisioned.

## Version bumps

`.github/workflows/autobump.yml` (standard `brew tap-new` scaffolding) runs `brew bump --open-pr`
daily against the main txtodo repo's GitHub releases. If its per-resource handling of this
formula's two `resource` blocks (`txtodod`, `txtodo-tui`) ever needs a hand, `bin/update-formula.sh
<tag> <assets-dir>` does the same url/sha256 substitution directly against a local directory of
downloaded release assets — see its own header comment and
https://github.com/aaronmyatt/txtodo/blob/main/tasks/brew-distribution/notes.md for the full
design and what's been verified so far.

The cask has its own counterpart, `bin/update-cask.sh <tag> <assets-dir>`, for the same reason —
see its own header comment.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
