inputs@{ lib', pkgs, ... }:
lib'.mkCustomModule [ "karabiner-driver" ] inputs (
  { lib, cfg, ... }:
  {
    options = {
      enable = lib.mkEnableOption "Enables karabiner driver";
    };

    config = lib.mkIf cfg.enable {
      system.activationScripts.preActivation.text = ''
        installer -pkg ${pkgs.karabiner-driver}/${pkgs.karabiner-driver.installerName} -target /
        /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
      '';

      launchd.daemons.karabiner-driver = {
        serviceConfig = {
          Label = "org.pqrs.Karabiner-Driver-Init";
          KeepAlive = true;
          RunAtLoad = true;
        };
        command = "sudo '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon'";
      };
    };
  }
)
