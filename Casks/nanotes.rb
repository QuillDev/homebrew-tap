cask "nanotes" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.14"
  sha256 arm:   "95268cc852624b6417bcba51543f006b9cf6bfc338d713b0930749c9f8e7af82",
         intel: "a8eaf7566c85fa8cfc89f6e5a736ca66019fdb8683ca83dbe5dc4a6af221ba51"

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
