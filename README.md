```sh
sudo nixos-rebuild switch --flake .#laptop-x17 --impure
```
# Virtiofs
```yaml
<binary path='/run/current-system/sw/bin/virtiofsd' xattr='on'/>
```
```sh
nix build .#qcow
(
cp result/nixos.qcow2 ~/
virt-install \
  --connect qemu:///system \
  --disk ~/nixos.qcow2 \
  --import \
  --memory 8192 \
  --name nixos \
  --network bridge:virbr0 \
  --os-variant nixos-unstable \
  --vcpus 2 \
  ;
)
```
