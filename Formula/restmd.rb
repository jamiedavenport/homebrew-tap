class Restmd < Formula
  desc "A markdown-native REST client (CLI)."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-aarch64-apple-darwin.tar.xz"
      sha256 "78b608ac0ae8cf41c2716603713da95ca63f80d24cf8684683d907cbd577ba4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-x86_64-apple-darwin.tar.xz"
      sha256 "57206b02a04bc2af422d85e4937db9042342e8127eada07b7a58884cd88a3c23"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b957ef1c7e247fa2200655b9c24203926ece76fceb43ab15b841c5f83d28bbe9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "202c821541d1514e869cf572ce129aab402d81e94cacefdc3a35b91265d94963"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
