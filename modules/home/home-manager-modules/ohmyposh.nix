{
  profile,
  pkgs,
  lib,
  ...
}: 
{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    # theme = "powerlevel10k";
    
  };
}