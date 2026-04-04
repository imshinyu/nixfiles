{ config, lib, pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
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
 
  nixpkgs.overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];
  nix.package = pkgs.lixPackageSets.stable.lix;
  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.xwayland.enable = true;
  services.flatpak.enable = true;
  programs.fish.enable = true;
  programs.java.enable = true;
  programs.nix-ld.enable = true;
  programs.localsend.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  environment.systemPackages = (with pkgs-unstable; [
    river
    (writeTextFile {
      name = "river-session";
      destination = "/share/wayland-sessions/river.desktop";
      text = ''
        [Desktop Entry]
        Name=River
        Comment=Dynamic tiling Wayland compositor
        Exec=${pkgs-unstable.river}/bin/river
        Type=Application
      '';
    })
    seanime
    spicetify-cli
    google-chrome
    chromium
    yazi
    protonplus
    pywalfox-native
    equibop
    (discord.override {
      withOpenASAR = true;
      withEquicord = true;
    })
    
  ]) ++ (with pkgs; [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.elysia.packages.x86_64-linux.default
    inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix
    inputs.niri-screentime.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.qtengine.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.qtengine.packages.${pkgs.stdenv.hostPlatform.system}.default.qt5
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    zed-editor-fhs
    mpv
    arrpc
    sqlite
    dbeaver-bin
    nixd
    vscode-langservers-extracted
    ente-auth
    vlc
    protonvpn-gui
    jellyfin-rpc
    selectdefaultapplication
    fzf
    feishin
    hyprshot
    hyprpicker
    onlyoffice-desktopeditors
    lua-language-server
    appimage-run
    ntfs3g
    xdg-user-dirs
    python3
    grim
    slurp
    copyq
    tree
    wayfreeze
    wayland-logout
    yt-dlp
    raylib
    obsidian
    obs-studio
    mpvpaper
    xwayland-satellite
    playerctl
    ffmpeg
    wlsunset
    nwg-look
    darkly
    darkly-qt5
    distrobox
    imagemagick
    krita
    matugen
    networkmanagerapplet
    papirus-icon-theme
    ncdu
    wl-clipboard
    lact
    xdg-ninja
    rustup
    gcc
    meson
    ninja
    go
    handbrake
    docker-compose
    fd
    btop
    fastfetch
    adw-gtk3
    wf-recorder
    zip
    rar
    swaynotificationcenter
    git
    foot
    quickshell
    rofi
    youtube-music
    tsukimi
    trashy

    gnome-system-monitor
    gnome-calculator
    gnome-keyring
    seahorse
    nautilus
    nautilus-portal
    lxqt.pavucontrol-qt

    nemo-with-extensions
    
    kdePackages.elisa
    kdePackages.breeze
    kdePackages.breeze.qt5
    kdePackages.partitionmanager
    kdePackages.dolphin
    kdePackages.okular
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.qtdeclarative
  ]);
}
