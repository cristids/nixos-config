{
  pkgs,
  config,
  nixCats,
  ...
}: {
  imports = [
    nixCats.homeModule
  ];

  programs.nixCats.enable = true;
}

