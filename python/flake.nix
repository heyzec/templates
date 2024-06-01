{
  description = "Template for a direnv shell, with Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        (let
          python-packages = ps: with ps; [
            pandas
            requests
            (let
              pname = "openlocationcode";
              version = "1.0.1";
            in pkgs.python3Packages.buildPythonPackage {
              inherit pname version;
              src = pkgs.fetchPypi {
                inherit pname version;
                sha256 = "sha256-b8AQioIUtl10lkEFvWlkWop1KSN/Deaq3PqDzDNzs1k=";
              };
              doCheck = false;
            })
          ];
        in python3.withPackages python-packages)
      ];
    };
  };
}

