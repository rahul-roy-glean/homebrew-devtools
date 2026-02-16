class Conductor < Formula
  desc "Local-first orchestration system for managing multiple Claude Code agents"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356911577",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "162e74e90aa5608fb9648291207480bb41777d9057b4ffa668eda1af85c991c0"
    else
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356911576",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "8e2f4e61ea7e94795b8aa3a7c48ea14e9f9419322c2b40a86ce7996ce21f1432"
    end
  end

  on_linux do
    url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356911578",
        headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
    sha256 "7eb4f8df09321c6c79698bc9bd515e4bcb6d41f7719d739f5656327b66e8cbc6"
  end

  def install
    bin.install "conductor"
    (var/"conductor").mkpath
    (var/"log").mkpath
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

      For private repo access, set:
        export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/conductor --version")
  end
end
