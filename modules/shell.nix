{ pkgs, ... }:
{
  programs.fish.enable = true;
  programs.direnv.enable = true;
  programs.direnv.settings.global.hide_env_diff = true;

  environment.variables.EDITOR = "hx";

  home-manager.users.sasha = {
    home.packages = with pkgs; [
      # command line tools
      bat
      ripgrep
      dust
      jq

      # prompt
      starship

      # nix
      nh
      nixd
      nil
      nixfmt

      # typst
      typst
      typst-live
      tinymist

      # dev tools
      gh
      bun
      devenv
      marksman
      zellij
    ];
  };
}
