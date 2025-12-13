{
  description = "Python dev shell, without package managers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-darwin"];
  in {
    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};

        # Define Python version here
        python-interpreter = pkgs.python312;
        python-packages = ps:
          with ps; [
            pandas
            requests
            (let
              pname = "openlocationcode";
              version = "1.0.1";
            in
              ps.buildPythonPackage {
                inherit pname version;
                src = pkgs.fetchPypi {
                  inherit pname version;
                  sha256 = "sha256-b8AQioIUtl10lkEFvWlkWop1KSN/Deaq3PqDzDNzs1k=";
                };
                doCheck = false;
              })
          ];
      in
        pkgs.mkShellNoCC {
          buildInputs = [
            (python-interpreter.withPackages python-packages)
          ];
        };
    });
  };
}
