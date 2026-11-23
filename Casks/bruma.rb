cask "bruma" do
  version "0.8.2"
  sha256 "94688abdc57edeef4b22ca790ba032cc7fd51d524ea720c8a07ccd502119d4e4"

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
