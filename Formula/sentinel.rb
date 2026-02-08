class Sentinel < Formula
  desc "Local-first developer control plane: PR stacking, unified status, AI chat"
  homepage "https://github.com/rahul-roy-glean/sentinel"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v#{version}/sentinel-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v#{version}/sentinel-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v#{version}/sentinel-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v#{version}/sentinel-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  depends_on "gh"

  def install
    bin.install "sentinel"
    bin.install "sentinel-daemon"
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
