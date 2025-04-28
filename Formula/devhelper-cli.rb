class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  version "0.4.0"
  url "https://github.com/ShieldFC-RD/devhelper-cli.git", tag: "v0.4.0"

  depends_on "gh"

  def binary_name
    if OS.mac?
      Hardware::CPU.arm? ? "devhelper-cli-darwin-arm64" : "devhelper-cli-darwin-amd64"
    elsif OS.linux?
      Hardware::CPU.arm? ? "devhelper-cli-linux-arm64" : "devhelper-cli-linux-amd64"
    end
  end

  def binary_sha256
    sha256s = {
      "devhelper-cli-darwin-arm64" => "76706018bd6a65e1bff43d06966573be1b48cf83bbd2f979b711046b960e9a4a",
      "devhelper-cli-darwin-amd64" => "5fd1cb2fbd1cf2315d0cb09ab2f5176fb090762cc705987b1627ee8177d5cfc1",
      "devhelper-cli-linux-arm64" => "bded17592001da17b0ad424f78ef0478c9f394b617bc25afe8ac61301d563bb9",
      "devhelper-cli-linux-amd64" => "f835e01be52474f16186c156563345b383d816e890ead1ed43ea30e51f622329"
    }
    sha256s[binary_name]
  end

  def install
    # Check if GH_TOKEN is set
    if ENV["GH_TOKEN"].nil?
      # Try to get the token from gh CLI
      gh_token = Utils.popen_read("gh", "auth", "token").strip
      if gh_token.empty?
        odie <<~EOS
          GitHub authentication is required to install this formula.
          Please either:
          1. Run 'gh auth login' and try again, or
          2. Set the GH_TOKEN environment variable with a GitHub API token:
             export GH_TOKEN=your_token_here
        EOS
      end
      ENV["GH_TOKEN"] = gh_token
    end

    # Download the binary using gh CLI since the repository is private
    system "gh", "release", "download", "v#{version}", 
           "--repo", "ShieldFC-RD/devhelper-cli",
           "--pattern", binary_name
    
    # Verify the SHA256
    downloaded_sha256 = Utils.popen_read("shasum", "-a", "256", binary_name).split.first
    if downloaded_sha256 != binary_sha256
      odie "SHA256 mismatch for #{binary_name}:\nExpected: #{binary_sha256}\nActual: #{downloaded_sha256}"
    end
    
    # Make it executable and install
    chmod 0755, binary_name
    bin.install binary_name => "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
