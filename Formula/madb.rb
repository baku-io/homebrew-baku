class Madb < Formula
  desc "Multi-device Android Debug Bridge (madb)"
  homepage "https://github.com/vanadium/madb"
  url "https://github.com/vanadium/madb/releases/download/v1.1.1/madb-v1.1.1-src.tar.gz"
  sha256 "012b1ad2228b9bacb0d5d8a176993bf67a7c6911773eecacbb2cde549d999935"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    system "go", "get", "v.io/x/lib/cmdline"
    system "go", "get", "v.io/x/lib/gosh"
    system "go", "get", "v.io/x/lib/textutil"

    system "go", "build", "-o", "madb", "-ldflags", "-X main.version=v#{version}"
    bin.install "madb"
  end

  test do
    assert_equal "madb version: v#{version}", shell_output("#{bin}/madb version").strip
  end
end
