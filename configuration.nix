{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

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
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    fprintd = {
      enable = true;
      package = pkgs.fprintd.override { libfprint = pkgs.libfprint-tod; };
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };

    fwupd.enable = true;

    keyd = {
      enable = true;

      keyboards.default = {
        # all keyboards
        ids = [ "*" ];
        settings.main = {
          # Caps Lock = Ctrl when held, Esc when tapped
          capslock = "overload(control, esc)";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing = {
      enable = true;
      drivers = [
        pkgs.brlaser
      ];
    };
    pulseaudio.enable = false;

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

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        helium
      '';
      mode = "0755";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git

    ## gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.copyous
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
    noto-fonts
    noto-fonts-color-emoji
  ];

  security = {
    rtkit.enable = true;
    pam.services = {
      gdm.fprintAuth = true;
      gdm-password.fprintAuth = true;
      sudo.fprintAuth = true;
    };
  };
  system.stateVersion = "25.11";
}
