{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.kitty_term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 75%"
    max_size = "1920px 100%"
    position = "150px 150px"

    [scratchpads.alacritty_term]
    animation = "fromTop"
    command = "alacritty --class AlacrittyDrop"
    class = "Alacritty"
    lazy = true
    size = "90% 90%"
    excludes = "*"
  '';
}
