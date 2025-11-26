{
  inputs = {
    zig-overlay.url = "github:mitchellh/zig-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; 
    flake-utils.url = "github:numtide/flake-utils";
    # Pin nixpkgs to a commit that packages zls 0.14.0 (from lazamar)
    zls-nixpkgs.url = "github:NixOS/nixpkgs/e6f23dc08d3624daab7094b701aa3954923c6bbb";
  };

  outputs = { self, nixpkgs, zig-overlay, flake-utils, zls-nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ zig-overlay.overlays.default ];
        };

        # Choose a Zig version available in zig-overlay. See repo for available versions.
        zig = pkgs.zigpkgs."0.14.1";
        # Import zls 0.14.0 from pinned nixpkgs commit
        zls = (import zls-nixpkgs { inherit system; }).zls;
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

