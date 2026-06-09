# Fish config (aliases etc) lives in dotfiles/fish/config.fish,
# starship prompt in dotfiles/starship.toml.
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
