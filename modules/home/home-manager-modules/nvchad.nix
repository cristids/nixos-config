{ config, pkgs, nvchadModule, ... }: 
{
  imports = [
    nvchadModule
  ];
  
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      # nodePackages.bash-language-server
      # docker-compose-language-service
      # dockerfile-language-server-nodejs
      # emmet-language-server
      tree-sitter
      tree-sitter-grammars.tree-sitter-python
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-lua
      lua-language-server
      fzf
      nixd
      ripgrep
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
        debugpy
        ruff
        black
        mypy
        
      ]))
    ];
    hm-activation = true;
    backup = true;
  };
}