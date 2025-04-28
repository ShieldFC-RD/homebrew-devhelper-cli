class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  version "0.4.0"
  url "https://github.com/ShieldFC-RD/devhelper-cli.git", tag: "v0.4.0"

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
    # Get the GitHub token from environment
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    if token.nil?
      odie <<~EOS
        GitHub authentication is required to install this formula.
        Please set the HOMEBREW_GITHUB_API_TOKEN environment variable with a GitHub API token:
        export HOMEBREW_GITHUB_API_TOKEN=your_token_here
        
        You can create a token at: https://github.com/settings/tokens
        The token needs the 'repo' scope to access private repositories.
      EOS
    end

    # Download the binary using curl with GitHub token
    binary_url = "https://api.github.com/repos/ShieldFC-RD/devhelper-cli/releases/tags/v#{version}"
    assets = Utils.popen_read("curl", "-H", "Accept: application/vnd.github.v3+json",
                                    "-H", "Authorization: token #{token}",
                                    binary_url).strip

    if $?.exitstatus != 0
      odie "Failed to get release information. Please check your GitHub token."
    end

    require "json"
    assets_json = JSON.parse(assets)
    asset = assets_json["assets"].find { |a| a["name"] == binary_name }
    
    if asset.nil?
      odie "Could not find binary #{binary_name} in release assets"
    end

    curl_download asset["url"],
                 to: binary_name,
                 headers: {
                   "Accept" => "application/octet-stream",
                   "Authorization" => "token #{token}"
                 }
    
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
