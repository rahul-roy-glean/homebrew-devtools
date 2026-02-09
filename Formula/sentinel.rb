class Sentinel < Formula
  desc "Local-first developer control plane: PR stacking, unified status, AI chat"
  homepage "https://github.com/rahul-roy-glean/sentinel"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-aarch64-apple-darwin.tar.gz"
      sha256 "b888b39a726a70b16ea04ca676d43dd545dbd633ff6afd746b21e409062a6b24"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-x86_64-apple-darwin.tar.gz"
      sha256 "d7c40e7f7036ec4ff2054e9ef2fbf7b3a2fb43fc0ea3732ca8a619206981f9f7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "303cb945f1f2d1b80bdbe56e8b88fb8d37d4e276bbe92d6dd89aa7b6b24037fd"
    else
      url "https://github.com/rahul-roy-glean/sentinel/releases/download/v0.1.0/sentinel-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1afc87d5aae1d28bc874c4636879a4d080389501341ab78c91bd08e1a314ae6"
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
