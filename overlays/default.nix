inputs: {
  overlays = {
    additions = final: _prev: import ../pkgs { pkgs = final; };

    modifications = import ./modifications;

    unstable-packages = final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    };
  };
}
