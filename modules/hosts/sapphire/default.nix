{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../hjem.nix
      ../../systemd.nix
      ../../xdg-portal.nix
      ../../env.nix
      ../../fonts.nix
      ../../display-manager.nix
      ../../desktop.nix
      ../../programs/packages.nix
    ];
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.timeout = 3;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];
  boot.blacklistedKernelModules = [ "pcspkr" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  boot.loader.systemd-boot.windows.Win10 = {
    title = "Windows";
    efiDeviceHandle = "HD0b";
  };
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  nix.settings.auto-optimise-store = true;
  
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };


  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "sapphire";
  networking.networkmanager.enable = true;

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

  virtualisation.docker.enable = true;
  services.gvfs.enable = true;

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

  services.pipewire.extraConfig.pipewire."97-null-sink" = {
    "context.objects" = [
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Null-Sink";
          "node.description" = "Null Sink";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL,FR";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Null-Source";
          "node.description" = "Null Source";
          "media.class" = "Audio/Source";
          "audio.position" = "FL,FR";
        };
      }
    ];
  };
  services.pipewire.extraConfig.pipewire."98-virtual-mic" = {
    "context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "FL,FR";
          "node.description" = "Mumble as Microphone";
          "capture.props" = {
            # Mumble's output node name.
            "node.target" = "Mumble";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "Virtual-Mumble-Microphone";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };
  
  # Mumble server.
  services.murmur = {
    enable = true;
    bandwidth = 540000;
    bonjour = true;
    password = "choose_your_own_password";
    autobanTime = 0;
  };
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    # Mumble Murmur server port
    64738
  ];
  networking.firewall.allowedUDPPorts = [
    # Mumble Murmur server port
    64738
  ];

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


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
