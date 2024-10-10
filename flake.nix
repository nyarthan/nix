{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    neovim.url = "/Users/jannis/.config/neovim";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];

      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
        };

      flake =
        let
          configLib = import ./lib { inherit (nixpkgs) lib; };
          specialArgs = {
            inherit
              inputs
              configLib
              ;
            inherit (inputs) neovim;
            inherit (self) outputs;
          };
          pkgs = nixpkgs;
        in
        {

          overlays = import ./overlays {
            inherit inputs pkgs;
            inherit (self) outputs;
          };

          darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            modules = [
              ./hosts/darwin
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = specialArgs;
                };
              }
            ];
          };
        };
    };
}
