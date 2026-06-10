{ pkgs, ... }:
{
  systemd.packages = [ pkgs.ghostty ];
  # make Ghostty start up go vroom vroom
  systemd.user.services."app-com.mitchellh.ghostty".wantedBy = [ "graphical-session.target" ];
}
