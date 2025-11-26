{
  inputs = {
    zig-overlay.url = "github:mitchellh/zig-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; 
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, zig-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ zig-overlay.overlays.default ];
        };

        zig = pkgs.zigpkgs."0.15.1";

        zls = pkgs.zls.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ zig ];
        });
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          src = ./.;
          nativeBuildInputs = [ zig ];
          buildPhase = ''
            zig build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp zig-out/bin/* $out/bin/
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = [ zig zls ];

          shellHook = ''
            # Check we're not already in zsh to avoid infinite loop
            if [ -z "$IN_NIX_ZSH" ]; then
              export IN_NIX_ZSH=1
              exec ${pkgs.zsh}/bin/zsh
            fi
          '';
        };
      });
}

