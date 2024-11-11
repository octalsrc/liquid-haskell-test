let
  # This commit was the head of nixos-unstable on 2024-11-08
  nixpkgsCommit = "4aa36568d413aca0ea84a1684d2d46f55dbabad7";
  nixpkgsUrl = "https://github.com/NixOS/nixpkgs/archive/${nixpkgsCommit}.tar.gz";
  pkgs = import (fetchTarball nixpkgsUrl) {};

in

pkgs
