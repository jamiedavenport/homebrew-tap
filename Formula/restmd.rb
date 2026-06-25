class Restmd < Formula
  desc "A markdown-native REST client (CLI)."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.5.0/restmd-aarch64-apple-darwin.tar.xz"
      sha256 "b6c7bf6ddebde6ace8d67af041e874785be95934b0dad1b3a10015ab2ac66d50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.5.0/restmd-x86_64-apple-darwin.tar.xz"
      sha256 "5370afdfb41566a96e6960a7007cd706cff0a5d90ccae3d4a0cf2a08fba2079f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.5.0/restmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e5cd667d5e8d3d1e55f7741f80dce1c0c292fac7127be2e0a94d98e350abeb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.5.0/restmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b521bd790380d92fe6f8f2704a2a4f8e198a260e5852520bf6bea0ffecb6315c"
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
