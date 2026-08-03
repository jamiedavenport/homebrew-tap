cask "cap" do
  version "0.0.7"
  sha256 "2629353e46c8462dbb2dfedbb9964f7894b68305e8e97a90cdfccb3c9dd78bf7"

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
