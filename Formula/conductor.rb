class Conductor < Formula
  desc "Local-first orchestration system for managing multiple Claude Code agents"
  homepage "https://github.com/rahul-roy-glean/conductor"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356904163",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "eaf57d408e763e375130f32785b7f0eabfc85a80d833124f6b2583213ecdd605"
    else
      url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356904164",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "4374b5b616ed9cbbe2cca16b83458f98f35598ee1c1fe3455212013c9c644926"
    end
  end

  on_linux do
    url "https://api.github.com/repos/rahul-roy-glean/conductor/releases/assets/356904165",
        headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
    sha256 "3989dd5f42be094864c191ef9007f9ce6e4056f9e0e7979bbc31b7fdf0a50616"
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
