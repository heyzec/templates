{
  description = "Use poetry in a Nix dev-shell imperatively";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "x86_64-darwin" ];
  in {
    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};

        # Define Python version in pyproject.toml instead!
        # python-interpreter = pkgs.python312;

        # List dynamic libraries required by our packages
        # Add to the list if required, e.g. if error says libz.so.1 not found, run
        # `nix shell nixpkgs#nix-index --command nix-locate --top-level libz.so.1`
        libs = with pkgs; [
          zlib # needed by numpy
        ];
      in pkgs.mkShell {
        buildInputs = with pkgs; [
          poetry
        ];

        shellHook = ''
          # Inject the libraries
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"

          # Activate poetry (avoid `poetry shell` because it is buggy)
          poetry install
          source $(poetry env info --path)/bin/activate
        '';
      };
    });
  };
}
