# txtodo.rb — staged for the aaronmyatt/homebrew-tap repo (task brew-distribution; see
# tasks/brew-distribution/notes.md for why the tap is aaronmyatt/homebrew-tap, not the root
# backlog line's original txtodo/homebrew-tap guess — there is no txtodo GitHub org). Every `url`
# and `sha256` below are stamped for real by `deploy/homebrew/update-formula.sh` against a real
# release's real assets, currently v0.0.19 — all 16 binaries' cosign sigstore signatures were
# verified against release.yml's own OIDC identity
# (https://github.com/aaronmyatt/txtodo/.github/workflows/release.yml@refs/tags/v0.0.19, issuer
# https://token.actions.githubusercontent.com) before stamping, and every stamped hash was
# re-checked against its own asset afterwards (2026-09-29).
#
# Ships all four release binaries (RELEASE_CI.patch.md's macos-{aarch64,x86_64} and static
# linux-{aarch64,x86_64}-musl legs):
# `txtodo` (the CLI, todo.sh-compatible commands), `txtodod` (the sync daemon), `txtodo-tui`
# (the ratatui client) and `txtodo-mcp` (the MCP server `txtodo mcp` runs) — matching what a real
# release actually publishes, not just the CLI alone.
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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-macos-aarch64"
      sha256 "c2e545a64e9e0913c9c37659e4ae5271f1a46402080822e8baac211c139faa9b"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodod-macos-aarch64"
        sha256 "79afb6076cd8ebe6b51fb15751430e6976b0e0657400b983d61f57ae6f326451"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-tui-macos-aarch64"
        sha256 "b021d6604a1c5c7c200c84ab38525ef2ea1a1e28570ce7dc4980b159d9f8c3db"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-mcp-macos-aarch64"
        sha256 "9a6c7de9328d02672bb72f5e4e6ed2e04cab2a77e65500b2d516d73e5833cf8b"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-macos-x86_64"
      sha256 "da1955a7b1ae7d5f8d22b9708e3a158edae8687488e092e652f2c456c49250f0"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodod-macos-x86_64"
        sha256 "1ac465c150fd8ff9cb1022920c8e87e1cec7cf2e4ae226188cc8fefb9f9cd614"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-tui-macos-x86_64"
        sha256 "7e5850a140f02b37bf5f7536e2973fc0e695c070fc913d771c5b05094ce5a9f4"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-mcp-macos-x86_64"
        sha256 "5904ae3827a89b3659e9acd5c8c7a4820467c3c38f38b7d5d52f1b912f525258"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-linux-aarch64-musl"
      sha256 "250a2837fe829b4dc6cc1ddb1f86c3cd3755157bb21a76389bbe0f938b44bc76"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodod-linux-aarch64-musl"
        sha256 "f9ead70eecdce778cfa2851dea319542c3609eb6214574f28e2e5fd972eab05c"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-tui-linux-aarch64-musl"
        sha256 "24a13df6839a37a3d5be3afc0d296f8a548ea936cf1bba2c866d956f95140e3c"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-mcp-linux-aarch64-musl"
        sha256 "a82130c025960a1d1e17780bc9a491a55b4ce1aed4d5dfb48c9f7841311dff27"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-linux-x86_64-musl"
      sha256 "513eaa623709bc782079f263dc731850ec9af1b81448128ea868203b63ab3c91"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodod-linux-x86_64-musl"
        sha256 "16fafdbe89836f486a1cae4bfe223e8efc55cc330274d0a67c0ebf50cd9c1b54"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-tui-linux-x86_64-musl"
        sha256 "6e18aa91f56cffd6cdbd51908106a7549d79498a0eda592324bb8ee3571110e6"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.24/txtodo-mcp-linux-x86_64-musl"
        sha256 "d15e331d2b5fd2752ddcb755f63d1ff45ff0684181196f074e1980af7395cc35"
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

    # `txtodo mcp` execs the txtodo-mcp beside txtodo, so it goes in the same bin.
    resource("txtodo-mcp").stage do
      mcp = Dir["txtodo-mcp-*"].first
      chmod 0755, mcp
      bin.install mcp => "txtodo-mcp"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/txtodo --version")
    assert_match version.to_s, shell_output("#{bin}/txtodod --version")
    assert_match version.to_s, shell_output("#{bin}/txtodo-mcp --version")
  end
end
