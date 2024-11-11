Liquid Haskell works when `cabal` downloads and builds its
dependencies directly from Hackage, but fails when the dependencies
are provided through nixpkgs.

The `cabal.project.freeze` file in this repository was generated based
on the `failing-environment.nix` shell environment:

```
$ nix-shell --pure failing-environment.nix
(nix-shell) $ cabal freeze
```

Despite both the Hackage-based and nixpkgs-based environments adhering
to that same freeze file, the Hackage environment works and the
nixpkgs environment fails.

Both environments use the same GHC, `cabal`, and Z3, determined by the `nixpkgs` snapshot used in `./pkgs.nix`.

# Working version (Hackage)

The example file `src/MyLib.hs` can be successfully checked using the
following procedure:

```
$ nix-shell --pure working-environment.nix
(nix-shell) $ cabal clean && cabal build
...
**** LIQUID: SAFE (1 constraints checked) **************************************
```

In this environment, nixpkgs provides GHC 9.10.1, `cabal`, and Z3.
Then `cabal` builds the Haskell libraries, specified by
`cabal.project.freeze`, by fetching their sources from Hackage.

# Failing version (nixpkgs)

The example file `src/MyLib.hs` fails to check using the following procedure:

```
$ nix-shell --pure failing-environment.nix
(nix-shell) $ cabal clean && cabal build
...
**** LIQUID: ERROR *************************************************************
<no location info>: error:
    :1:1-1:1: Error
  crash: SMTLIB2 respSat = Error "line 3 column 11916: Sort mismatch at argument #1 for function (declare-fun not (Bool) Bool) supplied sort is Int"
```

This environment uses the same GHC, `cabal`, and Z3 as the working environment, but the `liquidhaskell` library and its dependencies are built as Nix packages using the Nix build tool.

The Nix build tool downloads some of the libraries pre-built from
`cache.nixos.org` and builds the others by invoking `cabal`.  The
library sources come initially from Hackage, but some are modified by
rules in [this big file from nixpkgs][1].  Ultimately, their versions
match those of the `cabal.project.freeze` file (which was generated
based on them).

Despite the fact that both environments satisfy `cabal.project.freeze`---both consist of Hackage-sourced libraries with matching versions---they have different behavior.  In the first, the MyLib.hs example typechecks, and in the second, it does not.

[1]: https://github.com/NixOS/nixpkgs/blob/4aa36568d413aca0ea84a1684d2d46f55dbabad7/pkgs/development/haskell-modules/hackage-packages.nix
