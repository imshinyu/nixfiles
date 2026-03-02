{config, lib, pkgs, inputs, ...}:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  boot.loader.systemd-boot.windows.Win10 = {
    title = "Windows";
    efiDeviceHandle = "HD0b";
  };
}
