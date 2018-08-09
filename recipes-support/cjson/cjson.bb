LICENSE = "MIT"

FILESEXTRAPATHS_prepend := "${THISDIR}:"
S = "${WORKDIR}"
SRC_URI = "\
	file://cJSON.c \
	file://cJSON.h \ 
	file://LICENSE \
	file://Makefile \
"
LIC_FILES_CHKSUM = "file://LICENSE;md5=15a8fdf366dae882d0e23bd8e5f48b4e"
SRCREV = "${AUTOREV}"


INSANE_SKIP_${PN} = "${ERROR_QA} ${WARN_QA} dev-so dev-elf"
SOLIBS = ".so"
FILES_SOLIBSDEV = ""

do_unpack() {
	cp -f ${FILE_DIRNAME}/files/LICENSE ${WORKDIR}/
	cp -f ${FILE_DIRNAME}/files/Makefile ${WORKDIR}/
	cp -f ${FILE_DIRNAME}/files/cJSON.c ${WORKDIR}/
	cp -f ${FILE_DIRNAME}/files/cJSON.h ${WORKDIR}/
}

do_compile(){
	oe_runmake
}

do_install() {
	install -d ${D}${includedir}
	install -d ${D}${libdir}
	install -m 0755 ${WORKDIR}/cJSON.h ${D}${includedir}
	install -m 0755 ${WORKDIR}/libcjson.so ${D}${libdir}
	rm ${WORKDIR}/cJSON.*
	rm ${WORKDIR}/Makefile
}


FILES_${PN} = "${includedir} ${libdir}"
		
BBCLASSEXTEND = "native nativesdk"
