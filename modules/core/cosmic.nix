{...}:
{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-bg
    cosmic-osd
    cosmic-term
    cosmic-idle
    cosmic-edit
    cosmic-comp
    cosmic-store
    cosmic-randr
    cosmic-panel
    cosmic-icons
    cosmic-files
    cosmic-player
    cosmic-session
    cosmic-greeter
    cosmic-ext-ctl
    cosmic-applets
    cosmic-settings
    cosmic-launcher
    cosmic-protocols
    cosmic-wallpapers
    cosmic-screenshot
    cosmic-ext-tweaks
    cosmic-applibrary
    cosmic-design-demo
    cosmic-notifications
    cosmic-ext-calculator
    cosmic-settings-daemon
    cosmic-workspaces-epoch
    xdg-desktop-portal-cosmic
    tasks

  ];
}