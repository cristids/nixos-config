{
  pkgs,
  unstable,
  vscode_exts,
  ...
}: {
  programs.vscode = {
    enable = true;
    profiles.default.enableUpdateCheck = false;
    profiles.default.enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    # Extensions
    profiles.default.extensions =
      (with pkgs.vscode-extensions; [
        #vscode
        ms-vscode-remote.remote-ssh
        github.copilot
        github.copilot-chat
        #pkief.material-icon-theme

        #python
        ms-python.python
        ms-python.black-formatter
        ms-python.flake8
        ms-python.mypy-type-checker
        ms-python.vscode-pylance
        ms-python.pylint
        charliermarsh.ruff

        #nix
        jnoortheen.nix-ide
        #oops418.nix-env-picker
      ])
      ++ (with vscode_exts; [
        #sql server
        ms-mssql.mssql
        ms-mssql.sql-database-projects-vscode
      ])
      ++ (with unstable.vscode-extensions; [
        # Unstable
      ]);

    # Settings
    profiles.default.userSettings = {
      # General
      # "editor.fontSize" = 16;
      "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', Menlo, Monaco, 'Courier New', monospace, 'Droid Sans Fallback'";
      # "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'FuraCode Nerd Font Mono', 'FiraCode Nerd Font Mono', 'JetBrainsMono Nerd Font', 'monospace', monospace";
      # "window.zoomLevel" = 1;
      # "editor.multiCursorModifier" = "ctrlCmd";
      # "workbench.startupEditor" = "none";
      # "explorer.compactFolders" = false;
      # Whitespace
      # "files.trimTrailingWhitespace" = true;
      # "files.trimFinalNewlines" = true;
      # "files.insertFinalNewline" = true;
      # "diffEditor.ignoreTrimWhitespace" = false;
      # Git
      # "git.enableCommitSigning" = true;
      # "git-graph.repository.sign.commits" = true;
      # "git-graph.repository.sign.tags" = true;
      # "git-graph.repository.commits.showSignatureStatus" = true;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;

      # Styling
      # "window.autoDetectColorScheme" = true;
      # "workbench.preferredDarkColorTheme" = "Default Dark Modern";
      # "workbench.preferredLightColorTheme" = "Default Light Modern";
      # "workbench.iconTheme" = "material-icon-theme";
      # "material-icon-theme.activeIconPack" = "none";
      # "material-icon-theme.folders.theme" = "classic";
      # Other
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;
      # # Gitmoji
      # "gitmoji.onlyUseCustomEmoji" = true;
      # "gitmoji.addCustomEmoji" = [
      #   {
      #     "emoji" = "📦 NEW:";
      #     "code" = ":package: NEW:";
      #     "description" = "... Add new code/feature";
      #   }
      #   {
      #     "emoji" = "👌 IMPROVE:";
      #     "code" = ":ok_hand: IMPROVE:";
      #     "description" = "... Improve existing code/feature";
      #   }
      #   {
      #     "emoji" = "❌ REMOVE:";
      #     "code" = ":x: REMOVE:";
      #     "description" = "... Remove existing code/feature";
      #   }
      #   {
      #     "emoji" = "🐛 FIX:";
      #     "code" = ":bug: FIX:";
      #     "description" = "... Fix a bug";
      #   }
      #   {
      #     "emoji" = "📑 DOC:";
      #     "code" = ":bookmark_tabs: DOC:";
      #     "description" = "... Anything related to documentation";
      #   }
      #   {
      #     "emoji" = "🤖 TEST:";
      #     "code" = ":robot: TEST:";
      #     "description" = "... Anything realted to tests";
      #   }
      # ];

      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.formatOnSave" = true;
      };
    };

    # # Keybindings
    # keybindings = [
    #   {
    #     key = "ctrl+y";
    #     command = "editor.action.commentLine";
    #     when = "editorTextFocus && !editorReadonly";
    #   }
    #   {
    #       key = "ctrl+shift+7";
    #       command = "-editor.action.commentLine";
    #       when = "editorTextFocus && !editorReadonly";
    #   }
    #   {
    #       key = "ctrl+d";
    #       command = "workbench.action.toggleSidebarVisibility";
    #   }
    #   {
    #       key = "ctrl+b";
    #       command = "-workbench.action.toggleSidebarVisibility";
    #   }
    # ];
  };
  # environment.persistence."/persist".users.cristian.directories = [ ".config/Code" ];
}
