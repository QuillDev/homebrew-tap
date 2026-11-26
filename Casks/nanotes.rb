cask "nanotes" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.5"
  sha256 arm:   "f865d79a5c1fed641ac886534d54c1472e406acde362cb40b5f04eef4510fce4",
         intel: "831663b91d8c1b3d250ea8d33bab37038277357973e69df808d35fec232bfb63"

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
