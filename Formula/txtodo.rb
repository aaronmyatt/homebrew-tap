# txtodo.rb — staged for the aaronmyatt/homebrew-tap repo (task brew-distribution; see
# tasks/brew-distribution/notes.md for why the tap is aaronmyatt/homebrew-tap, not the root
# backlog line's original txtodo/homebrew-tap guess — there is no txtodo GitHub org). Every `url`
# and `sha256` below are stamped for real by `deploy/homebrew/update-formula.sh` against a real
# release's real assets, currently v0.0.14 — all 16 binaries' cosign sigstore signatures were
# verified against release.yml's own OIDC identity
# (https://github.com/aaronmyatt/txtodo/.github/workflows/release.yml@refs/tags/v0.0.14, issuer
# https://token.actions.githubusercontent.com) before stamping, and every stamped hash was
# re-checked against its own asset afterwards (2026-09-27).
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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-macos-aarch64"
      sha256 "740086cda88c071350b2f32081388292476f8f439e17aa23943ecf7f2a3cf301"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodod-macos-aarch64"
        sha256 "a705dc4b7be416b3bf6d2b42347ae19308392593f23b53d618faff1d63f3d461"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-tui-macos-aarch64"
        sha256 "f0f9273969a23ccfd1998ff1a22cbdbc52b902199a1c010cd5041dcfb8fb24f6"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-mcp-macos-aarch64"
        sha256 "b2fba0b7692fbad0f86a232f87fd301be5d9375c79c7412728205c044340c05d"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-macos-x86_64"
      sha256 "7d27d3d99645fa5eb4db16a7d74e5347e58f95b5c9f7d5b216d6cbf8841edb68"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodod-macos-x86_64"
        sha256 "2dc243f00769c289a85f41e4f7b241c11273cbdfeb2ef3de332bfdbe16092b27"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-tui-macos-x86_64"
        sha256 "8adb69dbc6c4926d4d939b7945bb22f5dccf658614562d195d0568179eed674e"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-mcp-macos-x86_64"
        sha256 "d8e48931f424274436b27af00fccac7da344b8125054b18311e91a3c87206f7e"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-linux-aarch64-musl"
      sha256 "f4e3d459c8b2f7b2dbbe7ced789adb1c459049d794e0423b71a9a852d23dbb24"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodod-linux-aarch64-musl"
        sha256 "f0cb48f42d2a3db81026845557395cb292aed9b6f160fd6f53633a9a62b4c6b3"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-tui-linux-aarch64-musl"
        sha256 "998fe7101f695d3da3fbdf286b858ccaefada261d86236fcfd95c3a29c4cb06c"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-mcp-linux-aarch64-musl"
        sha256 "9090377dd9123fff93f4ea1556eb7446e6ca06a36aae321c49321c86b836adfa"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-linux-x86_64-musl"
      sha256 "5bf41ccb768716b4ca3b798c0428b5633557dc6910c496c32e3c172135aff2c7"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodod-linux-x86_64-musl"
        sha256 "54da85502d4080c9d27117da1b08ba811fe42fe7a6a153064d80221f0134ac43"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-tui-linux-x86_64-musl"
        sha256 "744ba654254bc8518c07db3295ee1abbcf08b496df33fdc1b1f7f0f6077a09e7"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.15/txtodo-mcp-linux-x86_64-musl"
        sha256 "8e3c13bea93a432cd22a4861848760fda6063c7c1e27a52951c2011029429384"
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
