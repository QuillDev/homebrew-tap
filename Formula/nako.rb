class Nako < Formula
  desc "Desktop app for Nako Portal"
  homepage "https://github.com/QuillDev/nako-portal"
  url "https://github.com/QuillDev/nako-portal/archive/refs/tags/desktop-v0.2.1.tar.gz"
  sha256 "820423f2e4c50458193c073628096976041d86ca4345dd88c15e5b09da6a97e5"
  head "https://github.com/QuillDev/nako-portal.git", branch: "main"

  depends_on "node" => :build
  depends_on "rust" => :build
  depends_on :macos

  def install
    cd "desktop" do
      system "npm", "install", *std_npm_args(prefix: false)
      # --bundles app keeps this to the .app (no .dmg or codesign step).
      system "./node_modules/.bin/tauri", "build", "--bundles", "app"
      prefix.install "src-tauri/target/release/bundle/macos/Nako.app"
    end
  end

  def caveats
    <<~EOS
      Nako is installed as a macOS .app inside the Homebrew prefix. To launch it
      from Spotlight or Launchpad, link it into your Applications folder:

        ln -sf "#{opt_prefix}/Nako.app" /Applications/Nako.app

      It updates with `brew upgrade nako`.
    EOS
  end

  test do
    assert_path_exists prefix/"Nako.app/Contents/MacOS/nako"
  end
end
