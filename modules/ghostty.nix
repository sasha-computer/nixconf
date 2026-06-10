{ pkgs, ... }:
{
  # ghostty daemon: resident GTK instance so `ghostty +new-window` opens via D-Bus (~20ms)
  systemd.packages = [ pkgs.ghostty ];
  systemd.user.services."app-com.mitchellh.ghostty".wantedBy = [ "graphical-session.target" ];
}
