# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/91065417-14d1-4353-902c-6d644c706459";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."ROOT".device = "/dev/disk/by-uuid/edc0296e-ccb0-4f97-8300-7bfdc4183d7f";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/01E4-C762";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/91065417-14d1-4353-902c-6d644c706459";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/91065417-14d1-4353-902c-6d644c706459";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

  fileSystems."/tmp" =
    { device = "/dev/disk/by-uuid/91065417-14d1-4353-902c-6d644c706459";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/disk/by-uuid/91065417-14d1-4353-902c-6d644c706459";
      fsType = "btrfs";
      options = [ "subvol=@.snapshots" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/abed240a-e42c-4193-8de9-f8a69348846d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s18.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
