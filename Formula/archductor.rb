class Archductor < Formula
  desc "Parallel coding-agent workflow tool built around Git worktrees"
  homepage "https://github.com/perceo-ai/conductor-arch"
  url "https://github.com/perceo-ai/conductor-arch/archive/refs/tags/v0.14.4.tar.gz"
  sha256 "a58710a016e932617152074eccb9390578bd86befe8f7a8ee3e1689168539749"
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
