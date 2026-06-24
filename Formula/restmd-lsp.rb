class RestmdLsp < Formula
  desc "Language server for restmd — completion, diagnostics, and symbols for .restmd files."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.2.0/restmd-lsp-aarch64-apple-darwin.tar.xz"
      sha256 "b019fbe538c3aff1f48c3f07b99c866f39804d0996aedb6581acc3956c15cf80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.2.0/restmd-lsp-x86_64-apple-darwin.tar.xz"
      sha256 "e6fc320624eeba171f7bd3f1f69262437ffda3fbcf5c7d6d50e9a0d43c1471c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.2.0/restmd-lsp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "87c524339932c1166b90f1dbeab36c1b30f5232159c0c80be381ca7c6626e570"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.2.0/restmd-lsp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "75dac83cc0d33e9767b8a1316ebf41f5ccb6899085f23d690782b8ce83f70a2d"
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
    bin.install "restmd-lsp" if OS.mac? && Hardware::CPU.arm?
    bin.install "restmd-lsp" if OS.mac? && Hardware::CPU.intel?
    bin.install "restmd-lsp" if OS.linux? && Hardware::CPU.arm?
    bin.install "restmd-lsp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
