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
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-macos-aarch64"
      sha256 "c47fed037b8cdfe7b5be3cc967e206e1b6d282af8d7af49ea84156013bea9649"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodod-macos-aarch64"
        sha256 "bef8d510bd49a289e53ba7b3171f2d0b9832700d0193c160b12166647c9b9455"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-tui-macos-aarch64"
        sha256 "d4bc4fe78e68e80415b276c529b7d0216aa5e2813db480786fd36bcb28d668e3"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-macos-x86_64"
      sha256 "1b5121bd8ca30b270ec3776c81b28b820b6435e43038d9b00a34def7ed498f18"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodod-macos-x86_64"
        sha256 "e59efe7c153addddd872b891d8c1da8014d98f0cdd93b9bf48112274f981809e"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-tui-macos-x86_64"
        sha256 "6355698ccf2a618462c3617bdadc02a65705e81e8eee707f684c841b0c612148"
      end
    end
  end

  # Linux ships the fully static musl builds: no libc dependency, so one binary works on any
  # distro Homebrew supports. The glibc build (txtodo-linux-x86_64-gnu) is deliberately not used.
  on_linux do
    on_arm do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-linux-aarch64-musl"
      sha256 "4834fa2e24528497416b1aaa4a983b36a63f90e67d07e8853b17141ad47f580b"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodod-linux-aarch64-musl"
        sha256 "3c4f9b8cba26a82b93da529c6c8a35abd3a5cfb82733fae4fcf4e1f681f85aca"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-tui-linux-aarch64-musl"
        sha256 "a851ee212e94d00e61ff0c1e59996a0f1545f72fce3bfe4cc67eafb15055b161"
      end
    end
    on_intel do
      url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-linux-x86_64-musl"
      sha256 "ff69346c9b863138a83c2e2fe67ce63ea04cfa8cfcac720773ab22256c2f4270"
      resource "txtodod" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodod-linux-x86_64-musl"
        sha256 "b83c0aebf9e965e770601b2aae1ed857d04e2b1858aa3c087c2da222efb9ca58"
      end
      resource "txtodo-tui" do
        url "https://github.com/aaronmyatt/txtodo/releases/download/v0.0.8/txtodo-tui-linux-x86_64-musl"
        sha256 "e6d4074c90292c19e218d95b8f0e65327004dfe5409cdfd6cf6c074f29d6178e"
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
