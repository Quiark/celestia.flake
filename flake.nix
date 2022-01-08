{
    description = "Run Celestia";
    inputs.nixpkgs.url = github:NixOS/nixpkgs/21.11;
    inputs.deploy-rs.url = "github:serokell/deploy-rs";
    outputs = { self, nixpkgs, deploy-rs }: rec {

	deploy.nodes.tufir = {
      hostname = "tufir.valid";
      sshUser = "root";
      profiles.celes = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.noop self.defaultPackage.x86_64-linux;
      };
    };

    defaultPackage.x86_64-linux = appd;

    appd = 
        with import nixpkgs { system = "x86_64-linux"; };
        buildGoModule rec {
          pname = "celestia-app";
          name = "celestia-app";

          src = fetchFromGitHub {
            owner = "celestiaorg";
            repo = "celestia-app";
            rev = "c2adcb157cc39f58368a5779b01e655520f67890";
            sha256 = "sha256-0zRWhXy/LMdtJz/+5AZZmfBO8XybiJ47svndwUq6+GA=";
          };

          buildInputs = [ go_1_17 packr ];

          runVend = false;
          vendorSha256 = "sha256-R6dggu8f/fteiCSEe315m4iG4gnXj2SOLFz3hZbdVyo=";

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
            rev = "f9ad11e4c651a78fc06ca697df0dcac10073e3c3";
            sha256 = "sha256-cmdt5cU50O8vr4rvdFIZsMqR1fM/i5u/Hd0BL6JVCj8=";
          };

          buildInputs = [ go_1_17 packr ];

          runVend = false;
          vendorSha256 = "sha256-5//vHtv2oPhoKvcYZ85EYFza1bscgrpFNQPzrDW/A10=";

          meta = with lib; {
            description = "Modular data availability layer, full node";
            homepage = "https://github.com/celestiaorg/celestia-node";
            license = licenses.asl20;
            maintainers = with maintainers; [ ];
            platforms = platforms.linux ++ platforms.darwin;
            mainProgram = "celestia-node";
          };
      };


  };
}
