# Adapted from https://zeroes.dev/p/nix-recipe-for-postgresql/
{
  description = "Template for a direnv shell, with Postgres DB";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # https://github.com/direnv/direnv/issues/73#issuecomment-2478178424
    # Function to create script
    mkScript = name: text: let
      script = pkgs.writeShellScriptBin name text;
    in
      script;

    # Define your scripts/aliases
    scripts = [
      (mkScript "start" ''pg_ctl -o "-p 5432 -k $PGDATA" start'')
      (mkScript "pg" ''psql -p 5432 -U postgres'')
      (mkScript "stop" ''pg_ctl stop'')
    ];
  in {
    devShells.${system}.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs;
        [
          go
          postgresql_15
        ]
        ++ scripts;

      postgresConf = pkgs.writeText "postgresql.conf" ''
        # Add Custom Settings
        log_min_messages = warning
        log_min_error_statement = error
        log_min_duration_statement = 100  # ms
        log_connections = on
        log_disconnections = on
        log_duration = on
        #log_line_prefix = '[] '
        log_timezone = 'UTC'
        log_statement = 'all'
        log_directory = 'pg_log'
        log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
        logging_collector = on
        log_min_error_statement = error
      '';

      # ENV Variables
      LD_LIBRARY_PATH = "${pkgs.geos}/lib:${pkgs.gdal}/lib";
      # PGDATA = "${toString ./.}/.pg";

      # Post Shell Hook
      shellHook = ''
        echo Using $(postgres --version)

        # Setup: other env variables
        export PGDATA=$(pwd)/.pg
        export PGHOST="$PGDATA"
        # Setup: DB
        [ ! -d $PGDATA ] && pg_ctl initdb -o "-U postgres" && cat "$postgresConf" >> $PGDATA/postgresql.conf

        echo ============================================================
        echo ============================================================
        echo 'Start the server: `start`'
        echo 'Connect to the server: `pg`'
        echo 'Stop the server: `stop`'
        echo ============================================================
        echo ============================================================
      '';
    };
  };
}
