# txtodo Homebrew tap

`brew install aaronmyatt/tap/txtodo` — todo.sh-compatible CLI with real-time, end-to-end-encrypted
multi-device sync (https://github.com/aaronmyatt/txtodo). Ships `txtodo` (the CLI), `txtodod` (the
sync daemon) and `txtodo-tui` (the ratatui client), for macOS arm64/x86_64 and Linux arm64/x86_64
(the static musl builds; x86_64 install and `brew test` pass in CI, arm64 is untried).

`brew install --cask aaronmyatt/tap/txtodo-desktop` — the Tauri desktop app, macOS arm64/x86_64.
Depends on the `txtodo` formula above (bundles `txtodod` as a sidecar too, but the formula install
guarantees a working daemon on `$PATH` regardless). Unsigned/not notarized yet — Gatekeeper will
flag it "unidentified developer" until an Apple Developer ID cert is provisioned.

## Version bumps

`.github/workflows/autobump.yml` runs daily (and on demand, and when the file changes) and opens a
PR when the main txtodo repo's latest GitHub release is newer than the formula. It does **not** use
`brew bump`: that cannot rewrite this formula (its urls sit inside `on_macos`/`on_linux` and
`on_arm`/`on_intel`, next to two `resource` blocks, and it fails with "Could not find 'url'
stanza!"). Instead it:

1. downloads the release's macOS and static Linux (musl) binaries and the `.dmg`s,
2. verifies every asset's Sigstore signature against that tag's own `release.yml` run,
3. stamps them in with `bin/update-formula.sh <tag> <assets-dir>` and `bin/update-cask.sh <tag>
   <assets-dir>` (the same scripts work by hand against a local directory of downloaded assets),
4. checks that all 12 formula url/sha256 pairs and both cask ones moved, and that the cask's `app`
   is inside each `.dmg`,
5. opens the PR from `bump/<tag>`.

The PR it opens does not run `tests.yml` (a workflow started by the default `GITHUB_TOKEN` does not
start other workflows); pushing any commit to its branch does, and that runs the full formula test on
macOS and Linux. The scripts' source of truth is
https://github.com/aaronmyatt/txtodo/tree/main/deploy/homebrew; the copies here differ only in
the path to `Formula/`/`Casks/`. Full design and history:
https://github.com/aaronmyatt/txtodo/blob/main/tasks/brew-distribution/notes.md

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
