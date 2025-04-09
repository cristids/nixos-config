{ lib, stdenv, fetchurl, dpkg }:

stdenv.mkDerivation rec {
  pname = "libfprint-2-2-tod";
  version = "1.94.4-tod1";

  src = fetchurl {
    url = "https://github.com/ftfpteams/focaltech-linux-fingerprint-driver/raw/refs/heads/main/Ubuntu_Debian/x86/libfprint-2-2_1.94.4+tod1-0ubuntu1~22.04.2_amd64_20250219.deb";
    sha256 = "06j0i02hx98q2f4x50y2h2di87h0ihvi0ky03xg0f62pd2xmx37y";
  };

  nativeBuildInputs = [ dpkg ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    echo ">>> Installing libfprint-tod"
    find . -type f

    mkdir -p $out/lib
    cp -v usr/lib/x86_64-linux-gnu/libfprint-2.so.* $out/lib/

    # If there are udev rules, install those too
    if [ -d lib/udev/rules.d ]; then
      mkdir -p $out/lib/udev/rules.d
      cp -v lib/udev/rules.d/* $out/lib/udev/rules.d/
    fi

    echo ">>> Done installing"
  '';



  meta = with lib; {
    description = "FocalTech libfprint driver from .deb";
    license = licenses.unfreeRedistributable;  # Adjust if needed
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
