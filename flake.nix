{
  description = "Nixos + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "git+ssh://git@gitlab.com/alexforsale/wallpapers";
      flake = false;
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; 
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    nixos-wsl,
    ...
  } @ inputs: let
    systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
      overlays = import ./overlays {inherit inputs;};
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        angola = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            sops-nix.nixosModules.sops
            ./nixos/angola
          ];
        };

        zanzibar = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            nixos-wsl.nixosModules.default
            sops-nix.nixosModules.sops
            ./nixos/zanzibar
          ];
        };
      };

      homeConfigurations = {
        "alexforsale@angola" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs;};
          modules = [
            sops-nix.homeManagerModules.sops
            ./home-manager/angola/alexforsale
          ];
        };
        "alexforsale@zanzibar" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs;};
          modules = [
            sops-nix.homeManagerModules.sops
            ./home-manager/zanzibar/alexforsale
          ];
        };
      };
  };
}
