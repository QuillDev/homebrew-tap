class Nakode < Formula
  desc "Provider-neutral terminal workspace for coding agents"
  homepage "https://github.com/QuillDev/nakode"
  url "https://github.com/QuillDev/nakode/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e51390d803a41e2409afa7dff1ab9c2d39a649b711e66d88bee5691a4edf06cf"
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
