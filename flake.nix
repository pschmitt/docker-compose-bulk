{
  description = "docker-compose-bulk flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        dcpPkg = pkgs.stdenv.mkDerivation {
          pname = "docker-compose-bulk";
          version = "0.0.1";

          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            mkdir -p $out/bin
            cp $src/docker-compose-bulk $out/bin/docker-compose-bulk
            chmod +x $out/bin/docker-compose-bulk

            wrapProgram $out/bin/docker-compose-bulk --prefix PATH : ${
              pkgs.lib.makeBinPath [
                pkgs.bash
                pkgs.docker
              ]
            }
          '';

          meta = with pkgs.lib; {
            description = "Simple docker compose wrapper to perform bulk operations.";
            license = licenses.gpl3Only;
            maintainers = with maintainers; [ pschmitt ];
            mainProgram = "docker-compose-bulk";
            platforms = platforms.all;
          };
        };
      in
      {
        # pkgs
        packages.myl = dcpPkg;
        defaultPackage = dcpPkg;
      }
    );
}
