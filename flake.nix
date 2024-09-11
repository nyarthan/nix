{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    alejandra,
  }: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.getAttrs [
      "aarch64-darwin"
    ];

    specialArgs = {inherit inputs outputs;};
  in {
    overlays = import ./overlays {
      inherit inputs outputs;
      pkgs = nixpkgs;
    };

    darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      modules = [
        {
          environment.systemPackages = [alejandra.defaultPackage.aarch64-darwin];
        }
        ./hosts/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."MacBook-Pro".pkgs;
  };
}
