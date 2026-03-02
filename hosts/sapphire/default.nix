{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./dualboot.nix
      ./programs.nix
      ./mic.nix
      ../common.nix
      ../../modules/home-manager.nix
      ../../modules/systemd.nix
      ../../modules/xdg-portal.nix
      ../../modules/env.nix
      ../../modules/fonts.nix
      ../../modules/display-manager.nix
      ../../modules/desktop.nix

      ../../users/shinyu/shinyu.nix
      ../../users/biscuit/biscuit.nix
      ../../users/family/family.nix
    ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "sapphire";
  networking.networkmanager.enable = true;

  services.gvfs.enable = true;

  # Enable the OpenSSH daemon.
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  # List services that you want to enable:



  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
