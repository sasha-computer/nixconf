{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./desktop.nix
    ./nix.nix
    ./services.nix
  ];

  users.users.sasha = {
    isNormalUser = true;
    description = "sasha";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  networking = {
    hostName = "fw13";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  programs = {
    fish.enable = true;

    _1password-gui = {
      polkitPolicyOwners = [ "sasha" ];
    };

  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        helium
      '';
      mode = "0755";
    };
  };

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-mono
    nerd-fonts.geist-mono
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.commit-mono
    nerd-fonts.zed-mono
    noto-fonts
    noto-fonts-color-emoji
  ];

  security = {
    rtkit.enable = true;
    pam.services = {
      # gdm.fprintAuth = true;
      # gdm-password.fprintAuth = true;
      sudo.fprintAuth = true;
    };
  };
  system.stateVersion = "25.11";
}
