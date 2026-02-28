{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nixcord.url = "github:FlameFlag/nixcord";
    nix-index.url = "github:nix-community/nix-index-database";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    elysia = {
      url = "git+https://dawn.wine/foxtrottt/elysia-on-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dms = {
    #   url = "github:AvengeMedia/DankMaterialShell/stable";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    # apple-emoji = {
    #   url ="github:samuelngs/apple-emoji-linux";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fht-compositor = {
      url = "github:nferhat/fht-compositor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "";
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
        inputs.mango.nixosModules.mango
        inputs.fht-compositor.nixosModules.default
        inputs.spicetify-nix.nixosModules.spicetify
        # inputs.dms.nixosModules.default
        inputs.nixcord.nixosModules.nixcord
        inputs.nix-index.nixosModules.default
      ];
    };
    nixosConfigurations.ruby = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./modules/hosts/ruby/default.nix
        inputs.hjem.nixosModules.default
        inputs.qtengine.nixosModules.default
        inputs.mango.nixosModules.mango
        inputs.nixcord.nixosModules.nixcord
        inputs.spicetify-nix.nixosModules.spicetify
      ];
    };
    # nixosConfigurations.onyx = nixpkgs.lib.nixosSystem {
    #   specialArgs = {
    #     inherit inputs;
    #   };
    #   modules = [
    #     ./modules/hosts/onyx/default.nix
    #   ];
    # };
  };
}
