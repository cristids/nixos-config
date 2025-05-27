{ pkgs, unstablePkgs, ... }:
{

  #programs.nix-ld.enable = true;

  environment.systemPackages = with unstablePkgs; [
    git
    #emacs-git
    #emacs-unstable
    fd
    ripgrep
    gnugrep
    shellcheck
    cmake
    nodejs # provides npm
    isort
    pipenv
    rust-analyzer
    rustc
    cargo
    gcc
    glibc
    glibc.dev
    cmake
    gnumake
    libtool
    pkg-config
    pandoc
    #emacsPackages.vterm
    sqlite
    ispell
  ];

  services.emacs = {
    enable = true;
    package = unstablePkgs.emacs-pgtk; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}
