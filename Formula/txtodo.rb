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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-macos-aarch64"
      sha256 "0fa03052e9ea87bddda25567734fffd1abd5a5063a0d431270d5b33cb473d748"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodod-macos-aarch64"
        sha256 "3892331aaa81092386393c4c28d9ca5db8d50415e20c32c76702cf53af255a16"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-tui-macos-aarch64"
        sha256 "2abe120c03f682b06d268579187fc2202769ef2b6639962983850883cb1a744c"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-macos-x86_64"
      sha256 "fda62ff984e71f1f53b68286bfbcb0c663856212f2f11af85783c1dafec774b1"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodod-macos-x86_64"
        sha256 "11a30eb45a15c8d0685e29a0f6fcf3e622b6b61c13a6c4ca573e5b736cfa0687"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-tui-macos-x86_64"
        sha256 "375ebea847a0ff5d38235a179d6d2686b4415bd989fda4b478dac1246249b7a2"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-linux-aarch64-musl"
      sha256 "6c824fcfa5c465f1d2b14ff4a14459792331b53b938f87881ba77e12c9abb844"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodod-linux-aarch64-musl"
        sha256 "59bd7378740eea8b5e0dbfa68d0ba1ebd1d2961bfaf304306660af6e84fd1d31"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-tui-linux-aarch64-musl"
        sha256 "fa83c1ef1069f15fbd1e0d1f594fd72f54d03d00d0f80397d76622ec4443a297"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-linux-x86_64-musl"
      sha256 "304b8a8b4d1f35481283e9ff6bddaeff84d140d5448f1a1e0b559141c27624f7"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodod-linux-x86_64-musl"
        sha256 "d1aa79fa855115107a88d6f3b2fb73627457f49e33c59fef6d9d573df0972880"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.5/txtodo-tui-linux-x86_64-musl"
        sha256 "b17ec17941ff1d7dc8c453ef2f3320b8874703b3e09d7c43c451fd8ae89f3ca9"
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
