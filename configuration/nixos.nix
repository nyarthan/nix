specialArgs:
let
  inherit (specialArgs.inputs) home-manager nixpkgs;
in
{
  nixosConfigurations.hal = nixpkgs.lib.nixosSystem {
    inherit specialArgs;

    system = "x86_64-linux";

    modules = [
      ../hosts/hal/configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = specialArgs;
        };
      }
    ];
  };
}
