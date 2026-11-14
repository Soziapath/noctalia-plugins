# Noctalia plugins

A flake that assembles Noctalia v5 plugins into a directory Noctalia can load
as a path source. [LUKS Unlock](https://github.com/Soziapath/nix-tools/tree/main/luks-unlock)
is packaged by the nix-tools flake.

Add the collection to your NixOS flake:

```nix
inputs.soziapath-plugins.url = "github:Soziapath/noctalia-plugins";
```

Merge the following into your Noctalia settings, retaining any existing sources
and widgets. Pass `inputs` to the module through your flake's module arguments.

```nix
{ inputs, pkgs, ... }:
{
  programs.noctalia.settings = {
    plugins.source = [{
      name = "soziapath-plugins";
      kind = "path";
      location = toString inputs.soziapath-plugins.packages.${pkgs.stdenv.hostPlatform.system}.default;
      enabled = true;
    }];
    plugins.enabled = [ "soziapath/luks-unlock" ];
    bar.main.end = [ "luks-unlock" ];
    widget.luks-unlock.type = "soziapath/luks-unlock:bar";
    plugin_settings."soziapath/luks-unlock" = {
      host = "proxmox.example.test";
      identity = "~/.ssh/luks-unlock";
    };
  };
}
```

Run `nix flake update nix-tools` to refresh the packaged plugin.
