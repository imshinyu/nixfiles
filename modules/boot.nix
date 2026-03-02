{config, lib, pkgs, inputs, ...}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.timeout = 3;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];
  boot.blacklistedKernelModules = [ "pcspkr" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
