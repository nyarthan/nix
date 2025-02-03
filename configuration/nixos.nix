specialArgs:
let
  inherit (specialArgs.inputs) home-manager nixpkgs;
in
{
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    inherit specialArgs;

    system = "aarch64-linux";

    modules = [
      ../hosts/hal
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
