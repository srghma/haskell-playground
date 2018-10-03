self: super:
{
  hies = self.callPackage ./hie-nix {};
  gitignore = self.callPackage ./nix-gitignore {};
}
