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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-macos-aarch64"
      sha256 "d71916f184f9fd7117a13313fbc9fc6770a07e1c2a895d0119fa0c079c7a9c82"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodod-macos-aarch64"
        sha256 "6d19f940daa94b23077e1c5eff82315db26900c9b4394cf04b6d5616b414c934"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-tui-macos-aarch64"
        sha256 "7d8e50bde13f5c294f4da022c6e2b1c99264362a16828abc2a7aac5a68d1a5ac"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-mcp-macos-aarch64"
        sha256 "99612cd4009baf1a5facbf55de5cd3e8a4dd4708951d153a94116d3820e38a6a"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-macos-x86_64"
      sha256 "d9565fffb6d46690d4d9758494f4b4e9792333324101cb05c2fc72c2e0e1b3c5"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodod-macos-x86_64"
        sha256 "66be6ceee4db6509d450d3438f1dcc2f038f7276c22b41fba0c5a11f0e906f76"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-tui-macos-x86_64"
        sha256 "7c5cd373727cbafd464c9310cf32148f0a3d04b3dcbf0152ed813529b76654bd"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-mcp-macos-x86_64"
        sha256 "b444c22c7257fc242430dfaac5d435557d847039138e982fb5395ab5f35c76e4"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-linux-aarch64-musl"
      sha256 "a07782b67720132151de983346a61d8d7f1348dcc3026f2097b92e146c76c696"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodod-linux-aarch64-musl"
        sha256 "841902e7e252f48a14888fb78ca14e8d8f4f0ae33a2f09c3264fe1659bf42d5f"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-tui-linux-aarch64-musl"
        sha256 "d53cf88ada64c836509c85d0d87a4ecab0c544d87041d87f536d030dff88e09a"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-mcp-linux-aarch64-musl"
        sha256 "bc3dfaf088d4a62831882ffa48b25cb0d2a4fea572434c1271a349f8a4e50901"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-linux-x86_64-musl"
      sha256 "1c20f130e96befc4c229fbedb8ffc0c8cf518d9758c53aa4c056bf791ee5de08"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodod-linux-x86_64-musl"
        sha256 "061d4c141cd1a37ca182814d80c07777d8aaef38e7e560c7ca75cc2fc064ecce"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-tui-linux-x86_64-musl"
        sha256 "7528e94a171df364d6b82b11e68e41bb21d263b8eede15cb316e0beba4d832d6"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.21/txtodo-mcp-linux-x86_64-musl"
        sha256 "ffc06ce9c83b16427d134745ab2bb5d2595603cecd7a325656db4fa9db906bf5"
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
