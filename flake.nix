{
    description = "Run Celestia";
    inputs.nixpkgs.url = github:NixOS/nixpkgs/21.11;
    outputs = { self, nixpkgs }: rec {

    defaultPackage.x86_64-linux = appd;

    # to update version, set sha256 attribute to empty string
    # same with vendorSha256
    # then run
    # nix build .
    appd = 
        with import nixpkgs { system = "x86_64-linux"; };
        buildGoModule rec {
          pname = "celestia-app";
          name = "celestia-app";

          src = fetchFromGitHub {
            owner = "celestiaorg";
            repo = "celestia-app";
            rev = "78346556340b99bb4193703097f62779399e2ffe";
            sha256 = "sha256-8Pra7ZQtbe5Z4/iEt6+o3A+quPVjZ/x1su1TPa3aYh4=";
          };

          buildInputs = [ go_1_17 packr ];

          runVend = false;
          vendorSha256 = "sha256-MFq2tHVRfS+Uc7e7y4+Xa3n9lTCFdKvHlzSl7E/qEDg=";

          meta = with lib; {
            description = "Modular data availability layer";
            homepage = "https://github.com/celestiaorg/celestia-app";
            license = licenses.asl20;
            maintainers = with maintainers; [ ];
            platforms = platforms.linux ++ platforms.darwin;
            mainProgram = "celestia-appd";
          };
        };

    node = 
    with import nixpkgs { system = "x86_64-linux"; };
      buildGoModule rec {
          pname = "celestia-node";
          name = "celestia-node";

          src = fetchFromGitHub {
            owner = "celestiaorg";
            repo = "celestia-node";
            rev = "7b59bfad569cb313de4d06c6af701d14b7060c40";
            sha256 = "sha256-KPthhZIm8h2uhwyV6E4hitUUiE+T89crseMl+wf3ZzY";
          };

          buildInputs = [ go_1_17 packr ];

          runVend = false;
          vendorSha256 = "sha256-bxvcHZoF5nVHiAudLcDuJkXBh+EXfzb/cMC6Uguk/18";

          meta = with lib; {
            description = "Modular data availability layer, full node";
            homepage = "https://github.com/celestiaorg/celestia-node";
            license = licenses.asl20;
            maintainers = with maintainers; [ ];
            platforms = platforms.linux ++ platforms.darwin;
            mainProgram = "celestia";
          };
      };
  };
}
