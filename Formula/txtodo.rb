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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-macos-aarch64"
      sha256 "d3dbad5c27f0216527c0fc01bde2d29fa87543f4b96e70113d6471f716797503"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodod-macos-aarch64"
        sha256 "4b520687c8cab8bd5b68cd625d9436ccc9987331fd4b9adbf6e18a6da07848d3"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-tui-macos-aarch64"
        sha256 "c3b40cdc66d49e0223c98836e90674bca7b93e0748c9d0c5385c17c9e080c317"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-macos-x86_64"
      sha256 "d132ac510e8b75c1bc219d71573d1dcdc157ee2716cc70e7094d693f94aac667"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodod-macos-x86_64"
        sha256 "af7c2472ef5d651d792716b45bdbdad38f214578ad245cc0a9b1d49f8f2c1b95"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-tui-macos-x86_64"
        sha256 "db5df553c326055bab2a0fee93ccf7a84097409cc756daddb29b49c9a92f0890"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-linux-aarch64-musl"
      sha256 "86f68e6c0b153093305d055361a19ab32312c4317bee79ed727e2b3194422918"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodod-linux-aarch64-musl"
        sha256 "6343bb2f29762dd534d038ef1365f2ce0c33a3cb7637bf86a18c036618ee64ef"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-tui-linux-aarch64-musl"
        sha256 "f4c002c4331ad426d3a13478965f57d443de990bc4f2aae474af5a89d3163465"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-linux-x86_64-musl"
      sha256 "45b567d3cd180af5778f22b8b60880e3d203cb2fd69afbf73f4889640fef91d5"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodod-linux-x86_64-musl"
        sha256 "ffc7b57f4b77c05aa9545ee8469a4432f3f61b6f87f22d4f00a36e44bc2b82c2"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.6/txtodo-tui-linux-x86_64-musl"
        sha256 "ffa627b5f46bd31dc6e74d2b8e47006edbe027b328e563f510e8325c4c80a92b"
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
