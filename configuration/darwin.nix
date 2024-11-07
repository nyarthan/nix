specialArgs:
let
  inherit (specialArgs.inputs) nix-darwin home-manager;
  args = specialArgs // {
    system = "aarch64-darwin";
  };
in
{
  darwinConfigurations.ghost = nix-darwin.lib.darwinSystem {
    specialArgs = args;
    modules = [
      ../hosts/ghost
      ../modules/darwin/karabiner-driver.nix
      home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = args;
        };
      }
    ];
  };
}
