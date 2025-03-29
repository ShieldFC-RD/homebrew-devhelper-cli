class DevhelperCli < Formula
  desc "A comprehensive command-line interface for ShieldDev operations"
  homepage "https://github.com/lirtsman/devhelper-cli"
  url "https://github.com/lirtsman/devhelper-cli/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "cbf371fa85389f5fe94e4cd8d333f10c8e5f13e55c36e3277de7fdaf18a1ac54"
  
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
