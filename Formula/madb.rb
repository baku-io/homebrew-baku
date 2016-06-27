class Madb < Formula
  desc "Multi-device Android Debug Bridge (madb)"
  homepage "https://github.com/vanadium/madb"
  url "https://github.com/vanadium/madb/releases/download/v2.0.0/madb-v2.0.0-src.tar.gz"
  sha256 "0c7e2daf061ce819d656f69a5088a62a22ce78fe1f9c39823440e491cdea7182"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    system "go", "get", "v.io/x/lib/cmdline"
    system "go", "get", "v.io/x/lib/gosh"
    system "go", "get", "v.io/x/lib/textutil"
	system "go", "get", "github.com/olekukonko/tablewriter"

    system "go", "build", "-o", "madb", "-ldflags", "-X main.version=v#{version}"
    bin.install "madb"
  end

  test do
    assert_equal "madb version: v#{version}", shell_output("#{bin}/madb version").strip
  end
end
