class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  url "https://github.com/ShieldFC-RD/devhelper-cli/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "03f5451164aa902dbf456e7945339d898548dcd7a0026ec2a518b32342bfdfdf"
  
  depends_on "go" => :build

  def install
    # Get version information and truncate tag prefix "v"
    version_no_v = version.to_s.sub(/^v/, "")
    system "go", "build", 
           "-ldflags", "-X github.com/ShieldFC-RD/devhelper-cli/cmd.Version=#{version_no_v} -X github.com/ShieldFC-RD/devhelper-cli/cmd.BuildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")} -X github.com/ShieldFC-RD/devhelper-cli/cmd.Commit=04407f6d8badbe987d82715268a1d9891b716954",
           "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
