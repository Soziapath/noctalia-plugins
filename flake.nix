{
  description = "Soziapath's Noctalia plugin collection";

  inputs.nix-tools.url = "github:Soziapath/nix-tools?dir=luks-unlock";
  inputs.nixpkgs.follows = "nix-tools/nixpkgs";

  outputs = { nixpkgs, nix-tools, ... }: {
    packages = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: {
      default = nixpkgs.legacyPackages.${system}.linkFarm "soziapath-noctalia-plugins" [
        {
          name = "luks-unlock";
          path = nix-tools.packages.${system}.noctalia-plugin;
        }
      ];
    });
  };
}
