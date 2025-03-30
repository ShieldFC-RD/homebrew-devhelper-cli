class DevhelperCli < Formula
  desc "A comprehensive command-line interface for Shield operations"
  homepage "https://github.com/lirtsman/devhelper-cli"
  url "https://github.com/lirtsman/devhelper-cli/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "d2e51d7f8fca6b4475d442b2851f52545f08917c20f6329b2772eb0e8e4d0653"
  
  depends_on "go" => :build

  def install
    # Get version information and truncate tag prefix "v"
    version_no_v = version.to_s.sub(/^v/, "")
    system "go", "build", 
           "-ldflags", "-X github.com/lirtsman/devhelper-cli/cmd.Version=#{version_no_v} -X github.com/lirtsman/devhelper-cli/cmd.BuildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")} -X github.com/lirtsman/devhelper-cli/cmd.Commit=cb36cfde8b806a1efc8be897368615b09d2182fd",
           "-o", "devhelper-cli"
    bin.install "devhelper-cli"
  end

  test do
    system "#{bin}/devhelper-cli", "--help"
  end
end
