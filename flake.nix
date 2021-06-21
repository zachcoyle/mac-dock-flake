{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    mach-nix.url = github:DavHau/mach-nix;
    # mac-dock-src = { url = github:andrewp-as-is/mac-dock; flake = false; };
    mac-dock-src = { url = github:zachcoyle/mac-dock/remove-ds_store-reference; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, mac-dock-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        mac-dock = (import mach-nix { inherit pkgs; }).buildPythonApplication {
          src = mac-dock-src;
          nativeBuildInputs = with pkgs; [ php ];
        };
      in
      rec {
        packages.mac-dock = mac-dock;
        defaultPackage = packages.mac-dock;
      });
}
