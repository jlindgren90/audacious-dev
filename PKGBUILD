pkgname=audacious-dev
pkgver=0.1
pkgrel=1
arch=('x86_64')
url="https://audacious-media-player.org/"
license=('BSD' 'GPL')
conflicts=('audacious' 'audacious-plugins')
depends=('glib2' 'gtk2' 'qt5-base' 'qt5-svg' 'adplug' 'alsa-lib' 'curl' 'faad2'
         'ffmpeg' 'flac' 'fluidsynth' 'jack' 'lame' 'libbs2b' 'libcddb'
         'libcdio-paranoia' 'libcue' 'libmms' 'libmodplug' 'libmtp' 'libnotify'
         'libopenmpt' 'libpulse' 'libsamplerate' 'libsidplayfp' 'libvorbis'
         'lirc' 'mpg123' 'neon' 'wavpack')

makedepends=('python') # for gdbus-codegen
optdepends=('unzip: zipped skins support')

package() {
  rmdir "$pkgdir"
  rm -f "../dst/.BUILDINFO"
  rm -f "../dst/.MTREE"
  rm -f "../dst/.PKGINFO"
  ln -s "../dst" "$pkgdir"
}
