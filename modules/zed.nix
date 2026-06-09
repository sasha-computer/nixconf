# Temporary: replaced by raw dotfiles/zed/settings.json + keymap.json
# during the dotfiles migration.
{
  home-manager.users.sasha = {
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
  };
}
