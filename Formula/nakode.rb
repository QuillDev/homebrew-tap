class Nakode < Formula
  desc "Provider-neutral terminal workspace for coding agents"
  homepage "https://github.com/QuillDev/nakode"
  url "https://github.com/QuillDev/nakode/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "219dcce4b912fe043aab971b5da187f20e3d6f9704775e57315bc6e2fb554bfc"
  head "https://github.com/QuillDev/nakode.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nakode --version")
  end
end
