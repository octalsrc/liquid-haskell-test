An error can be produced as follows.

```
$ git clone https://github.com/octalsrc/liquid-haskell-test
$ cd liquid-haskell-test
(liquid-haskell-test) $ nix-shell --pure cabal-shell.nix

[nix-shell:~/liquid-haskell-test]$ cabal build
Build profile: -w ghc-9.10.1 -O1
In order, the following will be built (use -v for more details):
 - liquid-haskell-test-0.1.0.0 (lib) (first run)
Preprocessing library for liquid-haskell-test-0.1.0.0...
Building library for liquid-haskell-test-0.1.0.0...
[1 of 1] Compiling MyLib            ( src/MyLib.hs, /home/.../liquid-haskell-test/dist-newstyle/build/x86_64-linux/ghc-9.10.1/liquid-haskell-test-0.1.0.0/build/MyLib.o, /home/.../liquid-haskell-test/dist-newstyle/build/x86_64-linux/ghc-9.10.1/liquid-haskell-test-0.1.0.0/build/MyLib.dyn_o )

**** LIQUID: ERROR *************************************************************
<no location info>: error:
    :1:1-1:1: Error
  crash: SMTLIB2 respSat = Error "line 3 column 11916: Sort mismatch at argument #1 for function (declare-fun not
(Bool) Bool) supplied sort is Int"

Error: [Cabal-7125]
Failed to build liquid-haskell-test-0.1.0.0.

[nix-shell:~/liquid-haskell-test]$ cabal exec ghc -- -fforce-recomp src/MyLib.hs
Loaded package environment from /home/.../liquid-haskell-test/dist-newstyle/tmp/environment.-687319/.ghc.environment.x86_64-linux-9.10.1
[1 of 1] Compiling MyLib            ( src/MyLib.hs, src/MyLib.o )

**** LIQUID: ERROR *************************************************************
<no location info>: error:
    :1:1-1:1: Error
  crash: SMTLIB2 respSat = Error "line 3 column 11786: Sort mismatch at argument #1 for function (declare-fun not
(Bool) Bool) supplied sort is Int"
```
