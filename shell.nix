{ pkgs ? import ./. {} }:

with pkgs;

let
  root = toString ./.;
in

stdenvNoCC.mkDerivation {
  name = "example-nixpkgs";

  shellHook = ''
    example-switch() {
      sudo -E nixos-rebuild switch --fast -I nixos-config=/etc/nixos/configuration.nix
    }
    example-shell() {
      $(nix-build default.nix -A example-nixpkgs.qemu --no-out-link)/bin/run-nixos-vm
    }
  '';

  NIX_PATH = builtins.concatStringsSep ":" [
    "example-nixpkgs=${root}"
    "nixpkgs=${pkgs.path}"
    "nixpkgs-overlays=${root}/overlays"
  ];

  QEMU_OPTS = "-m 2048 -nographic";
}
