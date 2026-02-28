{ config, lib, pkgs, inputs, ... }:
let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  nautilus-portal = pkgs.runCommandLocal "nautilus-portal" { } ''
    mkdir -p $out/share/xdg-desktop-portal/portals
    cat > $out/share/xdg-desktop-portal/portals/nautilus.portal <<EOF
    [portal]
    DBusName=org.gnome.Nautilus
    Interfaces=org.freedesktop.impl.portal.FileChooser
    EOF
  '';
in
{
  imports = [
    ./nixcord.nix
    ./steam.nix
    ./appimage.nix
    ./spicetify.nix
    ./qbittorrent.nix
    inputs.aagl.nixosModules.default
  ];
  nixpkgs.overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];
  nix.package = pkgs.lixPackageSets.stable.lix;
  nixpkgs.config.allowUnfree = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.adb.enable = true;
  programs.xwayland.enable = true;
  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.anime-game-launcher.enable = true;
  environment.systemPackages = with pkgs; [
    winetricks
    mumble
    bluej
    thunderbird
    ente-auth
    android-studio
    waydroid-helper
    waydroid-nftables
    vlc
    jellyfin-rpc
    selectdefaultapplication
    fzf
    feishin
    evtest
    pkgsUnstable.seanime
    pkgsUnstable.stoat-desktop
    hyprlock
    hyprshot
    hyprpicker
    waytrogen
    onlyoffice-desktopeditors
    osu-lazer-bin
    lua-language-server
    appimage-run # run appimage
    ntfs3g
    spicetify-cli
    xdg-user-dirs
    python3
    grim #screenshot tool
    slurp #select region
    copyq
    tree
    pywalfox-native
    wayfreeze #freeze screen
    wine
    wayland-logout #logout gracefully
    yt-dlp #download youtube stuff
    raylib
    umu-launcher
    scrcpy #screencast android
    obsidian
    obs-studio
    mpvpaper #set videos as wallpapers
    mangohud
    xwayland-satellite
    playerctl #player control
    ffmpeg
    wlsunset #gamma modifier
    upscayl #upscale photos
    nwg-look #GTK theme settings
    darkly #qt style
    distrobox
    google-chrome
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
    btop
    fastfetch
    adw-gtk3
    inputs.browser-previews.packages.${pkgs.system}.google-chrome-beta
    inputs.elysia.packages.x86_64-linux.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.qtengine.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix
    inputs.xboxdrv.packages.${pkgs.stdenv.hostPlatform.system}.xboxdrv
    wf-recorder
    zip
    rar
    mako
    protonplus
    heroic
    git
    foot
    quickshell
    yazi
    rofi
    pcsx2
    youtube-music
    tsukimi
    trashy

    # gnome-system-monitor
    # gnome-calculator
    # gnome-software
    gnome-keyring #secrets
    seahorse
    nautilus
    nautilus-portal
    # loupe
    lxqt.pavucontrol-qt #volume control

    kdePackages.partitionmanager
    kdePackages.okular
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.qtdeclarative
  ];
}
