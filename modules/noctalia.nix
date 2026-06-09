# Noctalia shell (bar, launcher, notifications, lock screen, wallpaper).
# Started by niri via spawn-at-startup in dotfiles/niri/config.kdl.
# Its own settings live in ~/.config/noctalia/, managed by its settings GUI.
{ inputs, pkgs, ... }:
{
  nix.settings = {
    substituters = [ "https://noctalia.cachix.org" ];
    trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  home-manager.users.sasha = {
    home.packages = [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
}
