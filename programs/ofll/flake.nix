{
  description = "OnlineFix Linux Launcher (binary wrap)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # needed for steam + unrar
        };

        version = "2.6";

        # ── 1. Fetch the JAR directly from the GitHub release ──────────
        ofllJar = pkgs.fetchurl {
          url = "https://github.com/ZzEdovec/onlinefix-linux/releases/download/v2.6/OFMELauncher.jar";
          sha256 = "1b2yv5vhlrnqmipjadin2k2iqhr7vnwp1q17z4db88sfa1ggnqqy"; # replace after first run
        };

        # ── 2. Runtime deps (must be native — no Flatpak/Snap) ─────────
        runtimeDeps = with pkgs; [
          ffmpeg
          aria2
          unrar       # RAR archive support
          zulu8
          winetricks
          gtk3
          libx11
          libxext
          libxrender
          freetype
          fontconfig
        ];

        # ── 3. Inner derivation: install the JAR + launch script ───────
        ofllInner = pkgs.stdenv.mkDerivation {
          pname = "onlinefix-linux-launcher";
          inherit version;

          dontUnpack = true;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            # Install the JAR
            install -Dm644 ${ofllJar} $out/share/onlinefix-linux/OFMELauncher.jar

            # Install icon (placeholder — swap with real PNG if you extract it)
            mkdir -p $out/share/icons/hicolor/256x256/apps

            # Write the launch script
            mkdir -p $out/bin
            cat > $out/bin/onlinefix-linux-launcher <<'EOF'
            #!/bin/sh
            exec java \
              -Dprism.forceGPU=true \
              -Dawt.useSystemAAFontSettings=on \
              -Dswing.aatext=true \
              -jar /run/current-system/sw/share/onlinefix-linux/OFMELauncher.jar \
              "$@"
            EOF
            # That path won't work outside NixOS — makeWrapper fixes it below
            rm $out/bin/onlinefix-linux-launcher

            makeWrapper ${pkgs.zulu8}/bin/java $out/bin/onlinefix-linux-launcher \
              --add-flags "-Dprism.forceGPU=true" \
              --add-flags "-Dawt.useSystemAAFontSettings=on" \
              --add-flags "-Dswing.aatext=true" \
              --add-flags "-jar $out/share/onlinefix-linux/OFMELauncher.jar" \
              --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps} \
              --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeDeps}

            # .desktop entry
            install -Dm644 /dev/stdin $out/share/applications/onlinefix-linux-launcher.desktop <<EOF
            [Desktop Entry]
            Name=OnlineFix Linux Launcher
            Comment=Launch games with OnlineFix multiplayer patches
            Exec=onlinefix-linux-launcher
            Icon=onlinefix-linux-launcher
            Terminal=false
            Type=Application
            Categories=Game;
            EOF
          '';
        };

      in {
        # ── 4. Package: FHS wrapper (Wine + Steam expect /usr/lib etc.) ─
        packages.default = pkgs.buildFHSEnv {
          name = "onlinefix-linux-launcher";

          targetPkgs = _: [
            ofllInner
            pkgs.zulu8
            pkgs.steam
          ] ++ runtimeDeps;

          # FHS env exposes these extra libs inside the sandbox
          multiPkgs = _: with pkgs; [
            steam-run
          ];

          runScript = "${ofllInner}/bin/onlinefix-linux-launcher";

          meta = with pkgs.lib; {
            description = "Steam/Epic OnlineFix launcher for Linux";
            homepage    = "https://github.com/ZzEdovec/onlinefix-linux";
            license     = licenses.agpl3Only;
            platforms   = [ "x86_64-linux" ];
            mainProgram = "onlinefix-linux-launcher";
          };
        };

        # ── 5. App shortcut ────────────────────────────────────────────
        apps.default = {
          type    = "app";
          program = "${self.packages.${system}.default}/bin/onlinefix-linux-launcher";
        };

        # ── 6. Dev shell (useful for hacking on the wrapper) ───────────
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.zulu8 ] ++ runtimeDeps;
          shellHook = ''
            echo "Java: $(java -version 2>&1 | head -1)"
            echo "JAR: ${ofllJar}"
          '';
        };
      }
    );
}
