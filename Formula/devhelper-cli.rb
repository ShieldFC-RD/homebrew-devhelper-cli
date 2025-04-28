class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  url "https://github.com/ShieldFC-RD/devhelper-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
