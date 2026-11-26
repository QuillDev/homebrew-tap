cask "nanotes" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.7"
  sha256 arm:   "f099cf54a78335d1630af86fcf18748884dd9a83e80b26dec4399d55289158e1",
         intel: "f7289fb757c377617d06d5650ec05379e12fd5dce24f0f9b22d1c5e330007922"

  url "https://github.com/QuillDev/nanotes/releases/download/v#{version}/NaNotes_#{version}_#{arch}.app.tar.gz"
  name "NaNotes"
  desc "Floating Markdown scratchpad backed by local files"
  homepage "https://github.com/QuillDev/nanotes"

  app "NaNotes.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NaNotes.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    NaNotes is unsigned/ad-hoc signed, so this cask clears macOS quarantine on install.
    Press Option+N to toggle the overlay from any app, or Cmd+O to open settings.
  EOS

  zap trash: [
    "~/Library/Application Support/moe.quill.nanotes",
    "~/Library/Caches/moe.quill.nanotes",
    "~/Library/Preferences/moe.quill.nanotes.plist",
  ]
end
