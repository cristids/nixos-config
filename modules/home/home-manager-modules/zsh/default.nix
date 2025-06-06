{
  profile,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./zshrc-personal.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    #initExtra = ''
    #  export PATH="$HOME/.config/emacs/bin:$PATH"
    #'';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-history";
        src = pkgs.zsh-history;
      }
    ];

    # oh-my-zsh = {
    #   enable = true;
    # };

    #     plugins = [
    #       {
    #         name = "powerlevel10k";
    #         src = pkgs.zsh-powerlevel10k;
    #         file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #       }
    #       {
    #         name = "powerlevel10k-config";
    #         src = lib.cleanSource ./p10k-config;
    #         file = "p10k.zsh";
    #       }
    #     ];

    #     ohMyZsh = {
    #         enable = true;
    #         theme = "agnoster";
    #         customPkgs = with pkgs; [
    #             nix-zsh-completions
    #             zsh-history
    #             zsh-fzf-tab
    #             zsh-completions
    #         ];
    #         plugins = [
    #             "git"
    #             "history"
    # #                 "nix-zsh-completions"
    #             "web-search"
    # #                 "zsh-autosuggestions"
    # #                 "zsh-syntax-highlighting"
    # #                 "fast-syntax-highlighting"
    #             "copyfile"
    #             "copybuffer"
    #             "dirhistory"
    #         ];
    #     };

    initContent = ''
      bindkey "\eh" backward-word
      bindkey "\ej" down-line-or-history
      bindkey "\ek" up-line-or-history
      bindkey "\el" forward-word
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
      export PATH="$HOME/.config/emacs/bin:$PATH"
    '';

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
      emacs = "emacs --init-directory=~/.config/emacs";
      #      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      cat = "bat";
      man = "batman";
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
    };
  };
}
