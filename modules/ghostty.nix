{ pkgs, ... }:
{
  systemd.packages = [ pkgs.ghostty ];
  # make Ghostty start up go vroom vroom
  systemd.user.services."app-com.mitchellh.ghostty" = {
    wantedBy = [ "graphical-session.target" ];
    # without this, NixOS injects a minimal PATH drop-in that hides the
    # user profile from every shell Ghostty spawns
    enableDefaultPath = false;
  };
}
