{
  description = "Template for a direnv shell, with Python + Poetry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, poetry2nix }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryEnv;

    # Creates a Python environment with an interpreter and all packages
    myPythonApp = mkPoetryEnv {
      projectDir = ./.;
    };
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        poetry
        myPythonApp
      ];
    };
  };
}


