# txtodo.rb — staged for the aaronmyatt/homebrew-tap repo (task brew-distribution; see
# tasks/brew-distribution/notes.md for why the tap is aaronmyatt/homebrew-tap, not the root
# backlog line's original txtodo/homebrew-tap guess — there is no txtodo GitHub org). Every `url`
# and `sha256` below are stamped for real by `deploy/homebrew/update-formula.sh` against a real
# release's real assets, currently v0.0.2 — each binary's cosign sigstore signature was verified
# against release.yml's own OIDC identity before stamping (2026-09-18).
#
# Ships all three release binaries (RELEASE_CI.patch.md's macos-{aarch64,x86_64} and static
# linux-{aarch64,x86_64}-musl legs):
# `txtodo` (the CLI, todo.sh-compatible commands), `txtodod` (the sync daemon) and `txtodo-tui`
# (the ratatui client) — matching what a real release actually publishes, not just the CLI alone.
#
# Homebrew formula cookbook: https://docs.brew.sh/Formula-Cookbook
# on_macos/on_arm/on_intel DSL: https://rubydoc.brew.sh/Formula.html
class Txtodo < Formula
  desc "Todo.sh-compatible CLI with real-time, end-to-end-encrypted multi-device sync"
  homepage "https://github.com/aaronmyatt/txtodo"
  license any_of: ["MIT", "Apache-2.0"]
  # No explicit `version`: Homebrew infers it from each `url`'s own `/v<version>/` path segment
  # (`brew audit` flags an explicit one matching the URL as redundant) — update-formula.sh only
  # ever needs to rewrite urls/sha256s, never a separate version field.

  on_macos do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-macos-aarch64"
      sha256 "b00003c06b06f0d4130e8a5ecbc5ed0ef1f0cb8e27dad9ac75a2c0ba8e5b4a16"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodod-macos-aarch64"
        sha256 "17b3fff3cf95cd194101f0cfb8d813ea303b247ab23bd85498f0879823e10727"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-tui-macos-aarch64"
        sha256 "8762dde1e8bc67d3aaf04f0e0658b90fdee1f4012067bee54a99150a0875d24a"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-macos-x86_64"
      sha256 "3372cc7ac832f6e838c590f2ff5b9ec9de1bf2614964118a793ea848d5c1e4f7"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodod-macos-x86_64"
        sha256 "717de92946e8e1dfeb948d2fd8fc7752c286779eea997c58d71b95ac4e82372e"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-tui-macos-x86_64"
        sha256 "47ad8f6654829e4d884c82795b0a599028976cb353cfc09893c5cd452500f41d"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-linux-aarch64-musl"
      sha256 "a4a9ce94788246121dbec06baa7b97b3019ae41532ab24ee5df2b475da57cc2a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodod-linux-aarch64-musl"
        sha256 "e603bf59a9fb65c2a3ebca83c28bd7e1ace885b7bff6c698e1d650f2dc7163c7"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-tui-linux-aarch64-musl"
        sha256 "c45c5278bbe00e2acc271c7fbf5e31e480e770f2f3301522b83b2f7b9f661a0e"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-linux-x86_64-musl"
      sha256 "cfa505bac946a8ed67b746e34880c5615b91d380a0bc5eeb1921abc814f441a3"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodod-linux-x86_64-musl"
        sha256 "50b0718d9d2ce358aecee57eefcc1a2fe2d7725ea6dc110bd3df6b20e94cfd22"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.4/txtodo-tui-linux-x86_64-musl"
        sha256 "47dd4230b5448aa46beb439232a1533fba3c6132619cf6a8907e732899f2a5f9"
      end
    end
  end

  # Every asset is a bare downloaded binary, not an archive — Homebrew stages the primary `url`
  # download under its own URL-derived basename (e.g. "txtodo-macos-aarch64"), and each `resource`
  # under `resource_name` (its own default staging name); GitHub Release assets carry no unix
  # executable bit over HTTP, so every binary needs an explicit `chmod` before `bin.install`.
  def install
    cli = Dir["txtodo-*"].first
    chmod 0755, cli
    bin.install cli => "txtodo"

    resource("txtodod").stage do
      daemon = Dir["txtodod-*"].first
      chmod 0755, daemon
      bin.install daemon => "txtodod"
    end

    resource("txtodo-tui").stage do
      tui = Dir["txtodo-tui-*"].first
      chmod 0755, tui
      bin.install tui => "txtodo-tui"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/txtodo --version")
    assert_match version.to_s, shell_output("#{bin}/txtodod --version")
  end
end
