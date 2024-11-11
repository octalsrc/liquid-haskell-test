let
  pkgs = import ./pkgs.nix;

in

pkgs.mkShell {
  buildInputs = [
    pkgs.haskell.compiler.ghc9101
    pkgs.cabal-install
    pkgs.z3
  ];
}
