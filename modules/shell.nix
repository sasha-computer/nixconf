{ pkgs, ... }:
{
  programs.fish.enable = true;

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
      steel
      zellij
    ];
  };
}
