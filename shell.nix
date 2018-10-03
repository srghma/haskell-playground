{
  nixpkgs ? import ./nix/nixpkgs,

  pkgs ?
    let
      config = { allowUnfree = true; };
      overlay = import ./nix/pkgs/overlay.nix;
    in
      import nixpkgs { inherit config; overlays = [ overlay ]; },

  compiler ? "default",
  doBenchmark ? false,
}:

let
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callCabal2nix "app" ./app.cabal {};

  env = pkgs.lib.overrideDerivation drv.env (oldAttrs: {
    buildInputs =
      oldAttrs.buildInputs ++
      (with pkgs; [ git watchexec hies.hie84 ]) ++
      (with haskellPackages; [ cabal-install hlint hindent stylish-haskell ]);

    NIX_PATH = pkgs.lib.concatStringsSep ":" [
      "nixpkgs=${nixpkgs}"
    ];

    HISTFILE = toString ../.bash_hist;
  });
in
  env
