{
  description = "Use poetry2nix in a Nix dev-shell declaratively";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = {
    nixpkgs,
    poetry2nix,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-darwin"];
  in {
    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;}) mkPoetryEnv;
        # Define Python version here
        python-interpreter = pkgs.python312;
        # Create a Python environment with an interpreter and all packages
        myPythonApp = mkPoetryEnv {
          projectDir = ./.;
          python = python-interpreter;
          preferWheels = true;
        };
      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            poetry
            myPythonApp
          ];
        };
    });
  };
}
