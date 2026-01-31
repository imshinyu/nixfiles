{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    niri.url = "github:Naxdy/niri";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixcord.url = "github:FlameFlag/nixcord";
    apple-emoji = {
      url ="github:samuelngs/apple-emoji-linux";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.sapphire = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./modules/hosts/sapphire/default.nix
        inputs.hjem.nixosModules.default
        inputs.qtengine.nixosModules.default
        inputs.niri.nixosModules.default
        inputs.mango.nixosModules.mango
        inputs.nixcord.nixosModules.nixcord
        inputs.spicetify-nix.nixosModules.spicetify
      ];
    };
  };
}
