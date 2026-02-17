class Conductor < Formula
  desc "Local-first orchestration system for managing multiple Claude Code agents"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357444075",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "036c7283a59f3ea617516fdda826c2d9ad50b1ddd1343e0c5aba675a995ca985"
    else
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357444076",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "1825d327bdba51f475f458027b15c1ed86d2d13c6b25881697aa406cdc182764"
    end
  end

  on_linux do
    url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357444080",
        headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
    sha256 "ba13e875c9fd0298ec1cc4eda0f53d212addf8be12c9b5af117d32a4a723e967"
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
    environment_variables PATH: std_service_path_env,
                          HOME: Dir.home
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
