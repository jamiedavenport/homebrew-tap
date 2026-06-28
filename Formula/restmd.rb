class Restmd < Formula
  desc "A markdown-native REST client (CLI)."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.6.0/restmd-aarch64-apple-darwin.tar.xz"
      sha256 "8b3861a9b95eccc7dcd525ca8b84ba5e8e2d311c6d752b69b5f556e0bc3cacd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.6.0/restmd-x86_64-apple-darwin.tar.xz"
      sha256 "50dbdbd0264a9312723d1f81b7df57d934ff71d3c22e246d18c61e7e2516ec62"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.6.0/restmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e445ae0e7e084111bf19dc1114dd31d21a3a9db31c192fb2cce371935ccae9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.6.0/restmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a29dac09458d5f4f8ae65fb6b97aaf87ab2701966205f53a1f24cbdcc1b3e04c"
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
