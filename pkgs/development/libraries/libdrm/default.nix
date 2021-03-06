{ stdenv, fetchurl, pkgconfig, libpthreadstubs, libpciaccess, udev }:

stdenv.mkDerivation rec {
  name = "libdrm-2.4.61";

  src = fetchurl {
    url = "http://dri.freedesktop.org/libdrm/${name}.tar.bz2";
    sha256 = "8b549092c8961a393a7e1d9a1bccddcea8e2af67c0d7d7c67babb9fc3b47699c";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libpthreadstubs libpciaccess ]
    ++ stdenv.lib.optional stdenv.isLinux udev;

  patches = stdenv.lib.optional stdenv.isDarwin ./libdrm-apple.patch;

  preConfigure = stdenv.lib.optionalString stdenv.isDarwin
    "echo : \\\${ac_cv_func_clock_gettime=\'yes\'} > config.cache";

  configureFlags = [ "--enable-freedreno" ]
    ++ stdenv.lib.optional stdenv.isLinux "--enable-udev"
    ++ stdenv.lib.optional stdenv.isDarwin "-C";

  crossAttrs.configureFlags = configureFlags ++ [ "--disable-intel" ];

  meta = {
    homepage = http://dri.freedesktop.org/libdrm/;
    description = "Library for accessing the kernel's Direct Rendering Manager";
    license = "bsd";
    maintainers = [ stdenv.lib.maintainers.urkud ];
    platforms = stdenv.lib.platforms.unix;
  };
}
