{ config, pkgs, inputs, ...}:

{
  users.users.biscuit = {
    isNormalUser = true;
    description = "biscuit";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
    packages = with pkgs; [
     # thunderbird
    ];
  };
  hjem.users.biscuit = {
    user = "biscuit";
    directory = "/home/biscuit";
    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "~/.local/share/color-schemes/Matugen.colors";
          iconTheme = "Papirus-Dark";
          style = "Darkly";
    
          font = {
            family = "Iosevka";
            size = 11;
            weight = -1;
          };
    
          fontFixed = {
            family = "Iosevka Fixed";
            size = 11;
            weight = -1;
          };
        };
        misc = {
          singleClickActivate = false;
          menusHaveIcons = true;
          shortcutsForContextMenus = true;
        };
      };
    };
  };
}
