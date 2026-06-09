{ pkgs, ... }:
{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

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

    pulseaudio.enable = false;
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

    mullvad-vpn.enable = true;
  };
}
