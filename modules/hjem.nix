{config, inputs, pkgs, ...}:
{
  imports = [
    ./users/shinyu.nix
    ./users/biscuit.nix
    ./users/family.nix
  ];
  hjem = {
    extraModules = [
    ];
  };
}
