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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-macos-aarch64"
      sha256 "983bfc54222637143b3bd2f63cfa706e601a46a15308bd0baf156c885b9f033e"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodod-macos-aarch64"
        sha256 "0f560a68994dd8e23fa09d5e90770ada967fb4a849b4d81332f87da806e141d3"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-tui-macos-aarch64"
        sha256 "85c27804d03c10333a62a4d2ee7aceda7b22c9f10669e411f8e60ba5fdcecce2"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-mcp-macos-aarch64"
        sha256 "c5e0f4c1da093364dd201700789909c2795c8055036d3c16a483db48af28b0c1"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-macos-x86_64"
      sha256 "c23d3962849d865dc9f2db4f97046c2ad87f87689b453bae8cacde8318283dc8"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodod-macos-x86_64"
        sha256 "7d9ca6176cb40d833a463394bcefcc8b52ae61d3fb691bf4933622aa143f0b08"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-tui-macos-x86_64"
        sha256 "2ade76b240158ccf4b25309dddcc352c65bdd7a47b5eb006a9ee743ee2299d79"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-mcp-macos-x86_64"
        sha256 "1f3da81499ff542bed9269804cc613ad3b24b9cf15189d5b6b8f924fab0591b8"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-linux-aarch64-musl"
      sha256 "8ac3d192e0cad0f93ea306970eb1c5a6d1216fe791764552cd5f850b770e8c3a"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodod-linux-aarch64-musl"
        sha256 "6fa2b5fb44dd817227ed70de8edb7916273d75180d5ffe1f754580072064d1f6"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-tui-linux-aarch64-musl"
        sha256 "a7631c388f97e29159a5655d20494562c3ddc63e2fe5b0b335b311e81a9d80d5"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-mcp-linux-aarch64-musl"
        sha256 "f2b17624f6bfcc455653f4c901c400f81258b03f8415cb417c002bfd1f6eb958"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-linux-x86_64-musl"
      sha256 "aa7fbde9448e27bb7669c708a8d7377642b112783615cd3028e592c66dc8aed0"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodod-linux-x86_64-musl"
        sha256 "751d7a2c28509163916d81717e4b90e1e04b8ba4d7a8fbcfb61ab50f753b3cd5"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-tui-linux-x86_64-musl"
        sha256 "a5da522b55cecc294bec2e13b0767bf423a0cd816269ef5ad946e2f3eb12c405"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.20/txtodo-mcp-linux-x86_64-musl"
        sha256 "83390ccd24db6dd21eb605cfc26b00c8f437fa5f07ef4af9fa94c49478625010"
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
