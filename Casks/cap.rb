cask "cap" do
  version "0.0.9"
  sha256 "9d15034539b3745d99e6afdd396fabcb7de5c3b8c44fb1d88573d9d1d01cf1a5"

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
