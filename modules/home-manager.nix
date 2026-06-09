{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";

    users.sasha = {
      home.username = "sasha";
      home.homeDirectory = "/home/sasha";
      home.stateVersion = "25.11";
    };
  };
}
