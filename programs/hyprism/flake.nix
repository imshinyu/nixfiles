{
  description = "HyPrism";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.appimageTools.wrapType2 {
      pname = "hyprism";
      version = "3.0.1";
      src = pkgs.fetchurl {
        url = "https://github.com/hyprismteam/HyPrism/releases/download/v3.0.1/HyPrism-linux-x86_64-3.0.1.AppImage";
        hash = "sha256-vb93cI9ABNJqrhe09JB0oTz5dCe9cPfPj/U3Ps/Ud+s=";
      };
      extraPkgs = pkgs: with pkgs; [
        dotnet-runtime_10
        icu
        openssl
        zlib
      ];
    };
  };
}
