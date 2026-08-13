cask "capd" do
  version "0.0.8"
  sha256 "8f35a6966fe3ef1885ca851eed76c343eba3e19f6f664ec998837ee76ab6b662"

  url "https://github.com/jamiedavenport/capd/releases/download/v#{version}/capd-#{version}.dmg"
  name "Capd"
  desc "Menu-bar capture and search for things you've seen"
  homepage "https://github.com/jamiedavenport/capd"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "capd.app"
  binary "#{appdir}/capd.app/Contents/MacOS/capd"

  uninstall launchctl: "dev.jxd.capd.agent",
            quit:      "dev.jxd.capd"

  zap trash: [
    "~/Library/Application Support/capd",
    "~/Library/LaunchAgents/dev.jxd.capd.agent.plist",
  ]
end
