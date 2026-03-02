{config, lib, pkgs, inputs, ...}:
{
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
}
