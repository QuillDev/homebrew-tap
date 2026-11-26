cask "nanotes" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.9"
  sha256 arm:   "fa3162c76db9eb38762e23eee98fb7c514b9e7e6189a0910759852010814ba4b",
         intel: "fa61f57aecec3e29af5b1ecccda58839c9b1e34aff6fe32148898acf7749a7d3"

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
