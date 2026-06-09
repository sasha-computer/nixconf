#!/usr/bin/env bash
# One-shot activation of the restructure (run once, then delete me):
#   sh apply.sh
set -euo pipefail
cd /home/sasha/NixOS

# Move aside real config dirs that the new generation replaces with
# symlinks into dotfiles/ (home-manager can't replace a non-empty real
# dir with a symlink). Skipped automatically if already a symlink.
for d in fish ghostty helix zed git; do
  if [ -e "$HOME/.config/$d" ] && [ ! -L "$HOME/.config/$d" ]; then
    mv "$HOME/.config/$d" "$HOME/.config/$d.old"
    echo "moved ~/.config/$d -> ~/.config/$d.old"
  fi
done

# carry over fish universal variables (runtime state, gitignored)
if [ -f "$HOME/.config/fish.old/fish_variables" ]; then
  cp "$HOME/.config/fish.old/fish_variables" dotfiles/fish/
fi

sudo nixos-rebuild switch --flake .#fw13

echo
echo "=== symlink check (all should point into ~/NixOS/dotfiles) ==="
ls -ld ~/.config/fish ~/.config/ghostty ~/.config/helix ~/.config/zed \
  ~/.config/git ~/.config/starship.toml ~/.config/niri
echo
echo "Old configs kept at ~/.config/*.old — delete once everything works."
echo "Open a NEW terminal to check aliases + prompt, then log out and pick"
echo "the 'Niri' session via the gear icon on the GDM login screen."
