{ pkgs, ... }:
{
  services = {
    # displayManager.defaultSession = "none+i3";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # xserver = {
    #   enable = true;
    #   dpi = 150;

    #   windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #       dmenu
    #       i3status
    #       # i3blocks
    #     ];
    #   };
    # };
    #

  };

  environment.systemPackages = with pkgs; [
    ## gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.copyous
  ];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "blue";
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [
            "ctrl:nocaps"
            # "altwin:swap_alt_win"
          ];
        };
      };
    }
  ];
}
