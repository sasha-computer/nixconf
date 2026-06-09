{ pkgs, ... }:
{
  users.users.sasha = {
    isNormalUser = true;
    description = "sasha";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
}
