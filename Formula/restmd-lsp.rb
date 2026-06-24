class RestmdLsp < Formula
  desc "Language server for restmd — completion, diagnostics, and symbols for .restmd files."
  homepage "https://github.com/jamiedavenport/restmd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-lsp-aarch64-apple-darwin.tar.xz"
      sha256 "08fce15ec5d15fee7ec2c15068cfd3f893d3a22feb55bd61df862c6be6478097"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-lsp-x86_64-apple-darwin.tar.xz"
      sha256 "603d8663c48a5cecf9f912abea33fe36ac12c40be0c3d8ac32dbc41d5e0d05b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-lsp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65b2cadc513d2e3d9d4bdbfeaf9ae35d2ec86012c0aa9ecb9d49c3def8def9ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jamiedavenport/restmd/releases/download/v0.1.0/restmd-lsp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7e921210953d06877e039eb2bc6944264f1cc07bd57c5cc13fb8c2d976cc0da4"
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
