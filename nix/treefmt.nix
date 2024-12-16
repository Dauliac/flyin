{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  config.perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        settings.global.excludes = [
          "*.png"
          "*.npmrc"
          "*.prettierignore"
          "*.prettierrc"
          "*.svg"
          "*.avif"
          "tailwind.config.js"
        ];
        programs = {
          prettier = {
            enable = true;
            settings.plugins = [
              "${config.packages.all}/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
              "${config.packages.all}/node_modules/prettier-plugin-svelte/plugin.js"
            ];
            includes = [
              "*.cjs"
              "*.css"
              "*.html"
              "*.js"
              "*.json"
              "*.json5"
              "*.jsx"
              "*.md"
              "*.mdx"
              "*.mjs"
              "*.scss"
              "src/**/*.ts"
              "*.tsx"
              "*.vue"
              "*.yaml"
              "*.yml"
              "*.svelte"
            ];
          };
          typos.enable = true;
          shellcheck.enable = true;
          nixfmt.enable = true;
          alejandra.enable = true;
          yamlfmt.enable = true;
          jsonfmt.enable = true;
          toml-sort.enable = true;
        };
        # NOTE: we have to fork and patch this function to add missing dependencies
        build.check =
          self:
          pkgs.runCommandLocal "treefmt-check"
            {
              buildInputs = [
                pkgs.git
                config.treefmt.build.wrapper
              ];
              meta.description = "Check that the project tree is formatted";
            }
            ''
              set -e
              # `treefmt --fail-on-change` is broken for purs-tidy; So we must rely
              # on git to detect changes. An unintended advantage of this approach
              # is that when the check fails, it will print a helpful diff at the end.
              PRJ=$TMP/project
              cp -r ${self} $PRJ
              chmod -R a+w $PRJ
              cd $PRJ
              export HOME=$TMPDIR
              cat > $HOME/.gitconfig <<EOF
              [user]
                name = Nix
                email = nix@localhost
              [init]
                defaultBranch = main
              EOF
              git init
              # NOTE: add missing dependencies
              cp -rf \
                ${config.packages.all}/node_modules \
                ${config.packages.all}/package-lock.json \
                ${config.packages.all}/package.json \
                .
              git add .
              git commit -m init --quiet
              export LANG=${if pkgs.stdenv.isDarwin then "en_US.UTF-8" else "C.UTF-8"}
              export LC_ALL=${if pkgs.stdenv.isDarwin then "en_US.UTF-8" else "C.UTF-8"}
              treefmt --version
              treefmt --no-cache
              git status
              git --no-pager diff --exit-code
              touch $out
            '';
      };
    };
}
