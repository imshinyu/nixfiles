{ config, lib, pkgs, inputs, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };


  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "ruby";
  networking.networkmanager.enable = true;

  services.gvfs.enable = true;

  services.openssh.enable = true;

  environment.shells = with pkgs;[
    fish
  ];
  security.polkit.enable = true;
  security.soteria.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.graphics = {
    enable32Bit = true;
    extraPackages = [ pkgs.vulkan-loader ];
    extraPackages32 = [ pkgs.pkgsi686Linux.vulkan-loader ];
  };
  services.xserver.libinput.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
