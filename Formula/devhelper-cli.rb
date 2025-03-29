class DevhelperCli < Formula
  desc "A comprehensive command-line interface for ShieldDev operations"
  homepage "https://github.com/lirtsman/devhelper-cli"
  url "https://github.com/lirtsman/devhelper-cli/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "ad659de1ee0cfca0a38b5de77331b21551123cd8f76c0ca65e8ee495c11b5cc8"
  
  depends_on "go" => :build

  def install
    # Get version information and truncate tag prefix "v"
    version_no_v = version.to_s.sub(/^v/, "")
    system "go", "build", 
           "-ldflags", "-X github.com/lirtsman/devhelper-cli/cmd.Version=#{version_no_v} -X github.com/lirtsman/devhelper-cli/cmd.BuildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")} -X github.com/lirtsman/devhelper-cli/cmd.Commit=bb2fe850cf945559b300def7934663aede258cbb",
           "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
