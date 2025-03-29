class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/lirtsman/devhelper-cli"
  url "https://github.com/lirtsman/devhelper-cli/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "e0766db1bd46f93d4577f2589ca9fd9d286defcf60fe79e08f2f7cc37782314a"
  
  depends_on "go" => :build

  def install
    # Get version information and truncate tag prefix "v"
    version_no_v = version.to_s.sub(/^v/, "")
    system "go", "build", 
           "-ldflags", "-X github.com/lirtsman/devhelper-cli/cmd.Version=#{version_no_v} -X github.com/lirtsman/devhelper-cli/cmd.BuildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")} -X github.com/lirtsman/devhelper-cli/cmd.Commit=ba01dcd254a8d761506ca964a1f110cb72535754",
           "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
