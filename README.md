# NixOS config (fw13)

One machine, one user. Two ideas:

**1. Every file in `modules/` is auto-imported.** No imports lists anywhere.
Each file is a normal NixOS module covering one concern (niri, shell, apps...),
with home-manager config inline in the same file:

```nix
{ pkgs, ... }:
{
  # system-level stuff
  programs.niri.enable = true;

  # user-level stuff, same file
  home-manager.users.sasha = {
    home.packages = [ pkgs.something ];
  };
}
```

To disable a module without deleting it, rename it with a `_` prefix
(`_gnome.nix` is skipped by import-tree).

**2. Nix installs, `dotfiles/` configures.** Every entry in `dotfiles/`
(dir or file) is symlinked to `~/.config/<name>`, pointing at the live repo —
so editing `dotfiles/helix/config.toml` applies immediately, no rebuild,
no Nix syntax. See `modules/dotfiles.nix`.

## How do I...

- **Install a program?** Add it to `home.packages` in the closest-matching
  module (or make a new file in `modules/`). `rebuild`.
- **Configure a program?** `mkdir dotfiles/<name>`, drop its config files in,
  `git add` it, `rebuild` once to create the symlink. After that, edit freely.
- **Change niri keybinds?** Edit `dotfiles/niri/config.kdl` — niri reloads it
  live. `niri validate` checks syntax.
- **Rebuild?** `rebuild` (alias for `sudo nixos-rebuild switch`; `/etc/nixos`
  symlinks here).

## Gotcha

New top-level entries in `dotfiles/` must be `git add`-ed before the rebuild
that creates their symlink — the flake only sees git-tracked files. (Edits to
files *inside* already-linked entries need nothing, not even a commit.)
