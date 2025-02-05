{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    "${
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/master.tar.gz";
        sha256 = "sha256:02i8sgnjzk4srk4j7qnjzig0rd4ip7a1vpbi5ynaqs1hh56q10r9";
      }
    }/module.nix"
    ./disk-configuration.nix

    ../common/core
    ../common/core/nixos
    ../common/users/jannis/nixos.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  };

  networking = {
    hostName = "hal";
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  time.timeZone = "Europe/Berlin";

  users.users.jannis = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      bitwarden
      lazygit
    ];
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Jannis Morgenstern";
        email = "jannis.n.morgenstern@gmail.com";
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];

    desktopManager.xterm.enable = false;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  services.displayManager.defaultSession = "none+i3";

  environment = {
    pathsToLink = [ "/libexe" ];
    systemPackages = with pkgs; [
      vim
      neovim
      git
      wget
      curl
      ghostty
    ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      onevpl-intel-gpu
    ];
  };

  hardware.firmware = [
    (
      let
        model = "37xx";
        version = "0.0";

        firmware = pkgs.fetchurl {
          url = "https://github.com/intel/linux-npu-driver/raw/v1.2.0/firmware/bin/vpu_${model}_v${version}.bin";
          hash = "sha256-qGhLLiBnOlmF/BEIGC7DEPjfgdLCaMe7mWEtM9uK1mo=";
        };
      in
      pkgs.runCommand "intel-vpu-firmware-${model}-${version}" { } ''
        mkdir -p "$out/lib/firmware/intel/vpu"
        cp '${firmware}' "$out/lib/firmware/intel/vpu/vpu_${model}_v${version}.bin"
      ''
    )
  ];

  system.stateVersion = "25.05";
}
