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

        # Choose a Zig version available in zig-overlay. See repo for available versions.
        zig = pkgs.zigpkgs."0.14.1"; 
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
          packages = [ zig ];

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

