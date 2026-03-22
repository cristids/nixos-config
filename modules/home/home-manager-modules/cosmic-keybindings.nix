{ ... }:
{
  # COSMIC custom keybindings — only overrides and app launchers.
  # Navigation, workspaces, media keys are already in COSMIC defaults.
  # Overridden defaults noted inline.
  xdg.configFile."cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom".text = ''
    {
        // App launchers
        (modifiers: [Super], key: "Return"): Spawn("ghostty"),
        (modifiers: [Super, Shift], key: "Return"): System(Launcher),
        (modifiers: [Super], key: "w"): Spawn("mullvad-browser"),
        (modifiers: [Super], key: "e"): Spawn("emacsclient --alternate-editor= --create-frame"),
        (modifiers: [Super], key: "d"): Spawn("dolphin"),
        (modifiers: [Super, Shift], key: "d"): Spawn("doublecmd"),
        (modifiers: [Super], key: "p"): Spawn("1password"),
        (modifiers: [Super], key: "v"): Spawn("code"),
        (modifiers: [Super, Shift], key: "m"): Spawn("pavucontrol"),

        // Overrides (keys that conflict with COSMIC defaults)
        // default Super+y = ToggleTiling  →  yazi
        (modifiers: [Super], key: "y"): Spawn("kitty -e yazi"),
        // default Super+s = ToggleStacking  →  screenshot
        (modifiers: [Super], key: "s"): System(Screenshot),
        // default Super+o = ToggleOrientation  →  obs
        (modifiers: [Super], key: "o"): Spawn("obs"),
        // default Super+g = ToggleWindowFloating  →  gimp (floating moved to Super+Shift+F)
        (modifiers: [Super], key: "g"): Spawn("gimp"),
        // default Super+f = HomeFolder  →  fullscreen
        (modifiers: [Super], key: "f"): Fullscreen,
        // default Super+l = Focus(Right)  →  lock screen (use Super+Right arrow for focus)
        (modifiers: [Super], key: "l"): System(LockScreen),
        // default Super+w = WorkspaceOverview  →  browser (above)

        // Additions
        (modifiers: [Super, Shift], key: "f"): ToggleWindowFloating,
        (modifiers: [Super, Shift], key: "c"): Terminate,
    }
  '';
}
