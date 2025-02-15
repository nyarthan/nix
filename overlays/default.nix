inputs: {
  overlays =
    {
      additions = final: _prev: import ../pkgs { pkgs = final; };

      modifications = import ./modifications;
    }
    // {
      firefox-darwin = inputs.nixpkgs-firefox-darwin.overlay;
    };
}
