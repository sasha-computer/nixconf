{
  description = "Sasha's NixOS config flake";

  inputs = {
    nixpgks.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      nixosConfigurations.fw13 = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
      };
    };
}
