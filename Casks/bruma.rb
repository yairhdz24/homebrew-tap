cask "bruma" do
  version "0.7.1"
  sha256 "414645868d0a1a5e45d2107a84c9852a6bcdc9451474b6ad55c67c099d452652"

  url "https://github.com/yairhdz24/bruma/releases/download/v#{version}/Bruma-macOS-Apple-Silicon.dmg"
  name "Bruma"
  desc "Free, open-source voice keyboard: tap fn, speak, and text appears in any app"
  homepage "https://github.com/yairhdz24/bruma"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Bruma.app"

  # Bruma is not notarized yet: let it open without the Gatekeeper prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Bruma.app"],
        writable_paths: ["{{appdir}}/Bruma.app"]
  end

  uninstall quit: "com.bruma.voice.personal"

  zap trash: [
    "~/Library/Application Support/com.bruma.voice.personal",
    "~/Library/Caches/com.bruma.voice.personal",
    "~/Library/WebKit/com.bruma.voice.personal",
  ]
end
