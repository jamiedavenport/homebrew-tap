cask "capd" do
  version "0.0.4"
  sha256 "0b60b9730649c8d803a832cf142c3597e960e89c03db3a66917d44f4ff24391b"

  url "https://github.com/jamiedavenport/capd/releases/download/v#{version}/capd-#{version}.dmg"
  name "Capd"
  desc "Menu-bar capture and search for things you've seen"
  homepage "https://github.com/jamiedavenport/capd"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"

  app "capd.app"
  binary "#{appdir}/capd.app/Contents/MacOS/capd"

  uninstall launchctl: "dev.jxd.capd.agent",
            quit:      "dev.jxd.capd"

  zap trash: [
    "~/Library/Application Support/capd",
    "~/Library/LaunchAgents/dev.jxd.capd.agent.plist",
  ]
end
