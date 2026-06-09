# Every entry (dir or file) under dotfiles/ becomes ~/.config/<name> as a
# symlink to the live repo — edits apply instantly, no rebuild needed.
#
# Adding config for a new program: mkdir dotfiles/<name>, put files in it,
# git add it, rebuild once to create the symlink. After that, edit freely.
{ lib, ... }:
let
  # Absolute string (not a nix path) => symlink points outside the store,
  # straight at the working tree.
  dotfilesPath = "/home/sasha/NixOS/dotfiles";
  # readDir sees the flake's store copy: only git-tracked entries show up.
  entries = builtins.readDir ../dotfiles;
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
    };
}
