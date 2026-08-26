class Smidja < Formula
  desc "Agentic coding harness shipped as a single static binary"
  homepage "https://github.com/digitalygo/smidja"
  url "https://github.com/digitalygo/smidja/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w " \
      "-X main.version=v#{version} " \
      "-X github.com/digitalygo/smidja/internal/buildinfo.smidjaOrigin=github.com/digitalygo/smidja " \
      "-X github.com/digitalygo/smidja/internal/buildinfo.smidjaVersion=v#{version}"
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", bin/"smidja", "./cmd/smidja"
  end

  test do
    assert_match "smidja v#{version}", shell_output("#{bin}/smidja -version")
  end

  livecheck do
    url "https://github.com/digitalygo/smidja/releases"
    regex(/v?(\d+\.\d+\.\d+)/i)
  end
end
