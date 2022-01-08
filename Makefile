DST = $(CURDIR)/dst

export AUDACIOUS_CFLAGS = -I$(DST)/usr/include
export AUDACIOUS_LIBS = -L$(DST)/usr/lib -laudcore
export PKG_CONFIG_PATH = $(DST)/usr/lib/pkgconfig

qt6: export QTCORE_CFLAGS = -DQT_CORE_LIB -I/usr/include/qt6/QtCore -I/usr/include/qt6 -fPIC
qt6: export QTCORE_LIBS = -lQt6Core
qt6: export QT_CFLAGS = -I/usr/include/qt6/QtCore -I/usr/include/qt6 -I/usr/include/qt6/QtGui -DQT_WIDGETS_LIB -I/usr/include/qt6/QtWidgets -DQT_GUI_LIB -DQT_CORE_LIB -fPIC
qt6: export QT_LIBS = -lQt6Widgets -lQt6Gui -lQt6Core
qt6: export QT_BINPATH = /usr/lib/qt6/bin

meson: export C_INCLUDE_PATH = $(DST)/usr/include
meson: export CPLUS_INCLUDE_PATH = $(DST)/usr/include
meson: export LIBRARY_PATH = $(DST)/usr/lib

meson-qt6: export C_INCLUDE_PATH = $(DST)/usr/include
meson-qt6: export CPLUS_INCLUDE_PATH = $(DST)/usr/include
meson-qt6: export LIBRARY_PATH = $(DST)/usr/lib
meson-qt6: export QMAKE = qmake6

all:
	mkdir -p dst
	cd audacious && test -f configure || ./autogen.sh
	cd audacious && test -f config.h || ./configure --prefix=/usr
	cd audacious && $(MAKE) -s
	cd audacious && $(MAKE) -s DESTDIR=$(DST) install
	cd audacious-plugins && test -f configure || ./autogen.sh
	cd audacious-plugins && test -f config.h || ./configure --prefix=/usr
	cd audacious-plugins && $(MAKE) -s
	cd audacious-plugins && $(MAKE) -s DESTDIR=$(DST) install

qt6: all

meson:
	meson setup --prefix=/usr audacious-build audacious
	cd audacious-build && meson compile
	cd audacious-build && DESTDIR=$(DST) meson install
	meson setup --prefix=/usr audacious-plugins-build audacious-plugins
	cd audacious-plugins-build && meson compile
	cd audacious-plugins-build && DESTDIR=$(DST) meson install

meson-qt6:
	meson setup --prefix=/usr -Dqt6=true audacious-build audacious
	cd audacious-build && meson compile
	cd audacious-build && DESTDIR=$(DST) meson install
	meson setup --prefix=/usr -Dqt6=true audacious-plugins-build audacious-plugins
	cd audacious-plugins-build && meson compile
	cd audacious-plugins-build && DESTDIR=$(DST) meson install

install:
	makepkg -f
	sudo pacman --noconfirm -U audacious-dev-0.1-1-x86_64.pkg.tar.*

clean:
	cd audacious && git clean -fdX
	cd audacious-plugins && git clean -fdX
	rm -rf audacious-build audacious-plugins-build
	rm -rf dst pkg src
