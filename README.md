# celestia.flake

Nix Flake for easily installing Celestia. Currently linux only.

Given an unstable version of Nix / NixOS that supports flakes, run:

```
# for the consensus node
nix build github:Quiark/celestia.flake
./result/bin/celestia-appd

# for the storage and light node
nix build github:Quiark/celestia.flake#node
./result/bin/celestia
```
