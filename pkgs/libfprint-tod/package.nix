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
    mkdir -p $out
    cp -r ./* $out/
  '';

  meta = with lib; {
    description = "FocalTech libfprint driver from .deb";
    license = licenses.unfreeRedistributable;  # Adjust if needed
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
