{
  inputs,
  system,
  config,
  ...
}@args:
{
  treefmt.config = import ./treefmt.nix (
    args
    // {
      globignore = inputs.globignore.packages.${system}.default;
    }
  );

  formatter = config.treefmt.build.wrapper;
}
