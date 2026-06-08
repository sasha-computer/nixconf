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
    vf = "nvim ~/.config/fish/config.fish";
  };
in
{
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

  programs.chromium = {
    enable = true;
    package = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

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
    systemd.enable = true;

    settings = {
      confirm-close-surface = false;
      copy-on-select = "clipboard";
      font-size = 14;
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
  };

  programs.helix = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = [
      "pure-preset"
      "nerd-font-symbols"
    ];
  };

  programs.zed-editor = {
    enable = true;
    # mutableUserSettings = true;
    userSettings = {
      tabs.git_status = false;
      title_bar = {
        show_branch_status_icon = false;
        show_sign_in = false;
      };
      debugger.button = false;
      search.button = false;
      diagnostics.button = false;
      status_bar = {
        cursor_position_button = false;
        active_language_button = false;
      };
      tab_bar.show = false;
      vim.toggle_relative_line_numbers = true;
      buffer_font_family = "CommitMono Nerd Font Mono";
      terminal = {
        button = false;
        font_family = "CommitMono Nerd Font Mono";
        font_size = 14;
      };
      project_panel = {
        button = true;
        dock = "left";
      };
      autosave = "on_focus_change";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      session = {
        trust_all_worktrees = true;
      };
      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 16.0;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Catppuccin Macchiato";
      };
    };
    userKeymaps = [
      {
        bindings = {
          "ctrl-s" = "workspace::ToggleLeftDock";
          "ctrl-shift-s" = "workspace::ToggleRightDock";
          "ctrl-j" = "workspace::ToggleBottomDock";
        };
      }
    ];
  };

  xdg.configFile."autostart/mullvad-vpn.desktop".source =
    "${pkgs.mullvad-vpn}/share/applications/mullvad-vpn.desktop";

  home.stateVersion = "25.11";
}
