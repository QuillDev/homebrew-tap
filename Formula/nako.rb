class Nako < Formula
  desc "Desktop app for Nako Portal"
  homepage "https://github.com/QuillDev/nako-portal"
  url "https://github.com/QuillDev/nako-portal/archive/refs/tags/desktop-v0.2.0.tar.gz"
  sha256 "c462e99c736a43019e0d5e4d0845c69ea59c41b0ecb7f3b59b6f1c4fa9b61355"
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
