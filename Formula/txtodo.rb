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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-macos-aarch64"
      sha256 "9a9a7f9368d98112038607dbccc6b45071d76fe6721fa36b7e4976a5fccedd7a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodod-macos-aarch64"
        sha256 "cc472a25ae261849ab09653cccb86e97793326d5c6385338f08675b6c5f0e277"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-tui-macos-aarch64"
        sha256 "505fbf0bf6bdfb0a2eb7973d5afd01b8ac6094f0e6707fa2b8620e9e34a7049f"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-mcp-macos-aarch64"
        sha256 "a14bb907889113db2ac3e39a60eb0ad70e6ca5f5985f475c55136b19a1bfdb9c"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-macos-x86_64"
      sha256 "df994086667f3569f72096016dad511810dd087a8901c127cb078e175871ea84"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodod-macos-x86_64"
        sha256 "3d0e6132ba6034d4e0013116ef6d5668fb85eaa815f7353829e2a49307afacf4"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-tui-macos-x86_64"
        sha256 "2b62ddf528ec1544c7fba414859f25d6006f4bbb576c602c2bdab28292992ea0"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-mcp-macos-x86_64"
        sha256 "1a030321b592543211f9abf0f8b08c74977373271d72dffc68616ce485a0b38b"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-linux-aarch64-musl"
      sha256 "ffaf5f5e235dc61b622fa7c4d6496a928da8e4a1b3cb2b1be4bffbfd24541e4c"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodod-linux-aarch64-musl"
        sha256 "aaa3155a599faec330a63d43802c52d06117ce12f81177e7505cc067129ef7af"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-tui-linux-aarch64-musl"
        sha256 "7718788200ac2e6d9ba63268c8ae169e153637ab9dd0892f346ee6c1e73c6fa6"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-mcp-linux-aarch64-musl"
        sha256 "40319df1d53a8cae159f2b6c66c12623e137cb6a9099ee7cede4a2d96446403b"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-linux-x86_64-musl"
      sha256 "5b04985c827492b2f20077c498614b98c3e1f499fcaaef7fdd8c3e06d2985210"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodod-linux-x86_64-musl"
        sha256 "2d56c0a8b714606359ea91b62711a50f7fc7c1a60596bd696162e20870519af9"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-tui-linux-x86_64-musl"
        sha256 "8d8d3a91941864ae230e05d877df7e5ff28ae0ad45cb7dee1d9681a05024d863"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.25/txtodo-mcp-linux-x86_64-musl"
        sha256 "d25a2c6d26a630cc1231c425ec87347aed489309763d78f4561ace5372670ac7"
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
