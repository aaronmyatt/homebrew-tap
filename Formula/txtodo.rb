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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-macos-aarch64"
      sha256 "51da1a7aed59d851fa95fe2d79afcb5edb2857f5f3142d173e2d20df242b4f84"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodod-macos-aarch64"
        sha256 "d135c5bc8c580c137be5426f7114754bdb443e14b36702050e0db1fbeae8bb61"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-tui-macos-aarch64"
        sha256 "95f9e9776912a6399fa8f64a99200fb12395b153986a9eb86ab2149d31521574"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-mcp-macos-aarch64"
        sha256 "b2fba0b7692fbad0f86a232f87fd301be5d9375c79c7412728205c044340c05d"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-macos-x86_64"
      sha256 "3d61e7b7f444ef1ab0f4600bea2a5eec7cc7b0a00468974d45dfd0581420e48f"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodod-macos-x86_64"
        sha256 "9e8ae2fabf02375feba175bdd24150f5c6c75cdd68f20465ded3c8afed7af004"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-tui-macos-x86_64"
        sha256 "b75d6c2fe470c51929b22fecf00e94222a1fefe3d5168a85f91023e33eb17197"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-mcp-macos-x86_64"
        sha256 "d8e48931f424274436b27af00fccac7da344b8125054b18311e91a3c87206f7e"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-linux-aarch64-musl"
      sha256 "a2c5b1397714d7cd2bf4f2d58f6becdd10462a1f099b3805bf048628177a9d13"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodod-linux-aarch64-musl"
        sha256 "8106758bfa1a64ff80435ea99d7eed86367cfe30bcf8348a19a4e4243093106f"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-tui-linux-aarch64-musl"
        sha256 "c6b52ec12b30f46b910254ef060c796eb741c464673896dd5f428d996340d784"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-mcp-linux-aarch64-musl"
        sha256 "9090377dd9123fff93f4ea1556eb7446e6ca06a36aae321c49321c86b836adfa"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-linux-x86_64-musl"
      sha256 "fa9553163af5f7a53486c38d9975ae96df204b26a37c59d6d56621eba96d2713"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodod-linux-x86_64-musl"
        sha256 "b79d9505782384ac086269fe249f68a5f24d4be11228db08d8b19a135e5fa8b6"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-tui-linux-x86_64-musl"
        sha256 "65c94bc7f5c61b73982ca7af93e8665ffc0bfc57781b726767069c12677e4a9c"
      end
      resource "txtodo-mcp" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.14/txtodo-mcp-linux-x86_64-musl"
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
