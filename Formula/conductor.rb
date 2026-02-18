class Conductor < Formula
  desc "Local-first orchestration system for managing multiple Claude Code agents"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357750906",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "8ef7945d5b2d781d301235d8c7edf86c45faba18d2482f4b97380e48bce3ebbf"
    else
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357750905",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "453481b484ca118f70b029d841d5fdd779aa278a9e81c3a4adf84cddfe541263"
    end
  end

  on_linux do
    url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/357750907",
        headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
    sha256 "1af016f1503ca94767da513b9885cb91c296f7af31b6bfffc60960ca8c78c5b6"
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
