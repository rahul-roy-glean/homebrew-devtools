class DevCache < Formula
  desc "Developer disk space manager -- monitors and garbage-collects dev caches"
  homepage "https://github.com/rahul-roy-glean/dev-cache"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/rahul-roy-glean/dev-cache/releases/assets/354132288",
          headers: ["Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}", "Accept: application/octet-stream"]
      sha256 "c5ae4cb86476f211905f358bccb10f40085ada1a012e90fdedfb9a7123dea034"
    else
      # TODO: add macOS Intel binary when available
      odie "dev-cache is not yet available for macOS Intel"
    end
  end

  on_linux do
    # TODO: add Linux binaries when available
    odie "dev-cache is not yet available for Linux"
  end

  def install
    bin.install "dev-cache"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dev-cache --version")
  end
end
