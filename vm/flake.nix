# Build the VM using:
# nixos-rebuild build-vm --flake .#vm
# nixos-rebuild build-vm-with-bootloader --flake .#vm
{
  description = "Template for a NixOS VM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      "vm" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          {
            nixpkgs.hostPlatform = "x86_64-linux"; # needed for flakes
            users.users = {
              "user" = {
                initialPassword = "password";
                isNormalUser = true;
                extraGroups = ["wheel"];
              };
            };
            system.stateVersion = "23.05";
          }
        ];
      };
    };
  };
}
