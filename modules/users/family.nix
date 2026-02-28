{ config, pkgs, inputs, ...}:

{
  users.users.family = {
    isNormalUser = true;
    description = "family";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
    packages = with pkgs; [
    ];
  };
  security.pam.services.family.kwallet.enable = true;
  hjem.users.family = {
    user = "family";
    directory = "/home/family";
  };
}
