set -g fish_greeting

set -gx BROWSER helium
set -gx OPENCODE_ENABLE_EXA 1

fish_add_path ~/.risc0/bin ~/.nargo/bin

if status is-interactive
    alias rebuild "sudo nixos-rebuild switch"

    alias cc "claude --dangerously-skip-permissions"
    alias cdd "cd ~/Developer/"

    alias gaa "git add ."
    alias gc "git checkout"
    alias gcb "git checkout -b"
    alias gcl "git clone"
    alias gcm "git commit -m"
    alias gf "git fetch"
    alias gfp "git fetch --prune"
    alias gl "git log --oneline"
    alias gpl "git pull"
    alias gp "git push"
    alias grv "git remote -v"
    alias gs "git status"

    alias h hx
    alias v nvim
    alias vf "nvim ~/.config/fish/config.fish"
    alias z zellij

    devenv hook fish | source
    starship init fish | source
end
