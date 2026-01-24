{ config, lib, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../hjem.nix
      ../../systemd.nix
      ../../xdg-portal.nix
      ../../env.nix
    ];
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 3;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  boot.loader.systemd-boot.windows.Win10 = {
    title = "Windows";
    efiDeviceHandle = "HD0b";
  };
  boot.loader.systemd-boot.configurationLimit = 3;
  nix.settings.auto-optimise-store = true;
  
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };


  powerManagement.cpuFreqGovernor = "performance";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "sapphire"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  virtualisation.docker.enable = true;

  services.xserver.xkb = {
    layout = "us,dz";
    options = "grp:lalt_shift_toggle,caps:escape";
    variant = "";
  };

  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.cups-filters
    pkgs.cnijfilter2
    pkgs.gutenprint
  ];

  # Enable sound with pipewire.
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

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
     # nerdfonts
     tewi-font
     jetbrains-mono
     iosevka-bin
     adwaita-fonts
     noto-fonts
     font-awesome
     smiley-sans
     material-symbols
     dejavu_fonts
     liberation_ttf
  ];
  services.displayManager.ly = {
    enable = true;
    settings = {
      # allow_empty_password = false; # dangerous?
      animation = "matrix"; # "doom", "matrix", "colormix"
      animation_timeout_sec = 300; # 5 minutes
      bg = "0x02000000";
      # bigclock = "en"; # enlarges the clock -- may not work with some fonts?
      # blank_box = false; # transparent
      border_fg = "0x01FFFFFF";
      clear_password = true;
      clock = "%B, %A %d @ %H:%M:%S";
      colormix_col1 = "0x20000000";
      colormix_col2 = "0x200C0C0C";
      colormix_col3 = "0x20FFFFFF";
      default_input = "password";
      error_bg = "0x02000000";
      error_fg = "0x01FF0000";
      fg = "0x01FFFFFF";
      hide_borders = true;
      hide_version_string = true; # doesnt work?
      hide_key_hints = true;
      initial_info_text = "null"; # hostname
      # input_len = 69;
      lang = "en";
      load = true;
      margin_box_h = 0;
      margin_box_v = 0;
      min_refresh_delta = 100; # milliseconds -- default=5
      # numlock = true;
      save = true;
      text_in_center = false; # ugly
      # tty = 4; # broken? -- could help with UWSM sessions
      # vi_default_mode = "insert";
      # vi_mode = true;
      # ...
    };
  };
  # services.displayManager.sessionPackages = [ 
  #   pkgs.lxqt.lxqt-wayland-session 
  # ];
  # services.xserver.desktopManager.lxqt.enable = true;
  # environment.lxqt.excludePackages = with pkgs; [
  #   lxqt.qterminal
  # ];
  services.desktopManager.plasma6.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.adb.enable = true;
  programs.xwayland.enable = true;
  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.mango.enable = true;
  programs.fish.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.millennium-steam;
  };
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      fullAppDisplay
      playNext
      beautifulLyrics
      oldLikeButton
      catJamSynced
    ];
    theme = spicePkgs.themes.comfy;
  };
  environment.systemPackages = with pkgs; [
     evtest
     waypaper
     onlyoffice-desktopeditors
     osu-lazer-bin
     kdePackages.qtdeclarative
     lua-language-server
     appimage-run # run appimage
     ntfs3g
     xdg-user-dirs
     python3
     sc-controller
     grim #screenshot tool
     slurp #select region
     cliphist #clipboard
     copyq
     gnome-keyring #secrets
     tree
     vesktop 
     (discord.override {
      withVencord = true;
     })
     pywalfox-native
     wayfreeze #freeze screen
     wine
     wayland-logout #gracefully logout
     yt-dlp #download youtube stuff
     raylib
     umu-launcher
     scrcpy #screencast android
     obsidian
     obs-studio
     mpvpaper #set videos as wallpapers
     mangohud
     xwayland-satellite
     lxqt.pavucontrol-qt #volume control
     playerctl #player control
     swappy #edit screenshot
     tesseract #OCR
     wf-recorder
     ffmpeg
     wlsunset #gamma modifier
     upscayl #upscale photos
     nwg-look #GTK theme settings
     nwg-clipman
     clipse #clipboard
     darkly #qt style
     distrobox
     google-chrome
     hyprshot #take screenshots
     imagemagick
     krita
     ludusavi #backup/restore game save
     matugen #dynamic theme generator
     networkmanagerapplet
     papirus-icon-theme
     ncdu #folder size tui
     wl-clipboard
     lact #gpu control
     xdg-ninja #check folders that don't follow xdg-dirs spec
     rustup
     gcc
     go
     handbrake
     blender
     docker-compose
     jetbrains-toolbox
     fd
     fastfetch
     btop
     adw-gtk3
     inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
     inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix
     inputs.xboxdrv.packages.${pkgs.stdenv.hostPlatform.system}.xboxdrv
     wf-recorder
     zip
     rar
     hyprpicker
     mako
     protonup-qt
     heroic
     xdg-desktop-portal-gtk
     xdg-desktop-portal-wlr
     xdg-desktop-portal-shana
     git
     kitty
     quickshell
     windows10-icons
     yazi
     rofi
     rofi-calc
     pcsx2
     youtube-music
     tsukimi
     trashy
     kdePackages.partitionmanager
     kdePackages.okular
     lxqt.pcmanfm-qt
  #  wget
  ];


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
