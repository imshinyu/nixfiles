{ config, lib, pkgs, inputs, ...}:
{
  users.users.family = {
    isNormalUser = true;
    description = "family";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
  };
}
