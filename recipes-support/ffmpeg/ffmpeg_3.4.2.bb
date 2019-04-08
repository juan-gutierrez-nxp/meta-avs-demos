SUMMARY = "A complete, cross-platform solution to record, convert and stream audio and video."
DESCRIPTION = "FFmpeg is the leading multimedia framework, able to decode, encode, transcode, \
               mux, demux, stream, filter and play pretty much anything that humans and machines \
               have created. It supports the most obscure ancient formats up to the cutting edge."
HOMEPAGE = "https://www.ffmpeg.org/"
SECTION = "libs"

LICENSE = "BSD & GPLv2+ & LGPLv2.1+ & MIT"
LICENSE_${PN} = "GPLv2+"
LICENSE_libavcodec = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libavdevice = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libavfilter = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libavformat = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libavresample = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libavutil = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libpostproc = "GPLv2+"
LICENSE_libswresample = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_libswscale = "${@bb.utils.contains('PACKAGECONFIG', 'gpl', 'GPLv2+', 'LGPLv2.1+', d)}"
LICENSE_FLAGS = "commercial"

LIC_FILES_CHKSUM = "file://COPYING.GPLv2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
                    file://COPYING.GPLv3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LGPLv2.1;md5=bd7a443320af8c812e4c18d1b79df004 \
                    file://COPYING.LGPLv3;md5=e6a600fd5e1d9cbde2d983680233ad02"

SRC_URI = "https://www.ffmpeg.org/releases/${BP}.tar.xz \
           file://mips64_cpu_detection.patch \
		   file://wha-version.patch \
           file://fix-no-lame-hdr-delay.patch \
           file://fix-sbr-delay.patch \
	   file://id3-tags-in-adts.patch \
           "
SRC_URI[md5sum] = "cbf4ead227fcedddf54c86013705a988"
SRC_URI[sha256sum] = "2b92e9578ef8b3e49eeab229e69305f5f4cbc1fdaa22e927fc7fca18acccd740"

# Build fails when thumb is enabled: https://bugzilla.yoctoproject.org/show_bug.cgi?id=7717
ARM_INSTRUCTION_SET = "arm"

# Should be API compatible with libav (which was a fork of ffmpeg)
# libpostproc was previously packaged from a separate recipe
PROVIDES = "libav libpostproc"

DEPENDS = "alsa-lib zlib libogg yasm-native"

inherit autotools pkgconfig

PACKAGECONFIG ??= "avdevice avfilter avcodec avformat swresample swscale postproc \
                   bzlib gpl lzma theora x264 \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xv', '', d)}"

# libraries to build in addition to avutil
PACKAGECONFIG[avdevice] = "--enable-avdevice,--disable-avdevice"
PACKAGECONFIG[avfilter] = "--enable-avfilter,--disable-avfilter"
PACKAGECONFIG[avcodec] = "--enable-avcodec,--disable-avcodec"
PACKAGECONFIG[avformat] = "--enable-avformat,--disable-avformat"
PACKAGECONFIG[swresample] = "--enable-swresample,--disable-swresample"
PACKAGECONFIG[swscale] = "--enable-swscale,--disable-swscale"
PACKAGECONFIG[postproc] = "--enable-postproc,--disable-postproc"
PACKAGECONFIG[avresample] = "--enable-avresample,--disable-avresample"

# features to support
PACKAGECONFIG[bzlib] = "--enable-bzlib,--disable-bzlib,bzip2"
PACKAGECONFIG[gpl] = "--enable-gpl,--disable-gpl"
PACKAGECONFIG[gsm] = "--enable-libgsm,--disable-libgsm,libgsm"
PACKAGECONFIG[jack] = "--enable-indev=jack,--disable-indev=jack,jack"
PACKAGECONFIG[libvorbis] = "--enable-libvorbis,--disable-libvorbis,libvorbis"
PACKAGECONFIG[lzma] = "--enable-lzma,--disable-lzma,xz"
PACKAGECONFIG[mp3lame] = "--enable-libmp3lame,--disable-libmp3lame,lame"
PACKAGECONFIG[openssl] = "--enable-openssl,--disable-openssl,openssl"
PACKAGECONFIG[sdl2] = "--enable-sdl2,--disable-sdl2,virtual/libsdl2"
PACKAGECONFIG[speex] = "--enable-libspeex,--disable-libspeex,speex"
PACKAGECONFIG[theora] = "--enable-libtheora,--disable-libtheora,libtheora"
PACKAGECONFIG[vaapi] = "--enable-vaapi,--disable-vaapi,libva"
PACKAGECONFIG[vdpau] = "--enable-vdpau,--disable-vdpau,libvdpau"
PACKAGECONFIG[vpx] = "--enable-libvpx,--disable-libvpx,libvpx"
PACKAGECONFIG[x264] = "--enable-libx264,--disable-libx264,x264"
PACKAGECONFIG[xv] = "--enable-outdev=xv,--disable-outdev=xv,libxv"

