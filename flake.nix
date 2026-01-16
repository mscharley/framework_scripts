{
	description = "";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# flake-utils helps us write flakes that work on multiple systems (Linux, macOS)
		# Documentation: https://github.com/numtide/flake-utils
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = nixpkgs.legacyPackages.${system};
			in {
				devShells.default = pkgs.mkShell {
					buildInputs = (with pkgs.python313Packages; [
						python pygobject3
					]) ++ (with pkgs; [ libfprint glib gusb ]);

					nativeBuildInputs = with pkgs; [
						gobject-introspection
					];
				};
			}
		);
}
