{ config, lib, pkgs, inputs, ...}:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    android-studio
    waydroid-helper
    waydroid-nftables
    scrcpy #screencast android
  ];
}
