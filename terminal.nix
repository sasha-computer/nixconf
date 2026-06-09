{
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
    systemd.enable = true;

    settings = {
      confirm-close-surface = false;
      copy-on-select = "clipboard";
      font-size = 14;
      font-family = "CommitMono Nerd Font Mono";
      theme = "GitHub Dark High Contrast";
      quit-after-last-window-closed = false;
      window-decoration = "none";
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
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        auto-save = {
          focus-lost = true;
        };
      };
      theme = "dark_high_contrast";
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
        }
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = [
      "pure-preset"
      "nerd-font-symbols"
    ];
  };
}
