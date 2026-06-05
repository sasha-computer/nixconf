{ pkgs, ... }:

{
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";

  home.packages = with pkgs; [
    git
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

  home.stateVersion = "25.11";
}
