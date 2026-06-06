{ pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.sg_display=0" ];
    initrd.luks.devices."luks-4d8efd9c-86f7-4d54-b70a-d3914f002ad8".device =
      "/dev/disk/by-uuid/4d8efd9c-86f7-4d54-b70a-d3914f002ad8";

  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;

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

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };

    printing = {
      enable = true;
      drivers = [
        pkgs.brlaser
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    mullvad-vpn.enable = true;
  };

  programs = {
    fish.enable = true;
    nix-ld.enable = true;

    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      gcc
      glibc
    ];

    _1password-gui = {
      polkitPolicyOwners = [ "sasha" ];
    };

    dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            accent-color = "blue";
          };
          "org/gnome/desktop/input-sources" = {
            xkb-options = [
              "ctrl:nocaps"
              # "altwin:swap_alt_win"
            ];
          };
        };
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    ghostty
    ungoogled-chromium
    _1password-gui
    newsflash
    signal-desktop
    telegram-desktop
    slack
    spotify
    discord
    git
    btop
    mullvad-vpn
    anki-bin
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.copyous
    gnomeExtensions.paperwm
    nerd-fonts.jetbrains-mono
    sticky-notes
    zed-editor
    bat
    nil
    nixd
    gh
    bun
    devenv
    opencode
    claude-code
    localsend
    libreoffice-fresh
    smile
    obsidian
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    OPENCODE_ENABLE_EXA = "1";
  };

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
  ];

  security.rtkit.enable = true;
  system.stateVersion = "25.11";
}
