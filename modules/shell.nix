{ pkgs, ... }:
let
  shellAliases = {
    rebuild = "sudo nixos-rebuild switch";

    cc = "claude --dangerously-skip-permissions";
    cdd = "cd ~/Developer/";

    gaa = "git add .";
    gc = "git checkout";
    gcb = "git checkout -b";
    gcl = "git clone";
    gcm = "git commit -m";
    gf = "git fetch";
    gfp = "git fetch --prune";
    gl = "git log --oneline";
    gpl = "git pull";
    gp = "git push";
    grv = "git remote -v";
    gs = "git status";

    h = "hx";
    v = "nvim";
    vf = "nvim ~/.config/fish/config.fish";
    z = "zellij";
  };
in
{
  programs.fish.enable = true;

  home-manager.users.sasha = {
    home.packages = with pkgs; [
      # command line tools
      bat
      ripgrep
      dust
      jq

      # nix
      nh
      nixd
      nil
      nixfmt

      # dev tools
      gh
      bun
      devenv
      marksman
      steel
      zellij
    ];

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
  };
}
