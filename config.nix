{
    description = "Darren's NixOS configuration";
  
    inputs = {
      # Principle inputs
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-parts.url = "github:hercules-ci/flake-parts";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      agenix.url = "github:ryantm/agenix";
      nixos-hardware.url = "github:NixOS/nixos-hardware";
  
      # CI server
      hci.url = "github:hercules-ci/hercules-ci-agent";
      nix-serve-ng.url = "github:aristanetworks/nix-serve-ng";
  
      # Devshell inputs
      mission-control.url = "github:Platonic-Systems/mission-control";
      mission-control.inputs.nixpkgs.follows = "nixpkgs";
      flake-root.url = "github:srid/flake-root";
  
      # Software inputs
      nixos-shell.url = "github:Mic92/nixos-shell";
      nixos-vscode-server.url = "github:msteen/nixos-vscode-server";
      nixos-vscode-server.flake = false;
      comma.url = "github:nix-community/comma";
      comma.inputs.nixpkgs.follows = "nixpkgs";
      emanote.url = "github:srid/emanote";
      nixpkgs-match.url = "github:srid/nixpkgs-match";
  
      # Emacs
      emacs-overlay.url = "github:nix-community/emacs-overlay";
  
      # Vim & its plugins (not in nixpkgs)
      zk-nvim.url = "github:mickael-menu/zk-nvim";
      zk-nvim.flake = false;
      coc-rust-analyzer.url = "github:fannheyward/coc-rust-analyzer";
      coc-rust-analyzer.flake = false;
    };
  
    outputs = inputs@{ self, home-manager, nixpkgs, ... }:
      inputs.flake-parts.lib.mkFlake { inherit (inputs) self; } {
        systems = [ "x86_64-linux" ];
        imports = [
          inputs.flake-root.flakeModule
          inputs.mission-control.flakeModule
          ./lib.nix
          ./users
          ./home
          ./nixos
        ];
  
        flake = {
          # Configurations for Linux (NixOS) systems
          nixosConfigurations = {
            # My Linux development computer (on Hetzner)
            pinch = self.lib.mkLinuxSystem {
              imports = [
                self.nixosModules.default # Defined in nixos/default.nix
                ./systems/hetzner/ax41.nix
                ./nixos/server/harden.nix
                ./nixos/hercules.nix
              ];
            };
          };
        perSystem = { pkgs, config, inputs, ... }: {
          devShells.default = config.mission-control.installToDevShell (pkgs.mkShell {
            buildInputs = [
              pkgs.nixpkgs-fmt
              inputs'.agenix.packages.agenix
            ];
          });
          formatter = pkgs.nixpkgs-fmt;
        };
      };
  }