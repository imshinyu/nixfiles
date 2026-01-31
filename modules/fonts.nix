{ config, lib, pkgs, inputs, ... }:
{
  fonts.packages = with pkgs; [
    # nerdfonts
    tewi-font
    jetbrains-mono
    iosevka-bin
    adwaita-fonts
    noto-fonts
    noto-fonts-cjk-sans
    font-awesome
    smiley-sans
    material-symbols
    dejavu_fonts
    liberation_ttf
    googlesans-code
    texlivePackages.nunito
    inputs.apple-emoji.packages.${system}.apple-emoji-linux
  ];
  fonts.fontconfig.defaultFonts.emoji = with pkgs; [
    "Apple Color Emoji"
  ];
}
