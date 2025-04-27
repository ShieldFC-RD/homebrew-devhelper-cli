class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/ShieldFC-RD/devhelper-cli"
  url "https://github.com/ShieldFC-RD/devhelper-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  
  depends_on "go" => :build

  def install
    # Get version information and truncate tag prefix "v"
    version_no_v = version.to_s.sub(/^v/, "")
    system "go", "build", 
           "-ldflags", "-X github.com/ShieldFC-RD/devhelper-cli/cmd.Version=#{version_no_v} -X github.com/ShieldFC-RD/devhelper-cli/cmd.BuildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")} -X github.com/ShieldFC-RD/devhelper-cli/cmd.Commit=702aef6c82c651e36441bbb968722d39f922c278",
           "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
