class Nako < Formula
  desc "Desktop app for Nako Portal"
  homepage "https://github.com/QuillDev/nako-portal"
  url "https://github.com/QuillDev/nako-portal/archive/refs/tags/desktop-v0.3.7.tar.gz"
  sha256 "e882114bca73aa51443a1212e3af376b22073b75db7403218ee35057c388f389"
  head "https://github.com/QuillDev/nako-portal.git", branch: "main"

  depends_on "node" => :build
  depends_on :macos

  def install
    version_number = build.head? ? "0.0.0" : version.to_s
    cd "desktop" do
      # electron-builder fetches Electron itself, so the package install scripts aren't needed.
      system "npm", "ci", "--ignore-scripts"
      # The `dir` target keeps this to Nako.app (no .dmg, no Developer ID signing).
      system "./node_modules/.bin/electron-builder", "--mac", "dir", "-c.extraMetadata.version=#{version_number}", "--publish", "never"
      app = Dir["dist/mac*/Nako.app"].first
      # Electron's own signature breaks once the app is renamed and its Info.plist rewritten; an
      # ad-hoc signature lets Apple silicon run it.
      system "codesign", "--force", "--deep", "--sign", "-", app
      prefix.install app
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
    assert_predicate Dir[prefix/"Nako.app/Contents/MacOS/*"], :any?
  end
end
