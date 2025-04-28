class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  version "0.4.0"

  depends_on "gh"

  on_macos do
    on_arm do
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v0.4.0/devhelper-cli-darwin-arm64"
      sha256 "76706018bd6a65e1bff43d06966573be1b48cf83bbd2f979b711046b960e9a4a"
    end
    on_intel do
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v0.4.0/devhelper-cli-darwin-amd64"
      sha256 "5fd1cb2fbd1cf2315d0cb09ab2f5176fb090762cc705987b1627ee8177d5cfc1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v0.4.0/devhelper-cli-linux-arm64"
      sha256 "bded17592001da17b0ad424f78ef0478c9f394b617bc25afe8ac61301d563bb9"
    end
    on_intel do
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v0.4.0/devhelper-cli-linux-amd64"
      sha256 "f835e01be52474f16186c156563345b383d816e890ead1ed43ea30e51f622329"
    end
  end

  def install
    # Download the binary using gh CLI since the repository is private
    system "gh", "release", "download", "v#{version}", 
           "--repo", "ShieldFC-RD/devhelper-cli",
           "--pattern", File.basename(url)
    
    # Make it executable and install
    chmod 0755, File.basename(url)
    bin.install File.basename(url) => "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
