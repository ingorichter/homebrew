require 'formula'

class Ideviceinstaller < Formula
  url 'http://cgit.sukimashita.com/ideviceinstaller.git/downloads/ideviceinstaller-1.0.0.tar.gz'
  md5 '85bca8024d385c40fef477f33fefab5d'
  head 'http://cgit.sukimashita.com/ideviceinstaller.git', :using => :git
  homepage 'http://www.sukimashita.com/'
  version '1.0.0'

  depends_on 'pkg-config' => :build
  depends_on 'libimobiledevice'
  depends_on 'glib'
  depends_on 'libzip'
  depends_on 'libplist'

  def install
    # fix the m4 problem with the missing pkg.m4

    aclocalDefault = `/usr/bin/aclocal --print-ac-dir`
    inreplace "autogen.sh", "aclocal -I m4", "aclocal -I m4 -I#{aclocalDefault.strip} -I #{HOMEBREW_PREFIX}/share/aclocal"

    system "./autogen.sh"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
