cask "cap" do
  version "0.0.5"
  sha256 "fddb3e7fc763fded35a761ea338a39464d463e1772f096c410c0859d7c3b62be"

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
