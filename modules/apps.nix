{ pkgs, inputs, ... }:
{
  programs._1password-gui = {
    polkitPolicyOwners = [ "sasha" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        helium
      '';
      mode = "0755";
    };
  };

  home-manager.users.sasha = {
    home.packages = with pkgs; [
      # terminal
      ghostty
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      opencode

      # messaging
      # force libsecret: Signal's db key lives in gnome-keyring from the GNOME
      # days, and Electron's backend auto-detection picks basic_text under niri
      (symlinkJoin {
        name = "signal-desktop";
        paths = [ signal-desktop ];
        nativeBuildInputs = [ makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/signal-desktop \
            --add-flags "--password-store=gnome-libsecret"
        '';
      })
      telegram-desktop
      slack
      discord

      # privacy/security
      _1password-gui
      mullvad-vpn
      tor-browser
      gnome-boxes

      # editors
      obsidian
      libreoffice-fresh
      helix
      zed-editor
      neovim

      # entertainment
      newsflash
      spotify

      # tools
      anki-bin
      localsend
      smile
    ];

    programs.chromium = {
      enable = true;
      package = pkgs.symlinkJoin {
        name = "helium-scaled";
        paths = [ inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/helium \
            --add-flags "--force-device-scale-factor=1.4"
        '';
      };
    };

    xdg.configFile."autostart/mullvad-vpn.desktop".source =
      "${pkgs.mullvad-vpn}/share/applications/mullvad-vpn.desktop";
  };
}
