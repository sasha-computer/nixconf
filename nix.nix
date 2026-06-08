{ pkgs, ...}:
{
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d --delete-generations +5";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    optimise.automatic = true;
  };
  nixpkgs.config.allowUnfree = true;

  programs = {
   nix-ld.enable = true;

    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      gcc
      glibc
    ];

  };
}
