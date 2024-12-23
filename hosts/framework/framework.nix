# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3dc38429-4156-4cd3-8ec2-25ae2d7f789b";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."ROOT".device = "/dev/disk/by-uuid/f509841a-a65f-4dcd-bad5-18d5abb883dc";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3F95-E66D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/3dc38429-4156-4cd3-8ec2-25ae2d7f789b";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/3dc38429-4156-4cd3-8ec2-25ae2d7f789b";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

  fileSystems."/tmp" =
    { device = "/dev/disk/by-uuid/3dc38429-4156-4cd3-8ec2-25ae2d7f789b";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/disk/by-uuid/3dc38429-4156-4cd3-8ec2-25ae2d7f789b";
      fsType = "btrfs";
      options = [ "subvol=@.snapshots" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6a7d64ed-7538-4f88-a15e-fc018d279a77"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp170s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}