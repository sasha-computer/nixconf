# Fingerprint Reader Fix (Goodix 27c6:533c on Framework 13)

**Issue:** `fprintd-tod` 1.90.9 (the TOD fork in nixpkgs) is 3 years old and incompatible with `libfprint-tod` 1.94.9+, causing enrollments to not persist and GNOME Settings to hide the fingerprint option.

**Fix:** Override `fprintd` to use the standard upstream package built against `libfprint-tod`.

```nix
services.fprintd = {
  enable = true;
  package = pkgs.fprintd.override { libfprint = pkgs.libfprint-tod; };
  tod = {
    enable = true;
    driver = pkgs.libfprint-2-tod1-goodix;
  };
};
```

**Steps if you hit this again:**
1. Stop fprintd: `sudo systemctl stop fprintd`
2. Clear local DB: `sudo rm -rf /var/lib/fprint/*`
3. Wipe device storage: `sudo nix develop "github:nixvital/fprint-clear" --command fprint-clear`
4. Rebuild: `sudo nixos-rebuild switch`
5. Re-enroll: `fprintd-enroll` (lift & re-tap, don't swipe)

**Refs:**
- Wipe tool: https://github.com/nixvital/fprint-clear
- NixOS fingerprint wiki: https://wiki.nixos.org/wiki/Fingerprint_scanner
- NixOS discourse thread: https://discourse.nixos.org/t/fprintd-enroll-doesnt-add-fingerprint-no-error-message/35664
