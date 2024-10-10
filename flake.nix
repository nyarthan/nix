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

    sops-nix.url = "/Users/jannis/dev/repos/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nix-darwin,
      home-manager,
      sops-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = [
              pkgs.sops
              pkgs.age
              pkgs.ssh-to-age
              pkgs.mkpasswd
            ];
          };

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
              sops-nix.darwinModules.sops
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
