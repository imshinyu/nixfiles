{config, lib, pkgs, inputs, ...}:
{
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
  networking.networkmanager.enable = true;
  services.gvfs.enable = true;
  services.openssh.enable = true;
  environment.shells = with pkgs;[
    fish
  ];
  security.polkit.enable = true;
  security.soteria.enable = true;

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

  time.timeZone = "Africa/Algiers";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true;    # Use settings below, ignore user config
      addons = with pkgs; [
        fcitx5-chewing    # Chewing (Traditional Chinese)
        fcitx5-mozc       # Japanese input method
      ];
      quickPhrase = {
        ":sob:" = "T-T";
      };
      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "chewing";
          "Groups/0/Items/2".Name = "mozc";
        };
      };
    };
  };
  services.xserver.xkb = {
    layout = "us,dz";
    options = "grp:lalt_shift_toggle,caps:escape";
    variant = "";
  };

  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.cups-filters
    pkgs.cnijfilter2
    pkgs.gutenprint
  ];
}
