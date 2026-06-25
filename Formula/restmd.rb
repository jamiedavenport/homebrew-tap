class Restmd < Formula
  desc "A markdown-native REST client (CLI)."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.0/restmd-aarch64-apple-darwin.tar.xz"
      sha256 "6cb2ad62926e6aaf214e2c896d25f7d6c70757fa387547da8aae3551a8f67afb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.0/restmd-x86_64-apple-darwin.tar.xz"
      sha256 "717015aea891fd166cb656467ae939f853c512c33585e02803fceaba4c580495"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.0/restmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b7e25627bec87f350a6a9f843ce1eb7c535244323d872a11ccac438bcfc9c14"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.0/restmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af366f951dae96512f801827b6a9fd05ca96e0a92b558f6916c38bfb8e0c0880"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "restmd" if OS.mac? && Hardware::CPU.arm?
    bin.install "restmd" if OS.mac? && Hardware::CPU.intel?
    bin.install "restmd" if OS.linux? && Hardware::CPU.arm?
    bin.install "restmd" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
