{
  profile,
  pkgs,
  lib,
  ...
}: 
{
  programs.oh-my-posh = {
    enable = true;
    theme = "powerlevel10k";
    customPkgs = with pkgs; [
      oh-my-posh
      # zsh-completions
      # zsh-history
      # zsh-fzf-tab
      # zsh-completions
    ];
  };
}