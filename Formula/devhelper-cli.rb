class DevhelperCli < Formula
  desc "A comprehensive command-line interface for ShieldDev operations"
  homepage "https://github.com/lirtsman/devhelper-cli"
  url "https://github.com/lirtsman/devhelper-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "971d6150e4b239d8261c3a6b99f14ca7789fd9c890ebbebd289ef2808a9ad9a1"
  
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end 