class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  version "0.4.0"
  url "https://github.com/ShieldFC-RD/devhelper-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "76706018bd6a65e1bff43d06966573be1b48cf83bbd2f979b711046b960e9a4a"

  depends_on "gh"

  bottle do
    root_url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v0.4.0"
    
    if OS.mac?
      if Hardware::CPU.arm?
        sha256 cellar: :any_skip_relocation, arm64_sonoma: "76706018bd6a65e1bff43d06966573be1b48cf83bbd2f979b711046b960e9a4a"
      else
        sha256 cellar: :any_skip_relocation, sonoma: "5fd1cb2fbd1cf2315d0cb09ab2f5176fb090762cc705987b1627ee8177d5cfc1"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        sha256 cellar: :any_skip_relocation, arm64_linux: "bded17592001da17b0ad424f78ef0478c9f394b617bc25afe8ac61301d563bb9"
      else
        sha256 cellar: :any_skip_relocation, x86_64_linux: "f835e01be52474f16186c156563345b383d816e890ead1ed43ea30e51f622329"
      end
    end
  end

  def binary_name
    if OS.mac?
      Hardware::CPU.arm? ? "devhelper-cli-darwin-arm64" : "devhelper-cli-darwin-amd64"
    elsif OS.linux?
      Hardware::CPU.arm? ? "devhelper-cli-linux-arm64" : "devhelper-cli-linux-amd64"
    end
  end

  def install
    # Download the binary using gh CLI
    system "gh", "release", "download", "v#{version}", 
           "--repo", "ShieldFC-RD/devhelper-cli",
           "--pattern", binary_name
    
    # Make it executable and install
    chmod 0755, binary_name
    bin.install binary_name => "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
