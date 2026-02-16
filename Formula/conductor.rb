class Conductor < Formula
  desc "Local-first orchestration system for managing multiple Claude Code agents"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rahul-roy-glean/conductor/releases/download/v#{version}/conductor-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/rahul-roy-glean/conductor/releases/download/v#{version}/conductor-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    url "https://github.com/rahul-roy-glean/conductor/releases/download/v#{version}/conductor-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER"
  end

  def install
    bin.install "conductor"
  end

  service do
    run [opt_bin/"conductor", "server"]
    keep_alive true
    log_path var/"log/conductor.log"
    error_log_path var/"log/conductor-error.log"
    working_dir var/"conductor"
  end

  def caveats
    <<~EOS
      To start the conductor server as a background service:
        brew services start conductor

      Or run manually:
        conductor server

      Then open http://localhost:3001 in your browser.

      Requires Claude Code (claude CLI) to be installed:
        npm install -g @anthropic-ai/claude-code
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/conductor --version")
  end
end
