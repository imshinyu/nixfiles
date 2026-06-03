{ config, lib, pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
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
    seanime
    spicetify-cli
    google-chrome
    yazi
    protonplus
    pywalfox-native
    equibop
    librewolf
    (discord.override {
      # withOpenASAR = true;
      withEquicord = true;
    })
    
  ]) ++ (with pkgs; [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix
    inputs.qtengine.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.qtengine.packages.${pkgs.stdenv.hostPlatform.system}.default.qt5
    upscayl
    dysk
    zed-editor-fhs
    mpv
    arrpc
    sqlite
    dbeaver-bin
    nixd
    vscode-langservers-extracted
    ente-auth
    protonvpn-gui
    jellyfin-rpc
    fzf
    feishin
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
    git
    foot
    noctalia-shell
    rofi
    youtube-music
    tsukimi
    trashy

    lxqt.pavucontrol-qt

    
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
