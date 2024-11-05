{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    globignore.url = "github:nyarthan/globignore";
    globignore.inputs.nixpkgs.follows = "nixpkgs";

    flake-root.url = "github:srid/flake-root";

    neovim.url = "/Users/jannis/.config/neovim";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    neovim.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    neovim.inputs.treefmt-nix.follows = "treefmt-nix";
    neovim.inputs.flake-parts.follows = "flake-parts";
    neovim.inputs.flake-root.follows = "flake-root";

    # sops-nix.url = "github:nyarthan/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nixpkgs-firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";
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
      globignore,
      flake-root,
      nixpkgs-firefox-darwin,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
        flake-root.flakeModule
      ];

      systems = [ "aarch64-darwin" ];

      perSystem =
        {
          pkgs,
          config,
          system,
          ...
        }:
        {
          treefmt.config = import ./treefmt.nix {
            inherit pkgs config;
            globignore = globignore.packages.${system}.default;
          };

          devShells.default = pkgs.mkShell {
            packages = [
              # pkgs.sops
              pkgs.age
              pkgs.ssh-to-age
              pkgs.mkpasswd
              pkgs.just
              pkgs.treefmt
            ];

            shellHook = ''
              cp -f ${config.treefmt.build.configFile} treefmt.toml
            '';
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

          overlays =
            import ./overlays {
              inherit inputs pkgs;
              inherit (self) outputs;
            }
            // {
              firefox = nixpkgs-firefox-darwin.overlay;
            };

          darwinConfigurations.ghost = nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            modules = [
              ./hosts/ghost
              ./modules/darwin/karabiner-driver.nix
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
