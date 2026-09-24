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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-macos-aarch64"
      sha256 "a2f3fd7bec6aded58c9597cfb769303cd71a464cdf371032b38e82c699aa6bf3"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodod-macos-aarch64"
        sha256 "8400d291e58a8ae56e0f4e880f40cbbd502ce256cb311c5deb6768934bf7235c"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-tui-macos-aarch64"
        sha256 "bb8cf4e3b33f92bf7ac6f3c459ac6aef17ebe58bc1aaa70d284824c255fa62a0"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-macos-x86_64"
      sha256 "70fb73ebafa2afa83ffb64cbf11b9e7e37cddaef6f38da1c5818f7a1eaad3b71"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodod-macos-x86_64"
        sha256 "5a589920a411b3dcebf837cb99f7f44db741744add2ffb8a0239a8fc8befa71d"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-tui-macos-x86_64"
        sha256 "d3d7dc2d45a60d6adce528418bde2cf31bbb9a41ed6a24161bbc870fc2f8abdc"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-linux-aarch64-musl"
      sha256 "5456a714229422ddcc83f18533bf8aeda816d7c387c111dde541205bb6d22421"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodod-linux-aarch64-musl"
        sha256 "7ce65df146dc51610040bfaad54338cd52f268970dc7d62b39b452997af5a117"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-tui-linux-aarch64-musl"
        sha256 "aaaf4becda8199a2ffcfd5f472eddfc238a3b51ca1ac6433f95304747f7021f6"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-linux-x86_64-musl"
      sha256 "0fbc6565d254cf01ab46ac836671cc379b303ccd0d7e959029ecf789b2c3891a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodod-linux-x86_64-musl"
        sha256 "02f9dec132a7dc54b6aa3fc6c28c43d6f9b6ea428b4f428d4d6b080f79085fab"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.10/txtodo-tui-linux-x86_64-musl"
        sha256 "0effbcc3b7628d09ae04915bfd9b2a0b8250cc352f9fbb78678b87d338953a50"
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
