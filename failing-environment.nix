let
  # This commit was the head of nixos-unstable on 2024-11-08
  nixpkgsCommit = "4aa36568d413aca0ea84a1684d2d46f55dbabad7";
  nixpkgsUrl = "https://github.com/NixOS/nixpkgs/archive/${nixpkgsCommit}.tar.gz";
  pkgs = import (fetchTarball nixpkgsUrl) {};

  inherit (pkgs.haskell.lib) unmarkBroken overrideCabal;

  myHaskellPackages = pkgs.haskell.packages.ghc9101.override {
    overrides = self: super: rec {
      # Remove spurious broken flag for liquid-fixpoint
      liquid-fixpoint = unmarkBroken super.liquid-fixpoint;
      # Add z3 executable to build env for liquidhaskell
      liquidhaskell = overrideCabal
        super.liquidhaskell
        (old: {
          libraryToolDepends = [ pkgs.z3 ];
        });
      # Add z3 executable to test env for smtlib-backends-process,
      # remove broken flag (that I assume was there due to the tests
      # failing without z3).
      smtlib-backends-process = overrideCabal
        super.smtlib-backends-process
        (old: {
          testToolDepends = [ pkgs.z3 ];
          broken = false;
        });
      time-compat = overrideCabal
        super.time-compat
        (old: {
          version = "1.9.7";
          # src = fetchTarball "https://hackage.haskell.org/package/time-compat-1.9.7/time-compat-1.9.7.tar.gz";
          revision = "2";
          sha256 = "sha256-yY++oh0DbDJjrxht8FabhCXIetNTsCE1N5R0Pk5jHcw=";
          editedCabalFile = "sha256-8L/xWvb6rv82tnnmuBD6cVNLL4WpG/mNdUHaxqRpsg8=";
        });
    };
  };

  test-package = myHaskellPackages.mkDerivation {
    pname = "liquid-haskell-test";
    version = "0.1.0.0";
    src = ./.;
    
    libraryToolDepends = [
      pkgs.cabal-install
      # Need this for the liquidhaskell plugin
      pkgs.z3
    ];
    libraryHaskellDepends = [
      myHaskellPackages.base
      myHaskellPackages.liquidhaskell
    ];
    license = "unknown";
  };

in test-package.env
