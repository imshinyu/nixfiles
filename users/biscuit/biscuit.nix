{ config, lib, pkgs, inputs, ...}:
{
  users.users.biscuit = {
    isNormalUser = true;
    description = "biscuit";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
  };
}
