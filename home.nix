{ pkgs, inputs, ... }:
let
  shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    cdd = "cd ~/Developer/";

    gl = "git log --oneline";
    gcm = "git commit -m";
    gaa = "git add .";
    gs = "git status";
    gf = "git fetch";
    gfp = "git fetch --prune";
    gpl = "git pull";
    gp = "git push";
    gc = "git checkout";
    gcb = "git checkout -b";
    gcl = "git clone";
    grv = "git remote -v";
    cc = "claude --dangerously-skip-permissions";
    v = "nvim";
    h = "hx";
    vf = "nvim ~/.config/fish/config.fish";
  };
in
{
  imports = [
    ./zed.nix
    ./terminal.nix
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";

  home.packages = with pkgs; [
    # command line tools
    bat
    ripgrep
    dust
    jq

    # terminal
    ghostty
    claude-code
    opencode

    # nix
    nh
    nixd
    nil

    # messaging
    signal-desktop
    telegram-desktop
    slack
    discord

    # privacy/security
    _1password-gui
    mullvad-vpn
    tor-browser
    gnome-boxes

    # dev tools
    gh
    bun
    devenv
    marksman
    zellij

    # editors
    obsidian
    libreoffice-fresh
    helix

    # entertainment
    newsflash
    spotify

    # tools
    anki-bin
    localsend
    smile

  ];

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.chromium = {
    enable = true;
    package = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.fish = {
    enable = true;
    shellAliases = shellAliases;
    interactiveShellInit = ''
      set fish_greeting
      devenv hook fish | source
      export PATH="$PATH:/home/sasha/.risc0/bin"
      export PATH="$PATH:/home/sasha/.nargo/bin"
    '';
  };

  xdg.configFile."autostart/mullvad-vpn.desktop".source =
    "${pkgs.mullvad-vpn}/share/applications/mullvad-vpn.desktop";

  # xresources.properties = {
  #   "Xft.dpi" = 192;
  #   "Xcursor.size" = 32;
  # };

  # xsession.windowManager.i3 = {
  #   enable = true;
  # };

  home.stateVersion = "25.11";
}
