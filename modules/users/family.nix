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
  hjem.users.family = {
    user = "family";
    directory = "/home/family";
  };
}
