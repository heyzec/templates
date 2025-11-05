{
  description = "Template for Firefox/Chrome browser extension";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
  };

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-darwin"];
  in {
    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.mkShell {
          buildInputs = with pkgs;
            lib.lists.remove null [
              nodejs
              typescript-language-server
              firefox-devedition
              # chromium for darwin not on nixpkgs, install with homebrew instead
              (
                if pkgs.stdenv.isLinux
                then chromium
                else null
              )
            ];
        };
    });
  };
}
