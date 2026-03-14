{
  description = "My super duper awesome flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    # millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nixcord.url = "github:FlameFlag/nixcord";
    nix-index.url = "github:nix-community/nix-index-database";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elysia = {
      url = "git+https://dawn.wine/foxtrottt/elysia-on-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprism = {
      url = "path:/home/shinyu/nixfiles/programs/hyprism";
    };
    niri-screentime = {
      url = "github:probeldev/niri-screen-time";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      # these are only required for internal tests,
      # hence you can set em to nothing
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };
  };  
  outputs = { self, nixpkgs, aagl, ... }@inputs:
        let
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree =
        path:
        toList (fileFilter (file: file.hasExt "nix" && !(inputs.nixpkgs.lib.hasPrefix "_" file.name)) path);
    in
   {
      nixosConfigurations = {
	    sapphire = nixpkgs.lib.nixosSystem {
	      specialArgs = {
	        inherit inputs;
	        inherit aagl;
	      };
	      modules = 
	        (import-tree ./modules)
	       ++ (import-tree ./hosts/sapphire)
	       ++ [
	        ./hosts/common.nix
          ./users/shinyu/default.nix
          ./users/biscuit/default.nix
          ./users/family/default.nix
	        # inputs.qtengine.nixosModules.default
	        inputs.mango.nixosModules.mango
	        inputs.hjem.nixosModules.default
	        inputs.nix-index.nixosModules.default
	      ];
	    };
	  };
	};
}
