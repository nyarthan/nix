final: prev: {
  zellij = prev.zellij.overrideAttrs (
    finalAttrs: prevAttrs:
    let
      pname = "zellij";
      rev = "3569daf7c9cacc1dbbec6a3813079130b4c0683c";
      src = prev.fetchFromGitHub {
        inherit rev;
        owner = "zellij-org";
        repo = "zellij";
        hash = "sha256-J7CiI965GQiVMND01QrwKkZ7psxSsHnr3VcZNVk+Mb8=";
      };
    in
    {
      inherit pname src;
      version = rev;
      # overrideAttrs works on stdenv.mkDerivation, not on stdenv.buildRustPackage
      # @see https://discourse.nixos.org/t/is-it-possible-to-override-cargosha256-in-buildrustpackage/4393
      cargoDeps = prevAttrs.cargoDeps.overrideAttrs (
        prev.lib.const {
          name = "${pname}-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-u7qHSVI7FvYU9/wh+b+Gm5j6OBZWFY0BSDVPu/Vltms=";
        }
      );
    }
  );

}
