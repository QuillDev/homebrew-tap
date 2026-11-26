cask "nanotes" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.8"
  sha256 arm:   "f21601c2c234d6f9467409ca894643f2bec5f2d9981604bcb4293a5f45c48ee6",
         intel: "fc550899e26ed16f2abb12e70ba832620bc0654790ca8cccc80bc2fcf11d23b2"

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
