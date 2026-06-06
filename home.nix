{ pkgs, ... }:
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
    vf = "nvim ~/.config/fish/config.fish";
  };
in
{
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";

  home.packages = with pkgs; [
    bat
    ripgrep
    dust
    jq
    claude-code
    ladybird
    ghostty
    helix
  ];

  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user.name = "Sasha";
      user.email = "33594434+sasha-computer@users.noreply.github.com";
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      gpg.ssh.allowdSignersFile = "~/.ssh/allowed_signers";
    };
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

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      confirm-close-surface = false;
      copy-on-select = "clipboard";
      font-size = 18;
      font-family = "CommitMono Nerd Font Mono";
      theme = "Catppuccin Mocha";
      quit-after-last-window-closed = false;

      keybind = [
        "ctrl+s>h=goto_split:left"
        "ctrl+s>j=goto_split:down"
        "ctrl+s>k=goto_split:up"
        "ctrl+s>l=goto_split:right"

        "ctrl+s>v=new_split:right"
        "ctrl+s>s=new_split:down"
        "ctrl+s>z=toggle_split_zoom"
        "ctrl+s>q=close_surface"
      ];
    };
    systemd.enable = true;
  };

  programs.helix = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = [
      "pure-preset"
      # "catppuccin-powerline"
      "nerd-font-symbols"
    ];
  };

  home.stateVersion = "25.11";
}
