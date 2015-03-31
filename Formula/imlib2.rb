require 'formula'

class Imlib2 < Formula
  homepage 'http://sourceforge.net/projects/enlightenment/files/'
  url 'https://downloads.sourceforge.net/project/enlightenment/imlib2-src/1.4.6/imlib2-1.4.6.tar.bz2'
  sha1 '20e111d822074593e8d657ecf8aafe504e9e2967'
  revision 1

  deprecated_option "without-x" => "without-x11"

  depends_on 'freetype'
  depends_on 'libpng' => :recommended
  depends_on :x11 => :recommended
  depends_on 'pkg-config' => :build
  depends_on 'jpeg' => :recommended
  depends_on 'giflib' => :recommended

  patch :p1, :DATA

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-amd64=no
    ]
    args << "--without-x" if build.without? "x11"

    system "./configure", *args
    system "make install"
  end

  test do
    system "#{bin}/imlib2_conv", test_fixtures("test.png"), "imlib2_test.png"
  end
end

__END__
diff -urN imlib2-1.4.6_orig/imlib2-config.in imlib2-1.4.6/imlib2-config.in
--- imlib2-1.4.6_orig/imlib2-config.in  2013-12-21 19:14:48.000000000 +0900
+++ imlib2-1.4.6/imlib2-config.in 2015-03-31 19:43:57.000000000 +0900
@@ -46,7 +46,7 @@
       ;;
     --libs)
       libdirs=-L@libdir@
-      echo $libdirs -lImlib2 @my_libs@
+      echo $libdirs -lImlib2
       ;;
     *)
       echo "${usage}" 1>&2
