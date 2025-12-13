{
  description = "Template for a telegram bot using python-telegram-bot library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Define Python version here
    python-interpreter = pkgs.python311;
    python-packages = ps:
      with ps; [
        python-dotenv
        python-telegram-bot
      ];
  in {
    devShells.${system}.default = pkgs.mkShellNoCC {
      buildInputs = [
        (python-interpreter.withPackages python-packages)
      ];
    };
  };
}
