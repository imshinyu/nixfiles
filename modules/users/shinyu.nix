{ config, pkgs, inputs, ...}:

{
  users.users.shinyu = {
    isNormalUser = true;
    description = "shinyu";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users" "kvm"];
    packages = with pkgs; [
    ];
  };
  hjem.users.shinyu = {
    user = "shinyu";
    directory = "/home/shinyu";
  };
}
