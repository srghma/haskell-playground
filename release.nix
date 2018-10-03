{
  nixpkgs ? import ./nix/nixpkgs,

  pkgs ?
    let
      config = { allowUnfree = true; };
      overlay = import ./nix/pkgs/overlay.nix;
    in
      import nixpkgs { inherit config; overlays = [ overlay ]; },

  compiler ? "default",
}:

let
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};


  additionalIgnores = ''
    .git/
    .ghci
    .gitignore
    .stylish-haskell.yaml
    ChangeLog.md
  '';

  src = pkgs.gitignore.gitignoreSourceAux additionalIgnores ./.;

  drv = haskellPackages.callCabal2nix "app" src {};
in
  drv
