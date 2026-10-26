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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-macos-aarch64"
      sha256 "b45280c3d73c669e8ab9783a0bdbd0f459c5a2808dbaf3922964b8fe51a7bb3c"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodod-macos-aarch64"
        sha256 "01edfbd93126858882979fee320be470815ebf39e43fbc83815fd3a8aa919962"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-tui-macos-aarch64"
        sha256 "7ce3f24f0a6517fe3abecda2dfe8853e8aaae9679288612b857df410b700bc83"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-mcp-macos-aarch64"
        sha256 "9275f5060813ac02a6da73b54ef87894407101d4e7b3161f3bbe196f4ccc7e70"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-macos-x86_64"
      sha256 "101658940e10cc402338605fcd0c010b97f630dcc4221c1750ea580405d7b5f1"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodod-macos-x86_64"
        sha256 "94917282ef6b90690baa2ca8bb5c2ee4fa48b18c62136722947be8411c3e58a8"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-tui-macos-x86_64"
        sha256 "2f939f2f2b6e382b7e7c10ff6e1145cf37cfb2de64e5211a0a6fc7727ded6fec"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-mcp-macos-x86_64"
        sha256 "28d97072316aed983ea9f2afe5ae645846e160967fd9074791c8aaabfd4f66b4"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-linux-aarch64-musl"
      sha256 "844bdad182299991fbdf6d2e7d6880478bf464ddc87e0dc0f3fc41783bc242a0"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodod-linux-aarch64-musl"
        sha256 "290d1ee6df763ed130b023c51542776fa47c69e749240815069e47eec3030c44"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-tui-linux-aarch64-musl"
        sha256 "69e14fd38826599ca657910dbd100fc3ae0ef0e4d8ee097e1496c9bf04e4a39c"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-mcp-linux-aarch64-musl"
        sha256 "8b966fc8fd295fc05042f140dee3b419f854d24927cecb90227ca4a1e0349b93"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-linux-x86_64-musl"
      sha256 "00cd68a6717809787476b32335f18941a335f3d3b295d755d25a0cd1eeb5d87f"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodod-linux-x86_64-musl"
        sha256 "1ed31d0df4e69bedf740d5e9456000f28f887eefc65f1277fbfb3f2a5a289b4c"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-tui-linux-x86_64-musl"
        sha256 "750f1571fd86a8d0b4aeed9884b6f5b81e112e2c74e1fc5522e8287cf9e8ca8f"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.27/txtodo-mcp-linux-x86_64-musl"
        sha256 "c8da463c77c023aea200a908e8ecf3aa16f145ef2a9893a4154ecc4ab711e2f4"
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
