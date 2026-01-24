{ config, pkgs, inputs, ...}:

{
  users.users.family = {
    isNormalUser = true;
    description = "family";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
    packages = with pkgs; [
      wayfirePlugins.wcm
    ];
  };
  hjem.users.family = {
    user = "family";
    directory = "/home/family";
    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "~/.local/share/color-schemes/Matugen.colors";
          iconTheme = "Papirus-Dark";
          style = "Darkly";
    
          font = {
            family = "Noto Sans";
            size = 11;
            weight = -1;
          };
    
          fontFixed = {
            family = "Noto Sans";
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
