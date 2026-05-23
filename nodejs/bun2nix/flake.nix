{
  # Adapted from https://github.com/nix-community/bun2nix/tree/master/templates/nextjs
  description = "Template for a direnv shell, with NodeJS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    bun2nix.url = "github:nix-community/bun2nix?ref=2.1.0";
    bun2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Use community cache, because bun2nix takes very long to compile
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = {nixpkgs, ...} @ inputs: let
    systems = ["x86_64-linux"];
  in {
    packages = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.callPackage ./package.nix {bun2nix = inputs.bun2nix.packages.${system}.default;};
    });

    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            bun
            typescript-language-server
            eslint
          ];

          # Install deps exactly as per lockfile
          shellHook = ''
            bun install --frozen-lockfile
          '';
        };
    });
  };
}
