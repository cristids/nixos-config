self: super: {
  grub2 = super.stdenv.mkDerivation {
    pname = "grub2-fbrot";
    version = "2.13-fbrot";

    src = super.fetchFromGitHub {
      owner = "kbader94";
      repo = "grub";
      rev = "fb_rot";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Will fix this below
    };

    configureFlags = [
      "--with-platform=efi"   # Use "pc" if BIOS
      "--target=x86_64"
    ];

    nativeBuildInputs = with super; [ autoconf automake libtool gettext texinfo bison flex ];
    buildInputs = with super; [ ncurses freetype efibootmgr ];

    preConfigure = ''
      ./autogen.sh
    '';

    installPhase = ''
      make install DESTDIR=$out
    '';
  };
}
