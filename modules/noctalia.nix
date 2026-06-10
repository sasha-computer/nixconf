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
