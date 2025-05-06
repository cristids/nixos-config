{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [ basedpyright ];
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
      }
      {
        name = "python";
        scope = "source.python";
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = " ";
        };
        formatter = {
          command = "${pkgs.black}/bin/black";
          args = [ "-" "-q" ];
        };
        debugger = {
          name = "debugpy";
          transport = "stdio";
          command = "python";
          args = [ "-m" "debugpy.adapter" ];
          templates = [{
            name = "source";
            request = "launch";
            completion = [{
              name = "entrypoint";
              completion = "filename";
              default = ".";
            }];
            args = {
              mode = "debug";
              program = "{0}";
            };
          }];
        };
        roots = [ "pyproject.toml" "pyrightconfig.json" "Poetry.lock" ];
        language-servers =
          [ { name = "basedpyright"; } { name = "ruff-lsp"; } ];
      }
    ];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
