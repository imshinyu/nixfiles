{ config, lib, pkgs, inputs, ... }:
let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./nixcord.nix
    ./spicetify.nix
    ./steam.nix
    ./appimage.nix
  ];
  nixpkgs.config.allowUnfree = true;
  programs.adb.enable = true;
  programs.xwayland.enable = true;
  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vlc
    rmpc
    evtest
    pkgsUnstable.seanime
    hyprlock
    waytrogen
    onlyoffice-desktopeditors
    osu-lazer-bin
    kdePackages.qtdeclarative
    lua-language-server
    appimage-run # run appimage
    ntfs3g
    xdg-user-dirs
    python3
    grim #screenshot tool
    slurp #select region
    copyq
    gnome-keyring #secrets
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
    wf-recorder
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
    git
    kitty
    quickshell
    yazi
    rofi
    pcsx2
    youtube-music
    tsukimi
    trashy
    pwvucontrol
    # lxqt.pavucontrol-qt #volume control
    gnome-system-monitor
    gnome-calculator
    kdePackages.partitionmanager
    kdePackages.okular
    kdePackages.dolphin
  ];
}
