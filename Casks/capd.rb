cask "capd" do
  version "0.0.3"
  sha256 "fde7354ae609307a6791e809e80af7c870bbf31878f7edde6083eb2bf562d271"

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
