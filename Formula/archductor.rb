class Archductor < Formula
  desc "Parallel coding-agent workflow tool built around Git worktrees"
  homepage "https://github.com/perceo-ai/conductor-arch"
  url "https://github.com/perceo-ai/conductor-arch/archive/refs/tags/v0.11.3.tar.gz"
  sha256 "34aa12035d8450ec8457cc14794a5d14a6ea57c069818c2842f1895b162871a3"
  license "Apache-2.0"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "gh"
  depends_on "git"
  depends_on :linux
  depends_on "sqlite"

  def install
    ENV["LIBSQLITE3_SYS_USE_PKG_CONFIG"] = "1"
    system "cargo", "install", *std_cargo_args(path: "crates/cli")
    system "cargo", "install", *std_cargo_args(path: "crates/archcar")
    pkgshare.install "README.md"
    (share/"icons/hicolor/256x256/apps").install "packaging/assets/archductor.png"
    (share/"fonts/archductor").install Dir["packaging/assets/fonts/*.{ttf,otf,txt}"]
  end

  test do
    system bin/"archductor", "doctor"
  end
end
