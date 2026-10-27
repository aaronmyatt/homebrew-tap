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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-macos-aarch64"
      sha256 "27572aa3791814cd2dc4cdee9726d0319dd9eabfe7ef73276c9a44fedec5cd6a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodod-macos-aarch64"
        sha256 "9ffe397754fcd58aba8e243d04c950c444a6d2d86f5e610df16b827de62c4728"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-tui-macos-aarch64"
        sha256 "6db8da86124d5e01cc99c9edff3d0f53bb4039f1b3eed70d0fa819ca71cd70ba"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-mcp-macos-aarch64"
        sha256 "cba295e0d911ad0f87f3ae21d473f48b6cc6ddf26eb1d8d76eda89be9a118d45"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-macos-x86_64"
      sha256 "e536cdedc5884dae5e917765b910e32630a35d0a007e600bc34c52058454966e"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodod-macos-x86_64"
        sha256 "5b7bf0a6fe2070bc99ea5de98fe57ea59ba3e7f0c2d67988fad310eff78a8e52"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-tui-macos-x86_64"
        sha256 "4cbd3307a0084469145b66d8e3c323af4d1d8ba6017bc1ed39ec81f106a0a77f"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-mcp-macos-x86_64"
        sha256 "7ed7021fdf8917ae246a06593942909ac2acd16561473269a480b02b65b49ade"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-linux-aarch64-musl"
      sha256 "dec526cff47e48825a5aac17bb019a734ddbdbac89ed26484699ff022f4d322a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodod-linux-aarch64-musl"
        sha256 "1b32de8fcb5f509c5f8962a8552fb6ff4404a505cfad83134c82128010b1d2b2"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-tui-linux-aarch64-musl"
        sha256 "233126ccab16dac4c963461d460d3a27910fd3d153b70760a001f07541cd5121"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-mcp-linux-aarch64-musl"
        sha256 "d60043f777a1a4c20f8725f8e2bf0114c7a9441ba01247f0cc58be413c6d60af"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-linux-x86_64-musl"
      sha256 "d51389614ac8ae966c7f92b500ef60fa32fea5ed02a4c4af51c53ef48c938f09"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodod-linux-x86_64-musl"
        sha256 "2a4b9e73033651637073e0e4dd7742ecfb2e7c3119acdc5ad8695def507d1b36"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-tui-linux-x86_64-musl"
        sha256 "34438bedfa3d2f7288d0a28b8c418fa4e0e599fdbd2922dbf2e9e297c6dd80f2"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.28/txtodo-mcp-linux-x86_64-musl"
        sha256 "f15d6debbced0870382dd468eaa0e75a556f11ff74b227cdacf55ca3c40bdfe0"
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
