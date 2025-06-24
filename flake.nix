{
  description = "My Nix-Powered Neovim Configuration";

  outputs =
    {
      nixpkgs,
      nixvim,
      self,
      ...
    }@inputs:
    let
      # ========= Architectures =========
      # Helper function to generate attributes for each supported system.
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        # Uncomment for macOS support if needed:
        # "x86_64-darwin"
        # "aarch64-darwin"
      ];

      # Helper function to construct the core NixVim module configuration.
      mkModule =
        {
          system,
          extraArgs ? { },
        }:
        {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          # Define the module imports for your NixVim configuration
          module = import ./config;
          # Pass extraSpecialArgs to the module, making them accessible within the module
          extraSpecialArgs = {
            inherit system;
          } // extraArgs;
        };
    in
    {
      # ========= Formatting =========
      # Nix formatter available through 'nixfmt' https://github.com/NixOS/nixfmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # ========= Checks =============
      # Defines integrity checks and tests for the flake.
      checks = forAllSystems (system: {
        # Default check: Builds and tests the NixVim configuration
        default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule (mkModule {
          inherit system;
        });

        # Pre-commit checks, defined in ./checks.nix
        inherit
          (import ./checks.nix {
            inherit inputs system;
          })
          pre-commit-check
          ;
      });

      # Dev shell with pre commit hooks
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

      # ========= Packages =========
      packages = forAllSystems (system: {
        default = nixvim.legacyPackages.${system}.makeNixvimWithModule (mkModule {
          inherit system;
        });
      });
    };

  inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nuschtosSearch.follows = "";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixvim/nixpkgs";
    };
  };
}
