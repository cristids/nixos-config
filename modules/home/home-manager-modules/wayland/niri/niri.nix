#Kudos to https://vlaci.github.io/nix.org/posts/niri
#
#Home nixos niri settings, the package is enabled at core level

{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}:

{
  programs.fuzzel.enable = true;
  #_.persist.allUsers.directories = [ ".local/state/wireplumber" ];
  #_.persist.users.cristian.files = [ ".cache/fuzzel" ];

  home.packages = with pkgs; [
    wl-clipboard
    #mako
    libnotify
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "None";
    };
  };

  # programs.kitty = {
  #   enable = true;
  #   settings = {
  #     window_border_width = "0px";
  #     tab_bar_edge = "top";
  #     tab_bar_margin_width = "0.0";
  #     tab_bar_style = "fade";
  #     placement_strategy = "top-left";
  #     hide_window_decorations = true;
  #   };
  # };

  programs.fuzzel = {
    settings.main.launch-prefix = "niri msg action spawn --";
    settings.main.terminal = "foot";
  };

  # services.mako = {
  #   enable = true;
  #   borderRadius = 8;
  #   format = "%a\n%s\n%b";
  # };

  #programs.waybar.systemd.enable = true;
  systemd.user.services."waybar".Service.ExecReload = lib.mkForce "";

  programs.niri.settings = {
    prefer-no-csd = true; # disable windows decorations

    layout = {
      gaps = 16;
      struts.left = 64;
      struts.right = 64;
      border.width = 4;
      always-center-single-column = true;

      empty-workspace-above-first = true;

      # fog of war
      # focus-ring = {
      #   # enable = true;
      #   width = 10000;
      #   active.color = "#00000055";
      # };
      border.active.gradient = {
        from = "red";
        to = "blue";
        in' = "oklch shorter hue";
      };

      shadow.enable = true;

      # default-column-display = "tabbed";

      tab-indicator = {
        position = "top";
        gaps-between-tabs = 10;

        # hide-when-single-tab = true;
        # place-within-column = true;

        # active.color = "red";
      };
    };

    #hotkey-overlay.skip-at-startup = !nixosConfig.is-virtual-machine;
    clipboard.disable-primary = true;

    overview.zoom = 0.5;

    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";

    switch-events =
      with config.lib.niri.actions;
      let
        sh = spawn "sh" "-c";
      in
      {
        tablet-mode-on.action = sh "notify-send tablet-mode-on";
        tablet-mode-off.action = sh "notify-send tablet-mode-off";
        lid-open.action = sh "notify-send lid-open";
        lid-close.action = sh "notify-send lid-close";
      };

    environment = {
      #XDG_CURRENT_DESKTOP = "niri";
      #XDG_SESSION_DESKTOP = "niri";
      #XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      MOZ_ENABLE_WAYLAND = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      XDG_MENU_PREFIX = "plasma-";
      GDK_BACKEND = "wayland, x11";
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "Breeze";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "x11";
      AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
      GDK_SCALE = "1";
      QT_SCALE_FACTOR = "1";
      EDITOR = "nvim";
    };

    input = {
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
      keyboard.xkb = with nixosConfig.services.xserver.xkb; {
        inherit variant layout options;
      };
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
        click-method = "clickfinger";
      };
      tablet.map-to-output = "eDP-1";
      touch.map-to-output = "eDP-1";
    };
    window-rules = [
      {
        matches = [ { app-id = "authentication-agent-1|pwvucontrol"; } ];
        open-floating = true;
      }
    ];
    binds =
      with config.lib.niri.actions;
      let
        mod = if nixosConfig.virtualisation ? qemu then "Alt" else "Mod";
        set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
        brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
        playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
      in
      {
        "${mod}+Shift+Slash".action = show-hotkey-overlay;
        "${mod}+D".action = spawn "fuzzel";
        "${mod}+Return".action = spawn "alacritty";
        "Super+Alt+L".action =
          spawn "sh" "-c"
            "loginctl lock-session && sleep 5 && niri msg action power-off-monitors";

        XF86AudioRaiseVolume.action = set-volume "5%+";
        XF86AudioLowerVolume.action = set-volume "5%-";
        XF86AudioMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        XF86AudioMicMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

        XF86AudioPlay.action = playerctl "play-pause";
        XF86AudioStop.action = playerctl "pause";
        XF86AudioPrev.action = playerctl "previous";
        XF86AudioNext.action = playerctl "next";

        XF86MonBrightnessUp.action = brillo "-A" "5";
        XF86MonBrightnessDown.action = brillo "-U" "5";

        # // Open/close the Overview: a zoomed-out view of workspaces and windows.
        # // You can also move the mouse into the top-left hot corner,
        # // or do a four-finger swipe up on a touchpad.
        "${mod}+O" = {
          action = toggle-overview;
          repeat = false;
        };

        "${mod}+Shift+Q".action = close-window;
        "${mod}+Left".action = focus-column-left;
        "${mod}+Down".action = focus-window-down;
        "${mod}+Up".action = focus-window-up;
        "${mod}+Right".action = focus-column-right;
        "${mod}+H".action = focus-column-left;
        "${mod}+J".action = focus-window-down;
        "${mod}+K".action = focus-window-up;
        "${mod}+L".action = focus-column-right;

        "${mod}+Ctrl+Left".action = move-column-left-or-to-monitor-left;
        "${mod}+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "${mod}+Ctrl+Up".action = move-window-up-or-to-workspace-up;
        "${mod}+Ctrl+Right".action = move-column-right-or-to-monitor-right;
        "${mod}+Ctrl+H".action = move-column-left-or-to-monitor-left;
        "${mod}+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "${mod}+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "${mod}+Ctrl+L".action = move-column-right-or-to-monitor-right;

        "${mod}+Home".action = focus-column-first;
        "${mod}+End".action = focus-column-last;
        "${mod}+Ctrl+Home".action = move-column-to-first;
        "${mod}+Ctrl+End".action = move-column-to-last;

        "${mod}+Shift+Left".action = focus-monitor-left;
        "${mod}+Shift+Down".action = focus-monitor-down;
        "${mod}+Shift+Up".action = focus-monitor-up;
        "${mod}+Shift+Right".action = focus-monitor-right;
        "${mod}+Shift+H".action = focus-monitor-left;
        "${mod}+Shift+J".action = focus-monitor-down;
        "${mod}+Shift+K".action = focus-monitor-up;
        "${mod}+Shift+L".action = focus-monitor-right;

        "${mod}+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "${mod}+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "${mod}+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "${mod}+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "${mod}+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "${mod}+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "${mod}+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "${mod}+Shift+Ctrl+L".action = move-column-to-monitor-right;

        # // Alternatively, there are commands to move just a single window:
        # // ${mod}+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # // ...

        # // And you can also move a whole workspace to another monitor:
        # // ${mod}+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        # // ...

        "${mod}+Page_Down".action = focus-workspace-down;
        "${mod}+Page_Up".action = focus-workspace-up;
        "${mod}+U".action = focus-workspace-down;
        "${mod}+I".action = focus-workspace-up;
        "${mod}+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "${mod}+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "${mod}+Ctrl+U".action = move-column-to-workspace-down;
        "${mod}+Ctrl+I".action = move-column-to-workspace-up;
        # // Alternatively, there are commands to move just a single window:
        # // ${mod}+Ctrl+Page_Down { move-window-to-workspace-down; }
        # // ...

        "${mod}+Shift+Page_Down".action = move-workspace-down;
        "${mod}+Shift+Page_Up".action = move-workspace-up;
        "${mod}+Shift+U".action = move-workspace-down;
        "${mod}+Shift+I".action = move-workspace-up;

        # // You can bind mouse wheel scroll ticks using the following syntax.
        # // These binds will change direction based on the natural-scroll setting.
        # //
        # // To avoid scrolling through workspaces really fast, you can use
        # // the cooldown-ms property. The bind will be rate-limited to this value.
        # // You can set a cooldown on any bind, but it's most useful for the wheel.
        "${mod}+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "${mod}+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "${mod}+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "${mod}+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "${mod}+WheelScrollRight".action = focus-column-right;
        "${mod}+WheelScrollLeft".action = focus-column-left;
        "${mod}+Ctrl+WheelScrollRight".action = move-column-right;
        "${mod}+Ctrl+WheelScrollLeft".action = move-column-left;

        # // Usually scrolling up and down with Shift in applications results in
        # // horizontal scrolling; these binds replicate that.
        "${mod}+Shift+WheelScrollDown".action = focus-column-right;
        "${mod}+Shift+WheelScrollUp".action = focus-column-left;
        "${mod}+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "${mod}+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        # // Similarly, you can bind touchpad scroll "ticks".
        # // Touchpad scrolling is continuous, so for these binds it is split into
        # // discrete intervals.
        # // These binds are also affected by touchpad's natural-scroll, so these
        # // example binds are "inverted", since we have natural-scroll enabled for
        # // touchpads by default.
        # // ${mod}+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # // ${mod}+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

        # // You can refer to workspaces by index. However, keep in mind that
        # // niri is a dynamic workspace system, so these commands are kind of
        # // "best effort". Trying to refer to a workspace index bigger than
        # // the current workspace count will instead refer to the bottommost
        # // (empty) workspace.
        # //
        # // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # // will all refer to the 3rd workspace.
        "${mod}+1".action = focus-workspace 1;
        "${mod}+2".action = focus-workspace 2;
        "${mod}+3".action = focus-workspace 3;
        "${mod}+4".action = focus-workspace 4;
        "${mod}+5".action = focus-workspace 5;
        "${mod}+6".action = focus-workspace 6;
        "${mod}+7".action = focus-workspace 7;
        "${mod}+8".action = focus-workspace 8;
        "${mod}+9".action = focus-workspace 9;

        # The wonky format used here is to work-around https://github.com/sodiboo/niri-flake/issues/944
        "${mod}+Ctrl+1".action.move-column-to-workspace = [ 1 ];
        "${mod}+Ctrl+2".action.move-column-to-workspace = [ 2 ];
        "${mod}+Ctrl+3".action.move-column-to-workspace = [ 3 ];
        "${mod}+Ctrl+4".action.move-column-to-workspace = [ 4 ];
        "${mod}+Ctrl+5".action.move-column-to-workspace = [ 5 ];
        "${mod}+Ctrl+6".action.move-column-to-workspace = [ 6 ];
        "${mod}+Ctrl+7".action.move-column-to-workspace = [ 7 ];
        "${mod}+Ctrl+8".action.move-column-to-workspace = [ 8 ];
        "${mod}+Ctrl+9".action.move-column-to-workspace = [ 9 ];

        # // Alternatively, there are commands to move just a single window:
        # // ${mod}+Ctrl+1 { move-window-to-workspace 1; }

        # // Switches focus between the current and the previous workspace.
        # // ${mod}+Tab { focus-workspace-previous; }

        "${mod}+Comma".action = consume-window-into-column;
        "${mod}+Period".action = expel-window-from-column;

        # There are also commands that consume or expel a single window to the side.
        "${mod}+BracketLeft".action = consume-or-expel-window-left;
        "${mod}+BracketRight".action = consume-or-expel-window-right;

        "${mod}+R".action = switch-preset-column-width;
        "${mod}+Shift+R".action = reset-window-height;
        "${mod}+F".action = maximize-column;
        "${mod}+Shift+F".action = fullscreen-window;
        "${mod}+C".action = center-column;

        # // Finer width adjustments.
        # // This command can also:
        # // * set width in pixels: "1000"
        # // * adjust width in pixels: "-5" or "+5"
        # // * set width as a percentage of screen width: "25%"
        # // * adjust width as a percentage of screen width: "-10%" or "+10%"
        # // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # // set-column-width "100" will make the column occupy 200 physical screen pixels.
        "${mod}+Minus".action = set-column-width "-10%";
        "${mod}+Equal".action = set-column-width "+10%";

        # // Finer height adjustments when in column with other windows.
        "${mod}+Shift+Minus".action = set-window-height "-10%";
        "${mod}+Shift+Equal".action = set-window-height "+10%";

        # // Move the focused window between the floating and the tiling layout.
        "${mod}+V".action = toggle-window-floating;
        "${mod}+Shift+V".action = switch-focus-between-floating-and-tiling;

        # // Toggle tabbed column display mode.
        # // Windows in this column will appear as vertical tabs,
        # // rather than stacked on top of each other.
        "${mod}+W".action = toggle-column-tabbed-display;

        # // Actions to switch layouts.
        # // Note: if you uncomment these, make sure you do NOT have
        # // a matching layout switch hotkey configured in xkb options above.
        # // Having both at once on the same hotkey will break the switching,
        # // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # // ${mod}+Space       { switch-layout "next"; }
        # // ${mod}+Shift+Space { switch-layout "prev"; }

        "Print".action = screenshot;
        "Alt+Print".action = screenshot-window;

        # // The quit action will show a confirmation dialog to avoid accidental exits.
        "${mod}+Shift+E".action = quit;

        # // Powers off the monitors. To turn them back on, do any input like
        # // moving the mouse or pressing any other key.
        "${mod}+Shift+P".action = power-off-monitors;
      };
    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "${lib.getExe pkgs.networkmanagerapplet}" ]; }
      { command = [ "${lib.getExe pkgs.xwayland-satellite}" ]; }
    ];
    environment."DISPLAY" = ":0";
  };
}
