class Sentinel < Formula
  desc "Local-first developer control plane: PR stacking, unified status, AI chat"
  homepage "https://github.com/rahul-roy-glean/sentinel"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-aarch64-apple-darwin.tar.gz"
      sha256 "f678a0ff18385ef9959804f46d1d0153e9271bb097f463b9ac61cc4502a74142"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-x86_64-apple-darwin.tar.gz"
      sha256 "ebf2f9cbb63b1743be76040a0fc4f09b3f28054f624e81012dfad6ddb9db0f6a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d774eece94a4faf977e2f721cdd60bd3d6d07eb2ab776b57aa7a562cb5fe1f9"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9a62759c852a46b7bc1a3a42b3ef299dbeac71b09d0f9c5a3a53dab764ae8841"
    end
  end

  depends_on "gh"

  def install
    bin.install "sentinel"
  end

  def caveats
    <<~EOS
      To get started:
        sentinel doctor        # Check prerequisites
        sentinel status        # View repo status

      The background daemon improves performance:
        sentinel daemon start  # Start the daemon

      GitHub features require authentication:
        gh auth login
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sentinel --version")
  end
end
