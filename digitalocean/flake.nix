{
  description = "DigitalOcean Droplet running NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    packages.x86_64-linux.default = let
      config = {
        imports = [
          "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
        ];
      };
    in
      (pkgs.nixos config).digitalOceanImage;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        terraform
        doctl
        just
      ];

      shellHook = ''
        just intro
      '';
    };

    nixosConfigurations.nixie-droplet = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {
          imports = [
            "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
            ./server.nix
          ];

          nix.settings.experimental-features = "nix-command flakes";

          programs.direnv.enable = true;
          programs.direnv.nix-direnv.enable = true;

          environment.systemPackages = with pkgs; [
            git
            just
            vim
            tmux
          ];
        }
      ];
    };
  };
}
