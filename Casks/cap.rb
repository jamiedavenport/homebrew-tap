cask "cap" do
  version "0.0.0"
  sha256 :no_check
  url "https://github.com/jamiedavenport/cap/releases/download/v#{version}/Cap.zip"
  name "Cap"
  desc "Native macOS capture and bookmarking app"
  homepage "https://github.com/jamiedavenport/cap"
  app "Cap.app"
end
