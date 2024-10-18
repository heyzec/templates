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
      in (pkgs.mkShell {
        buildInputs = with pkgs; [
          poetry
        ];

        shellHook = /* bash */ ''
          # == 1. Inject the libraries ==
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/
          export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"


          # == 2. Reinstall virtual environment if necessary ==
          POETRY_LOCK="poetry.lock"
          PYPROJECT_TOML="pyproject.toml"
          VENV_FILE="$(poetry env info --path)/pyvenv.cfg"

          poetry_lock_time=$(stat -c %Y "$POETRY_LOCK" || echo 0)
          pyproject_time=$(stat -c %Y "$PYPROJECT_TOML" || echo 0)
          venv_time=$(stat -c %Y "$VENV_FILE" || echo 0)

          # Compare timestamps
          if [[ $venv_time -eq 0 || $poetry_lock_time -gt $venv_time || $pyproject_time -gt $venv_time ]]; then
              poetry install
              touch "$VENV_FILE"
          fi


          # == 3. Activate virtual environment ==
          # Avoid `poetry shell` because it is buggy
          source $(poetry env info --path)/bin/activate

          alias a=b
          function c() {
            echo d
          }
        '';
      });
    });
  };
}
