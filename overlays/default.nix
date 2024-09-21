{
  inputs,
  pkgs,
  ...
}:
let
  inherit (pkgs) lib;
in
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # version 2.24.11.8 on unstable does not exist as a whatsapp release
    whatsapp-for-mac = prev.whatsapp-for-mac.overrideAttrs (
      finalAttrs: prevAttrs: {
        version = "2.24.16.80";
        src = prev.fetchzip {
          extension = "zip";
          name = "WhatsApp.app";
          url = "https://web.whatsapp.com/desktop/mac_native/release/?version=${finalAttrs.version}&extension=zip&configuration=Release&branch=relbranch";
          hash = "sha256-oPWZCIt0clZl9ZVltBhiheEPXuJQNELLqiRLS91gKvo=";
        };
      }
    );

    # cursor flicker in neovim fixed in nightly - not yet released in v0.40.1
    # @see https://github.com/zellij-org/zellij/issues/3208
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
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };
}
