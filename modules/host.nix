{ pkgs, ... }:
{
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

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  fonts.enableDefaultPackages = true;
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
    newcomputermodern
  ];

  security = {
    rtkit.enable = true;
    pam.services = {
      sudo.fprintAuth = false;
    };
  };

  system.stateVersion = "25.11";
}
