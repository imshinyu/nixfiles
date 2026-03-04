{ config, lib, pkgs, inputs, ...}:
{
  users.users.heisenberg = {
    isNormalUser = true;
    description = "heisenberg";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
  };
}
