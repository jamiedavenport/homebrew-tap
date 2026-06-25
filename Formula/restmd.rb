class Restmd < Formula
  desc "A markdown-native REST client (CLI)."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.1/restmd-aarch64-apple-darwin.tar.xz"
      sha256 "96b998abd9d3a1c03c1f4eeb466a969c3041cd9dffbc52dba3cadf7f43ba07c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.1/restmd-x86_64-apple-darwin.tar.xz"
      sha256 "f72d140307e5345a123e77f74ee891efd230cdc0519478ea2669d1c5f5b9291a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.1/restmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9cd6b88733cc770d6dc19e410e3525e2bafa7a2cecc38436091487a2f1d07069"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.3.1/restmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d719578bc4121f5457ced33eb4f75053e8b8fc9717f00751a12ad82ebba6e35b"
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
