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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-macos-aarch64"
      sha256 "1d387fdaaebd2394413b262cf135d160b97e6a7e83a0ef9a457681a1c9d42d31"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodod-macos-aarch64"
        sha256 "2677338aa29fe2399f829d234639c16550e971fbc846ba6fe12119fa8875ea3e"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-tui-macos-aarch64"
        sha256 "8ee8ed9daf828c5894810b1d4411bdb541192f2a79a8c59b9fae29ef9f5a7cba"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-macos-x86_64"
      sha256 "c3a9c10eb6ce12bfe5534df97bedbef27035643aeb032d76c3ce4e5fb86c2582"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodod-macos-x86_64"
        sha256 "ec5529c5c4a713b92656378ff192490b3246ff1672fa47f1cac9a69c2cd99625"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-tui-macos-x86_64"
        sha256 "2284005ecc6301d80b2f8b188ea219de5e310c9b5ffa1feef4f634d97ffab666"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-linux-aarch64-musl"
      sha256 "bf12396eabf413cb9052bddd21d25da53b44585057758fe74cdcb8f679206087"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodod-linux-aarch64-musl"
        sha256 "c9b3e82293c23bfa35be5cb37ad9422d7c500bdc5be5d007807e7501b2c8f978"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-tui-linux-aarch64-musl"
        sha256 "73f9542c671b496fa992441a65e6a5c69eb4225bf6d2c4f4fe28e156c230fafe"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-linux-x86_64-musl"
      sha256 "601b9b4e0d3f3facf3efb9ef9ddb23c9e52bbcd684403edb70e69c7f316dc32a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodod-linux-x86_64-musl"
        sha256 "cfa0a1ea8f64ecaf3e4ea448c5f4ad794fb624a72d6fdfbe31a6b2190ace3b32"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.3/txtodo-tui-linux-x86_64-musl"
        sha256 "768cab89b1838f0cc8565d83fe325290015da072abcaa8be45b42a5e22de1532"
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
