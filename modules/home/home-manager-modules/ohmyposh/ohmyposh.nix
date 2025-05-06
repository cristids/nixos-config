{
  ...
}: 
{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    # # useTheme = "tokyonight_storm";
    # # useTheme = "1_shell";
    # # useTheme = "slim";
    # # useTheme = "slim-fat";
    # useTheme = "sim-web";
    # useTheme = "uew"

    # settings = builtins.fromJSON (
    #   builtins.unsafeDiscardStringContext (builtins.readFile ./kali.json)
    # );
    
    # useTheme = "powerlevel10k";
    # useTheme = "emodipt-extend";
    # settings = {
    #   "transient_prompt" = {
    #     "background" = "transparent";
    #     "foreground" = "#ffffff";
    #     "template" = "{{ .Shell }}> ";
    #   }; 
    # };
  };
}