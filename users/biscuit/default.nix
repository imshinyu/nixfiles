{ config, lib, pkgs, inputs, ...}:
let
  dots = "${../../dots}";
in
{
  users.users.biscuit = {
    isNormalUser = true;
    description = "biscuit";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
  };
  hjem.extraModules = [inputs.hjem-impure.hjemModules.default];
  hjem.users.biscuit = {
    user = "biscuit";
    directory = "/home/biscuit";
    impure = {
      enable = true;
      dotsDir = "${dots}";
      dotsDirImpure = "/home/shinyu/nixfiles/dots";
    };
    xdg.config.files = {
      "fastfetch".source = dots + "/fastfetch";
      "fish".source = dots + "/fish";
      "foot".source = dots + "/foot";
      "gtk-3.0".source = dots + "/gtk-3.0";
      "gtk-4.0".source = dots + "/gtk-4.0";
      "helix".source = dots + "/helix";
      "mako".source = dots + "/mako";
      "mango".source = dots + "/mango";
      "matugen".source = dots + "/matugen";
      "niri".source = dots + "/niri";
      "qtengine".source = dots + "/qtengine";
      "quickshell".source = dots + "/quickshell";
      "rofi".source = dots + "/rofi";
      "yazi".source = dots + "/yazi";
    };
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtengine";
    };
  };
}
