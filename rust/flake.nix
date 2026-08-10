{
  inputs = {nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";};

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    targetSystems = ["x86_64-linux" "aarch64-darwin"];
    rev = self.shortRev or self.dirtyShortRev or "dirty";
  in {
    devShells = nixpkgs.lib.genAttrs targetSystems (system: {
      default = import ./shell.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };
    });

    packages = nixpkgs.lib.genAttrs targetSystems (
      system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./package.nix {
          inherit rev;
        };
      }
    );
  };
}
