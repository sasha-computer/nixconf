# Niri config lives in dotfiles/niri/config.kdl.
# programs.niri pulls in xdg portals (gnome+gtk), the GDM session entry,
# and gnome-keyring. Niri auto-spawns xwayland-satellite from PATH for
# X11 apps — no config needed.
{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    brightnessctl
  ];
}
