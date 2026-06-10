{ lib, ... }:
let
  dotfilesPath = "/home/sasha/NixOS/dotfiles";
  entries = lib.filterAttrs (name: _: name != "claude") (builtins.readDir ../dotfiles);
in
{
  home-manager.users.sasha =
    { config, ... }:
    {
      xdg.configFile = lib.mapAttrs' (
        name: _type:
        lib.nameValuePair name {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${name}";
        }
      ) entries;

      home.file.".claude/skills".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/claude/skills";
    };
}
