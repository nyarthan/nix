{
  inputs,
  pkgs,
  ...
}: {
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # version 2.24.11.8 on unstable does not exist
    whatsapp-for-mac = prev.whatsapp-for-mac.overrideAttrs (finalAttrs: prevAttrs: {
      version = "2.24.16.80";
      src = prev.fetchzip {
        extension = "zip";
        name = "WhatsApp.app";
        url = "https://web.whatsapp.com/desktop/mac_native/release/?version=${finalAttrs.version}&extension=zip&configuration=Release&branch=relbranch";
        hash = "sha256-oPWZCIt0clZl9ZVltBhiheEPXuJQNELLqiRLS91gKvo=";
      };
    });
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
