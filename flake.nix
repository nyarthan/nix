{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
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

    neovim.url = "github:nyarthan/neovim";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/flake/formatter.nix
        ./modules/flake/config-shell.nix
        ./modules/flake/systems.nix
      ];

      flake =
        let
          pkgs = inputs.nixpkgs;
          lib' = import ./lib { inherit pkgs; };
          specialArgs = {
            inherit (inputs.self) outputs;
            inherit inputs lib';
          };
        in
        import ./overlays inputs
        // import ./configuration/darwin.nix specialArgs
        // import ./configuration/nixos.nix specialArgs;
    };
}
