{ config, pkgs, inputs, ...}:

{
  users.users.shinyu = {
    isNormalUser = true;
    description = "shinyu";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users" "kvm"];
    packages = with pkgs; [
     # thunderbird
    ];
  };
  hjem.users.shinyu = {
    user = "shinyu";
    directory = "/home/shinyu";
    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "~/.local/share/color-schemes/Matugen.colors";
          iconTheme = "Papirus-Dark";
          style = "Darkly";
    
          font = {
            family = "Nunito";
            size = 12;
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
          menusHaveIcons = false;
          shortcutsForContextMenus = false;
        };
      };
    };
  };
}
