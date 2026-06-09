{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    kernelModules = [
      "i2c-dev"
      "ddcci_backlight"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.sg_display=0" ];
    initrd.luks.devices."luks-4d8efd9c-86f7-4d54-b70a-d3914f002ad8".device =
      "/dev/disk/by-uuid/4d8efd9c-86f7-4d54-b70a-d3914f002ad8";

  };
}
