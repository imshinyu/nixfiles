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
  security.pam.services.shinyu.kwallet.enable = true;
  hjem.users.shinyu = {
    user = "shinyu";
    directory = "/home/shinyu";
  };
}
