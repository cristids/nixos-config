{
  stdenv,
  lib,
  fetchurl,
  meson,
  ninja,
  gobject-introspection,
  cpio,
  glib,
  gusb,
  pixman,
  libgudev,
  nss,
  libfprint,
  cairo,
  pkg-config,
  autoPatchelfHook,
  makePkgconfigItem,
  copyPkgconfigItems,
  dpkg,
  gtk-doc,
  docbook-xsl-nons,
  docbook_xml_dtd_43,
  
}:
let
  # The provided `.so`'s name in the binary package we fetch and unpack
  libso = "libfprint-2.so.2.0.0";
in


stdenv.mkDerivation rec {
  pname = "libfprint-focaltech-driver";
  # pname = "libfprint-2-2-tod";
  version = "1.94.4-tod1";
  NIX_CFLAGS_LINK = "-lgusb";

  src = fetchurl {
    url = "https://github.com/ftfpteams/focaltech-linux-fingerprint-driver/raw/refs/heads/main/Ubuntu_Debian/x86/libfprint-2-2_1.94.4+tod1-0ubuntu1~22.04.2_amd64_20250219.deb";
    sha256 = "06j0i02hx98q2f4x50y2h2di87h0ihvi0ky03xg0f62pd2xmx37y";
  };

  nativeBuildInputs = [ 
    dpkg
    pkg-config 
    autoPatchelfHook
    copyPkgconfigItems
    meson
    ninja
    gobject-introspection
  ];

  buildInputs = [
    stdenv.cc.cc
    glib
    gusb
    pixman
    nss
    libgudev
    libfprint
    cairo
  ];

# Optional, to debug linking:
  preConfigure = ''
    echo "GUSB flags:"
    pkg-config --libs --cflags gusb || true
  '';


  mesonFlags = [
    # "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
    # # Include virtual drivers for fprintd tests
    # "-Ddrivers=all"
    # "-Dudev_hwdb_dir=${placeholder "out"}/lib/udev/hwdb.d"
    "-Dsystemd=false"  
    "-Dintrospection=false"
  ];

  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src .

    runHook postUnpack
  '';

  patchPhase = ''
  substituteInPlace meson.build \
    --replace "dependency('libfprint-2'," "dependency('libfprint-2', required: true), dependency('gusb', required: true),"
'';

  # custom pkg-config based on libfprint's pkg-config
  pkgconfigItems = [
    (makePkgconfigItem rec {
      name = "libfprint-2";
      inherit version;
      inherit (meta) description;
      cflags = [ "-I${variables.includedir}/libfprint-2" ];
      libs = [
        "-L${variables.libdir}"
        "-lfprint-2"
      ];
      variables = rec {
        prefix = "${placeholder "out"}";
        includedir = "${prefix}/include";
        libdir = "${prefix}/lib";
      };
    })
  ];


  installPhase = ''
    runHook preInstall

    install -Dm444 usr/lib/x86_64-linux-gnu/${libso} -t $out/lib

    # create this symlink as it was there in libfprint
    ln -s -T $out/lib/${libso} $out/lib/libfprint-2.so
    ln -s -T $out/lib/${libso} $out/lib/libfprint-2.so.2

    # get files from libfprint required to build the package
    cp -r ${libfprint}/lib/girepository-1.0 $out/lib
    cp -r ${libfprint}/include $out

    runHook postInstall
  '';


  meta = with lib; {
    description = "FocalTech libfprint driver from .deb";
    license = licenses.unfreeRedistributable;  # Adjust if needed
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
