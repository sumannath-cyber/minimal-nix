{
  description = "Minimal NixOS + Hyprland";

  inputs = {
    # Stable base
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Unstable for selected packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";

    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.idk-nix = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit unstable; };

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit unstable; };
            users.suman = import ./home.nix;
          };
        }
      ];
    };
  };
}
