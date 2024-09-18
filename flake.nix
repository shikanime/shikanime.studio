{
  description = "Shikanime's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-public-keys = [
      "shikanime.cachix.org-1:OrpjVTH6RzYf2R97IqcTWdLRejF6+XbpFNNZJxKG8Ts="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
    extra-substituters = [
      "https://shikanime.cachix.org"
      "https://devenv.cachix.org"
    ];
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem = { pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          enableDefaultExcludes = true;
          programs = {
            actionlint.enable = true;
            statix.enable = true;
            deadnix.enable = true;
            shfmt.enable = true;
            nixpkgs-fmt.enable = true;
            prettier = {
              enable = true;
              includes = [
                "*.astro"
                "*.js"
                "*.json"
                "*.jsx"
                "*.md"
                "*.mjs"
                "*.ts"
                "*.tsx"
                "*.yaml"
              ];
              settings.plugins = [
                "prettier-plugin-astro"
                "prettier-plugin-tailwindcss"
              ];
            };
          };
          settings.global.excludes = [
            "**/node_modules"
          ];
        };
        devenv.shells.default = {
          containers = pkgs.lib.mkForce { };
          languages = {
            nix.enable = true;
            javascript = {
              enable = true;
              npm = {
                enable = true;
                install.enable = true;
              };
            };
          };
          cachix = {
            enable = true;
            push = "shikanime";
          };
          packages = [
            pkgs.gh
          ];
        };
      };
    };
}
