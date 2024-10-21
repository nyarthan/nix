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

    # sops-nix.url = "/Users/jannis/dev/repos/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-root.url = "github:srid/flake-root";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nix-darwin,
      home-manager,
      # sops-nix,
      treefmt-nix,
      flake-root,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
        flake-root.flakeModule
      ];

      systems = [ "aarch64-darwin" ];

      perSystem =
        { pkgs, config, ... }:
        {
          treefmt.config = import ./treefmt.nix { inherit pkgs config; };

          devShells.default = pkgs.mkShell {
            packages = [
              # pkgs.sops
              pkgs.age
              pkgs.ssh-to-age
              pkgs.mkpasswd
            ];
          };

          formatter = config.treefmt.build.wrapper;
        };

      flake =
        let
          pkgs = nixpkgs;
          lib' = import ./lib { inherit pkgs; };
          specialArgs = {
            inherit
              inputs
              lib'
              ;
            inherit (inputs) neovim;
            inherit (self) outputs;
          };
        in
        {

          overlays = import ./overlays {
            inherit inputs pkgs;
            inherit (self) outputs;
          };

          darwinConfigurations.ghost = nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            modules = [
              ./hosts/ghost
              # sops-nix.darwinModules.sops
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
