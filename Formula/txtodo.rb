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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-macos-aarch64"
      sha256 "a873fa65ecc3d58836961cce8dcd7272d4051431c90a8ca5a24284d4d6ffd56b"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodod-macos-aarch64"
        sha256 "d6632135f98c582592bfda931253a8b18eb4ad9c5d5213c38736b495c935c146"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-tui-macos-aarch64"
        sha256 "6bfd20d95dadaaae1b43f987a271f2b8f943f1991f42040b16c5be0680402172"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-macos-x86_64"
      sha256 "84b07231a9134b9e076567cef11b55be6150130bf9508cc57e1b7d2d62ad56ea"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodod-macos-x86_64"
        sha256 "388b8c446f73e4987e9802d144ed35743d75c722366b167d8846456190ec586c"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-tui-macos-x86_64"
        sha256 "4c684a589ca1536ade28bb5995398f3dc775cdef8e5937f6efc190ba048d22eb"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-linux-aarch64-musl"
      sha256 "d692cff58c160db38137b4a18af81e836308f9da1f5f41885addc3be8be6aa12"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodod-linux-aarch64-musl"
        sha256 "1fc39ca58055f8bad61a04e7cb4533bf8693d9bebfea5a88191cfe91b8a97a39"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-tui-linux-aarch64-musl"
        sha256 "7e6415ff98265df9da8ace2129ed16fca83a562feb265ef9363ce9b7b96b9710"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-linux-x86_64-musl"
      sha256 "7daf01db47ff1fafd4e0ccceb781ef9514c128c2b38619900b972076009b9fc8"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodod-linux-x86_64-musl"
        sha256 "800601e84e64523b6457961abcf9d98583cd5936565f1942f255012cd34b2e36"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.7/txtodo-tui-linux-x86_64-musl"
        sha256 "eed74abc7b9fdddf1a414ea6ef26c385d3fc41a4a6aaaff70610e25dda5450ad"
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
