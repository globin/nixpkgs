{ cabal, happstackServer, mtl, text }:

cabal.mkDerivation (self: {
  pname = "happstack-lite";
  version = "7.3.4";
  sha256 = "06ndqfd4x49yi17kgiz5xr05l1k6sj5g1f6kir10wgsqhmd0q811";
  buildDepends = [ happstackServer mtl text ];
  meta = {
    homepage = "http://www.happstack.com/";
    description = "Happstack minus the useless stuff";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
