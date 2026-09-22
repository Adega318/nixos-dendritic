{ inputs, ... }:
{
  configurations.nixos.dean.module =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")

        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
          "usb_storage"
          "sd_mod"
        ];
        initrd.kernelModules = [ ];
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/004c20a5-75de-41cb-99b8-8180d9ccfd9c";
          fsType = "btrfs";
        };

        "/home" = {
          device = "/dev/disk/by-uuid/004c20a5-75de-41cb-99b8-8180d9ccfd9c";
          fsType = "btrfs";
          options = [ "subvol=home" ];
        };

        "/nix" = {
          device = "/dev/disk/by-uuid/004c20a5-75de-41cb-99b8-8180d9ccfd9c";
          fsType = "btrfs";
          options = [ "subvol=nix" ];
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/A22C-E4C9";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/8855bb78-202e-4e6f-b48c-284c17f480a0"; }
      ];

      networking.useDHCP = lib.mkDefault true;

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
