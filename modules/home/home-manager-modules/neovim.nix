{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      tree-sitter
      gcc
      clang
      unzip
      git
      curl
      wget
      nodejs
      python3
    ];
  };

  # Optional: make Mason-installed tools easy to use
  home.sessionPath = [ "$HOME/.local/share/nvim/mason/bin" ];
}
