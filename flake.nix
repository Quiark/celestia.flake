{
    description = "Run Celestia";
    inputs.nixpkgs.url = github:NixOS/nixpkgs/21.11;
    inputs.deploy-rs.url = "github:serokell/deploy-rs";
    outputs = { self, nixpkgs, deploy-rs }: {
	deploy.nodes.tufir = {
          hostname = "tufir.valid";
          sshUser = "root";
          profiles.celes = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.noop self.defaultPackage.x86_64-linux;
          };
        };
        defaultPackage.x86_64-linux =
            with import nixpkgs { system = "x86_64-linux"; };
            buildGoModule rec {
              pname = "celestia";
              name = "celestia";
              # version = "144cd92ef02898bf190822b3ed1e9396b58ef424";

              src = fetchFromGitHub {
                owner = "celestiaorg";
                repo = "celestia-app";
                rev = "144cd92ef02898bf190822b3ed1e9396b58ef424";
                sha256 = "1cl7wpca539p82md6jyfqp41s83zw055c21zjqqyxiphgjzqj4ra";
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
              };
            };

    };
}
