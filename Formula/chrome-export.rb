class ChromeExport < Formula
  desc "Convert Chrome’s bookmarks and history to HTML bookmarks files"
  homepage "https://github.com/bdesham/chrome-export"
  url "https://github.com/bdesham/chrome-export/archive/v2.0.1.tar.gz"
  sha256 "9ba4b5b5c4881785bb6840a434cd3f1ce553c6e37fad0c5be1ac3533ef94f269"

  bottle :unneeded

  depends_on "python@2" if MacOS.version <= :snow_leopard

  def install
    bin.install "export-chrome-bookmarks"
    bin.install "export-chrome-history"
    pkgshare.install "test"
  end

  test do
    cp_r (pkgshare/"test").children, testpath
    system bin/"export-chrome-bookmarks", "Bookmarks",
           "bookmarks_actual_output.html"
    assert_predicate testpath/"bookmarks_actual_output.html", :exist?
    assert_equal (testpath/"bookmarks_expected_output.html").read,
                 (testpath/"bookmarks_actual_output.html").read
    system bin/"export-chrome-history", "History", "history_actual_output.html"
    assert_predicate testpath/"history_actual_output.html", :exist?
    assert_equal (testpath/"history_expected_output.html").read,
                 (testpath/"history_actual_output.html").read
  end
end
