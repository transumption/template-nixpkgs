{ pkgs ? import ./. {} }:

with pkgs;

{
  exampleos = recurseIntoAttrs {
    qemu = buildImage ./profiles/hardware/qemu;
  };


  tests = recurseIntoAttrs {
    boot = import ./tests/boot.nix { inherit pkgs; };
  };
}
