class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  version "0.4.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v#{version}/devhelper-cli-darwin-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v#{version}/devhelper-cli-darwin-amd64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v#{version}/devhelper-cli-linux-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/ShieldFC-RD/devhelper-cli/releases/download/v#{version}/devhelper-cli-linux-amd64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    bin.install Dir["*"].first => "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
