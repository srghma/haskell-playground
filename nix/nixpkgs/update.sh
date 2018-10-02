#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-git

SCRIPT_DIR=$(dirname "$(readlink -f "$BASH_SOURCE")")
nix-prefetch-git https://github.com/nixos/nixpkgs-channels --rev refs/heads/nixos-unstable > "$SCRIPT_DIR/revision.json"
