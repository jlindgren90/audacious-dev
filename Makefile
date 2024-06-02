DST = $(CURDIR)/dst

export AUDACIOUS_CFLAGS = -I$(DST)/usr/include
export AUDACIOUS_LIBS = -L$(DST)/usr/lib -laudcore
export PKG_CONFIG_PATH = $(DST)/usr/lib/pkgconfig

meson: export C_INCLUDE_PATH = $(DST)/usr/include
meson: export CPLUS_INCLUDE_PATH = $(DST)/usr/include
meson: export LIBRARY_PATH = $(DST)/usr/lib

meson-qt5-gtk2: export C_INCLUDE_PATH = $(DST)/usr/include
meson-qt5-gtk2: export CPLUS_INCLUDE_PATH = $(DST)/usr/include
meson-qt5-gtk2: export LIBRARY_PATH = $(DST)/usr/lib

meson-gtk3: export C_INCLUDE_PATH = $(DST)/usr/include
meson-gtk3: export CPLUS_INCLUDE_PATH = $(DST)/usr/include
meson-gtk3: export LIBRARY_PATH = $(DST)/usr/lib

meson:
	meson setup --prefix=/usr -Dgtk=false build/audacious audacious
	cd build/audacious && meson compile && DESTDIR=$(DST) meson install
	meson setup --prefix=/usr -Dgtk=false build/audacious-plugins audacious-plugins
	cd build/audacious-plugins && meson compile && DESTDIR=$(DST) meson install
	jq -s add build/audacious/compile_commands.json \
	 build/audacious-plugins/compile_commands.json \
	 > build/compile_commands.json # for clangd

meson-qt5-gtk2:
	meson setup --prefix=/usr -Dqt5=true -Dgtk2=true build/audacious audacious
	cd build/audacious && meson compile && DESTDIR=$(DST) meson install
	meson setup --prefix=/usr -Dqt5=true -Dgtk2=true build/audacious-plugins audacious-plugins
	cd build/audacious-plugins && meson compile && DESTDIR=$(DST) meson install
	jq -s add build/audacious/compile_commands.json \
	 build/audacious-plugins/compile_commands.json \
	 > build/compile_commands.json # for clangd

meson-gtk3:
	meson setup --prefix=/usr build/audacious audacious
	cd build/audacious && meson compile && DESTDIR=$(DST) meson install
	meson setup --prefix=/usr build/audacious-plugins audacious-plugins
	cd build/audacious-plugins && meson compile && DESTDIR=$(DST) meson install
	jq -s add build/audacious/compile_commands.json \
	 build/audacious-plugins/compile_commands.json \
	 > build/compile_commands.json # for clangd

old:
	mkdir -p $(DST)
	cd audacious && test -f configure || ./autogen.sh
	cd audacious && test -f config.h || ./configure --prefix=/usr
	cd audacious && $(MAKE) -s && $(MAKE) -s DESTDIR=$(DST) install
	cd audacious-plugins && test -f configure || ./autogen.sh
	cd audacious-plugins && test -f config.h || ./configure --prefix=/usr
	cd audacious-plugins && $(MAKE) -s && $(MAKE) -s DESTDIR=$(DST) install

install:
	makepkg -f
	sudo pacman --noconfirm -U audacious-dev-0.1-1-x86_64.pkg.tar.*

clean:
	cd audacious && git clean -fdX
	cd audacious-plugins && git clean -fdX
	rm -rf build dst pkg src
