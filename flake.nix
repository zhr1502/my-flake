{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      {
        packages =
          let pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            trilium-desktop-cn =
              let
                version = "0.59.3";
                date = "20230328";
                trilium-desktop-cn = pkgs.trilium-desktop.overrideAttrs
                  (finalAttrs: previousAttrs: {
                    src =
                      pkgs.fetchurl {
                        url = "https://github.com/Nriver/trilium-translation/releases/download/v${version}_${date}/trilium-cn-linux-x64.zip";
                        sha256 = "1605da5156b9f215c6b780d400e3d72e77745c1292df69fdf70c7d77a2fec6c6";
                      };
                    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ pkgs.unzip ];
                    pname = "trilium-desktop-cn";
                    inherit version;
                  });
              in
              trilium-desktop-cn;
          };
      }
    );
}
