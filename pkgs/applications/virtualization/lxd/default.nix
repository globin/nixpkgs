{ stdenv, fetchurl, go, goPackages, rsync, python3 }:

with goPackages;

buildGoPackage rec {
  name = "lxd-${version}";
  version = "0.8.1";
  goPackagePath = "github.com/lxc/lxd";

  buildInputs = [ python3 rsync context crypto gettext go-lxc-v2 go-sqlite3 go-uuid mux petname protobuf tablewriter tomb websocket yaml-v2 ];

  src = fetchurl {
    url = "https://linuxcontainers.org/downloads/lxd/lxd-${version}.tar.gz";
    sha256 = "0q4h8pw6w01g3dh3y3jbz9q8m13gj3qq48misp3zzsmky4b3r8xn";
  };

  patches = [ ./fix-path.patch ];

  subPackages = [ "shared" "./" "fuidshift" "internal/gnuflag" "lxc" "lxd" "lxd/migration" ];

  postInstall = ''
    cp go/src/$goPackagePath/scripts/lxd-images $out/bin
  '';

  meta = with stdenv.lib; {
    homepage = "https://linuxcontainers.org/lxd/";
    description = "container \"hypervisor\" and new user experience for LXC";
    license = licenses.asl20;

    maintainers = with maintainers; [ globin ];
  };
}
