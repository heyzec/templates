{
  description = "Template for VS Code extension";

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
          packages = with pkgs; [
            nodejs
            typescript-language-server
            just
          ];
        };
    });
  };
}
