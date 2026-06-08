{ pkgs, ... }:
{
  services = {
    displayManager.defaultSession = "none+i3";
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;

    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          # i3blocks
        ];
      };
    };
  };
}
