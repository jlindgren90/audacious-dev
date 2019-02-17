pkgname=audacious
pkgver=dev
pkgrel=1
arch=('x86_64')
url="https://audacious-media-player.org/"
license=('BSD' 'GPL')
depends=('gtk2' 'glib2' 'gnome-icon-theme' 'hicolor-icon-theme' 'desktop-file-utils'
         'alsa-lib' 'pulseaudio' 'jack' 'lame' 'libvorbis' 'flac'
         'mpg123' 'faad2' 'ffmpeg' 'libmodplug' 'fluidsynth' 'libcdio-paranoia' 'libsidplayfp' 'wavpack'
         'dbus-glib' 'libsamplerate' 'libnotify' 'lirc' 'curl' 'libmtp'
         'neon' 'libmms' 'libcue')

makedepends=('python') # for gdbus-codegen
optdepends=('unzip: zipped skins support')

package() {
  rmdir "$pkgdir"
  rm -f "../dst/.BUILDINFO"
  rm -f "../dst/.MTREE"
  rm -f "../dst/.PKGINFO"
  ln -s "../dst" "$pkgdir"
}
