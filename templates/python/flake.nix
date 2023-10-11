{
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    # systems.url = "github:nix-systems/default";
  };

  outputs = {
    systems,
    nixpkgs,
    ...
  } @ inputs: let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system:
          f nixpkgs.legacyPackages.${system}
      );
  in {
    devShells = eachSystem (pkgs: {
      default = let
        pythonPackages = ps:
          with ps; [
            # Place your py packages here
            # tensorflow
            # pytorch

            # Define packages unavailable in Nixpkgs here
            # (
            #   buildPythonPackage rec {
            #     pname = "deserialize";
            #     version = "1.8.3";
            #     src = fetchPypi {
            #       inherit pname version;
            #       sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
            #     };
            #     doCheck = false;
            #     propagatedBuildInputs = [
            #       # Specify dependencies
            #       pkgs.python3Packages.numpy
            #     ];
            #   }
            # )
          ];
      in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            (python3.withPackages pythonPackages)
          ];
        };
    });
  };
}
