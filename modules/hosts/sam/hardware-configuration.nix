{ inputs, ... }:
{
  configurations.nixos.sam.module =
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

        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.nixos-hardware.nixosModules.common-pc-ssd
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = [ ];

        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/dfb14dc9-6c27-446c-905b-aee7f9a051d3";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/7436-702F";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        "/mnt/hdd" = {
          device = "/dev/disk/by-uuid/b1a6060d-44c0-4cf3-bc62-fdccc2adee0c";
          fsType = "btrfs";
          options = [
            "nofail"
            "x-systemd.device-timeout=5s"
          ];
        };

        "/mnt/ssd" = {
          device = "/dev/disk/by-uuid/b4e23421-8f46-4758-aa6c-9ad8bf753760";
          fsType = "btrfs";
          options = [
            "nofail"
            "x-systemd.device-timeout=5s"
          ];
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/93987b69-11ec-4720-bb86-3aa6a990197a"; }
      ];

      hardware.graphics.enable = true;

      networking.useDHCP = lib.mkDefault true;

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
