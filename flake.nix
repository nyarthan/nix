{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    globignore = {
      url = "github:nyarthan/globignore";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        treefmt-nix.follows = "treefmt-nix";
        flake-root.follows = "flake-root";
      };
    };

    flake-root.url = "github:srid/flake-root";

    neovim = {
      url = "github:nyarthan/neovim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
        treefmt-nix.follows = "treefmt-nix";
        flake-parts.follows = "flake-parts";
        flake-root.follows = "flake-root";
      };
    };

    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix.url = "github:nyarthan/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.flake-root.flakeModule
      ];

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      perSystem =
        { pkgs, ... }@args:
        let
          specialArgs = args // {
            inherit inputs pkgs;
          };
        in
        import ./shells/outputs.nix specialArgs
        // import ./checks/outputs.nix specialArgs
        // import ./formatter/outptus.nix specialArgs;

      flake =
        let
          pkgs = inputs.nixpkgs;
          lib' = import ./lib { inherit pkgs; };
          specialArgs = {
            inherit (inputs.self) outputs;
            inherit inputs lib';
          };
        in
        import ./overlays inputs // import ./configuration/darwin.nix specialArgs;
    };
}