# Check codecs that require --enable-nonfree
USE_NONFREE = "${@bb.utils.contains_any('PACKAGECONFIG', [ 'openssl' ], 'yes', '', d)}"

def cpu(d):
    for arg in (d.getVar('TUNE_CCARGS') or '').split():
        if arg.startswith('-mcpu='):
            return arg[6:]
    return 'generic'

EXTRA_OECONF = " \
 --disable-stripping \
        --disable-static \
        --enable-shared \
        --disable-programs \
        --disable-doc \
        --disable-avdevice \
        --disable-swscale \
        --disable-postproc \
        --disable-avfilter \
        --disable-pixelutils \
        --disable-everything \
\
    --enable-protocol=file \
    --enable-protocol=http \
    --enable-demuxer=mpegts \
    --enable-demuxer=mpegtsraw  \
    --enable-demuxer=mov  \
    --enable-demuxer=aac  \
    --enable-demuxer=mp3  \
    --enable-demuxer=ogg \
    --enable-parser=aac  \
    --enable-parser=aac_latm  \
    --enable-parser=mpegaudio  \
    --enable-parser=opus  \
    --enable-parser=vorbis \
    --enable-decoder=aac  \
    --enable-decoder=aac_at  \
    --enable-decoder=aac_fixed  \
    --enable-decoder=aac_latm  \
    --enable-decoder=mp3  \
    --enable-decoder=opus  \
    --enable-decoder=vorbis  \
    --enable-decoder=pcm_f16le  \
    --enable-decoder=pcm_f24le  \
    --enable-decoder=pcm_f32be  \
    --enable-decoder=pcm_f32le  \
    --enable-decoder=pcm_s16be  \
    --enable-decoder=pcm_s16le  \
    --enable-decoder=pcm_s24be  \
    --enable-decoder=pcm_s24le  \
    --enable-decoder=pcm_s32be  \
    --enable-decoder=pcm_s32le  \
    --enable-decoder=pcm_s8 \
\
    ${@bb.utils.contains('USE_NONFREE', 'yes', '--enable-nonfree', '', d)} \
    \
    --cross-prefix=${TARGET_PREFIX} \
    \
    --ld="${CCLD}" \
    --cc="${CC}" \
    --cxx="${CXX}" \
    --arch=${TARGET_ARCH} \
    --target-os="linux" \
    --enable-cross-compile \
    --extra-cflags="${TARGET_CFLAGS} ${HOST_CC_ARCH}${TOOLCHAIN_OPTIONS}" \
    --extra-ldflags="${TARGET_LDFLAGS}" \
    --sysroot="${STAGING_DIR_TARGET}" \
    --enable-hardcoded-tables \
    ${EXTRA_FFCONF} \
    --libdir=${libdir} \
    --shlibdir=${libdir} \
    --datadir=${datadir}/ffmpeg \
"

EXTRA_OECONF_append_linux-gnux32 = " --disable-asm"

do_configure() {
    ${S}/configure ${EXTRA_OECONF}
}

PACKAGES =+ "libavcodec \
             libavdevice \
             libavfilter \
             libavformat \
             libavresample \
             libavutil \
             libpostproc \
             libswresample \
             libswscale"

FILES_libavcodec = "${libdir}/libavcodec${SOLIBS}"
FILES_libavdevice = "${libdir}/libavdevice${SOLIBS}"
FILES_libavfilter = "${libdir}/libavfilter${SOLIBS}"
FILES_libavformat = "${libdir}/libavformat${SOLIBS}"
FILES_libavresample = "${libdir}/libavresample${SOLIBS}"
FILES_libavutil = "${libdir}/libavutil${SOLIBS}"
FILES_libpostproc = "${libdir}/libpostproc${SOLIBS}"
FILES_libswresample = "${libdir}/libswresample${SOLIBS}"
FILES_libswscale = "${libdir}/libswscale${SOLIBS}"

# ffmpeg disables PIC on some platforms (e.g. x86-32)
INSANE_SKIP_${MLPREFIX}libavcodec = "textrel"
INSANE_SKIP_${MLPREFIX}libavdevice = "textrel"
INSANE_SKIP_${MLPREFIX}libavfilter = "textrel"
INSANE_SKIP_${MLPREFIX}libavformat = "textrel"
INSANE_SKIP_${MLPREFIX}libavutil = "textrel"
INSANE_SKIP_${MLPREFIX}libavresample = "textrel"
INSANE_SKIP_${MLPREFIX}libswscale = "textrel"
INSANE_SKIP_${MLPREFIX}libswresample = "textrel"
INSANE_SKIP_${MLPREFIX}libpostproc = "textrel"
