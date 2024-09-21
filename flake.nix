{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim.url = "/Users/jannis/.config/neovim";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      neovim,
    }:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      configLib = import ./lib { inherit lib; };
      specialArgs = {
        inherit
          inputs
          outputs
          configLib
          neovim
          ;
      };
    in
    {
      overlays = import ./overlays {
        inherit inputs outputs;
        pkgs = nixpkgs;
      };

      darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
}
