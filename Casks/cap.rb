cask "cap" do
  version "0.0.4"
  sha256 "f68654e266e0cd3357a4d7fb4ead329ef1eef2a8650ee3863dc6fd8eec020a7c"

  url "https://github.com/jamiedavenport/cap/releases/download/v#{version}/cap-#{version}.dmg"
  name "cap"
  desc "Menu-bar capture and search for things you've seen"
  homepage "https://github.com/jamiedavenport/cap"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"

  app "cap.app"
  binary "#{appdir}/cap.app/Contents/MacOS/cap"

  uninstall launchctl: "dev.jxd.cap.agent",
            quit:      "dev.jxd.cap"

  zap trash: [
    "~/Library/Application Support/cap",
    "~/Library/LaunchAgents/dev.jxd.cap.agent.plist",
  ]
end
