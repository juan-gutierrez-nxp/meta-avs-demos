SUMMARY = "Civetweb embedded web server"
HOMEPAGE = "https://github.com/civetweb/civetweb"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=9dd629b1ff864f4ddd223a38fe784672"

SRCREV = "faa63827e18fc374e7f9eed91ebebf35bd2044a5"
PV = "1.10+git${SRCPV}"
SRC_URI = "git://github.com/civetweb/civetweb.git \
           file://request-handler.patch \
	  "

S = "${WORKDIR}/git"

INSANE_SKIP_${PN} = "ldflags"
INSANE_SKIP_${PN} = "${ERROR_QA} ${WARN_QA}"
SOLIBS = ".so"
FILES_SOLIBSDEV = ""

DEPENDS = "openssl "


do_compile() {
    cd ${S}
    mkdir -p out/src
    $CC -c -DNO_SSL_DL=1  -W -Wall -DLINUX -Iinclude -DNDEBUG -fPIC -O2 src/civetweb.c -o out/src/civetweb.o
    $CXX -c -DNO_SSL_DL=1  -W -Wall -DLINUX -Iinclude -DNDEBUG -fPIC -O2  -O2 -pipe -g -feliminate-unused-debug-types  src/CivetServer.cpp -o out/src/CivetServer.o
    $CXX -shared -o libcivetweb.so -DNO_SSL_DL=1 -lcrypto -lssl -W -Wall -DLINUX -Iinclude -DNDEBUG -fPIC -O2 -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed out/src/civetweb.o out/src/CivetServer.o
}

do_install() {
    install -m 0755 -d ${D}${libdir}
    install -d ${D}${includedir}
    install ${S}/libcivetweb.so ${D}${libdir}
    install ${S}/include/*.h ${D}${includedir}
}


FILES_${PN} = "${libdir} ${includedir}"


BBCLASSEXTEND = "native nativesdk"
