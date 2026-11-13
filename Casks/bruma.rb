cask "bruma" do
  version "0.8.0"
  sha256 "52efbb9be0c8519b2aef5963c5c2e392bb8ce284a1cadf747ac854f13787dff5"

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
