{
  stdenv,
  lib,
  rpm,
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
}:

# https://discourse.nixos.org/t/request-for-libfprint-port-for-2808-a658/55474
let
  # The provided `.so`'s name in the binary package we fetch and unpack
  libso = "libfprint-2.so.2.0.0";
in
stdenv.mkDerivation rec {
  pname = "libfprint-focaltech";
  version = "1.94.9";

  # Original upstream (https://github.com/ftfpteams/focaltech-linux-fingerprint-driver)
  # was taken down via DMCA (HTTP 451). File archived from Wayback Machine on 2026-03-20.
  src = ./libfprint-2-2_1.94.4+tod1_redhat_all_x64_20250219.install;

  nativeBuildInputs = [
    rpm
    cpio
    pkg-config
    autoPatchelfHook
    copyPkgconfigItems
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

  unpackPhase = ''
    runHook preUnpack
  echo "Extracting embedded tar.gz using sed"

  sed '1,/^main \$@/d' $src > libfprint.tar.gz

  mkdir extracted
  tar -xzf libfprint.tar.gz -C .
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

    install -Dm444 usr/lib64/${libso} -t $out/lib

    # create this symlink as it was there in libfprint
    ln -s -T $out/lib/${libso} $out/lib/libfprint-2.so
    ln -s -T $out/lib/${libso} $out/lib/libfprint-2.so.2

    # get files from libfprint required to build the package
    cp -r ${libfprint}/lib/girepository-1.0 $out/lib
    cp -r ${libfprint}/include $out

    runHook postInstall
  '';


  meta = with lib; {
    description = "FocalTech libfprint driver (Fedora variant)";
    homepage = "https://github.com/ftfpteams/focaltech-linux-fingerprint-driver";
    platforms = platforms.linux;
    license = licenses.unfree;  # Sadly
  };
}
