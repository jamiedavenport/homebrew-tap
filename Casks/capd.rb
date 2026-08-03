cask "capd" do
  version "0.0.1"
  sha256 "bb543fec52290914cfaf9cef2b47ee59d8f321f071f9359c8889ec75032f4a2b"

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
