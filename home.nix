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

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      font-size = 14;
      copy-on-select = "clipboard";
      keybind = [
        "ctrl+s=activate_key_table:split"

        "split/h=goto_split:left"
        "split/j=goto_split:down"
        "split/k=goto_split:up"
        "split/l=goto_split:right"

        "split/v=new_split:right"
        "split/s=new_split:down"

        "split/z=toggle_split_zoom"
        "split/+=equalize_splits"
        "split/c=close_surface"

        "split/escape=deactivate_key_table"
        "split/catch_all=ignore"
      ];
      # theme = "catppuccin-mocha";
      quit-after-last-window-closed = false;
    };

    systemd.enable = true;
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

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = [
      "pure-preset"
      "nerd-font-symbols"
    ];
  };

  home.stateVersion = "25.11";
}
