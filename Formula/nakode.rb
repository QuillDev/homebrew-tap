class Nakode < Formula
  desc "Provider-neutral terminal workspace for coding agents"
  homepage "https://github.com/QuillDev/nakode"
  url "https://github.com/QuillDev/nakode/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "e3ae5ce2ee234be558b20e16afa4f62ee0503a9a14c7a6c3f2f82f9e0e3ea083"
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
