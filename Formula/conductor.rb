class Conductor < Formula
  desc "Orchestrate multiple Claude Code agents from a chat-first workspace"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/358360067",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "4064dcc9a3ab2a3d6516b8701c62567ab2f84cdfdf97854d538e4b01e1dc557b"
    else
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/358360065",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "1c45bcdf81ac7e92b60280fffe54ca217f610d0f5d4d74aace583b374081750f"
    end
  end

  on_linux do
    url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/358360066",
        headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
    sha256 "3d5a32dc694ea036711b6219aeee99ca69891fbd42816e8151be273a6272aa03"
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
