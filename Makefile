# We don't know what compiler to use to build fltk on this machine - but fltk-config does...
CC  = $(shell fltk-config --cc)
CXX = $(shell fltk-config --cxx)

# Set the flags for compiler: fltk-config knows the basic settings, then we can add our own...
CFLAGS   = -g $(shell fltk-config --cflags) $(shell pkg-config --libs x11 xmu) -Wall #-I/other/include/paths...
CXXFLAGS = -g $(shell fltk-config --cxxflags) $(shell pkg-config --libs x11 xmu) -Wall -lstdc++fs #-I/other/include/paths...

# We don't know what libraries to link with: fltk-config does...
LINKFLTK = $(shell fltk-config --ldstaticflags) $(shell pkg-config --libs x11 xmu) -lstdc++fs
LINKFLTK_GL = $(shell fltk-config --use-gl --ldstaticflags)
LINKFLTK_IMG = $(shell fltk-config --use-images --ldstaticflags)

# Possible steps to run after linking...
STRIP      = strip
POSTBUILD  = fltk-config --post # Required on OSX, does nothing on other platforms, so safe to call
ifeq ($(OS),Windows_NT)
MAIN_DEPS = main.cxx main_window.h dummy_window_manager.h blocked_window.h theme_manager.h
EXE_OBJ_DEPS = main.o main_window.o dummy_window_manager.o blocked_window.o theme_manager.o
else
MAIN_DEPS = main.cxx main_window.h x11_window_manager.h blocked_window.h theme_manager.h
EXE_OBJ_DEPS = main.o xlib_window_grab.o main_window.o x11_window_manager.o blocked_window.o theme_manager.o
endif

# Define what your target application is called
all: NoMoreLeeches

# Define how to build the various object files...
theme_manager.o: theme_manager.cxx theme_manager.h
		$(CXX) -c $< $(CXXFLAGS)
xlib_window_grab.o: xlib_window_grab.c xlib_window_grab.h  # a "plain" C file
		$(CC) -c $< $(CCFLAGS)
x11_window_manager.o: x11_window_manager.cxx x11_window_manager.h xlib_window_grab.h
		$(CXX) -c $< $(CXXFLAGS)

dummy_window_manager.o: dummy_window_manager.cxx dummy_window_manager.h
		$(CXX) -c $< $(CXXFLAGS)

main_window.o: main_window.cxx main_window.h  # a C++ file
		$(CXX) -c $< $(CXXFLAGS)

blocked_window.o: blocked_window.cxx blocked_window.h
		$(CXX) -c $< $(CXXFLAGS)

main.o: $(MAIN_DEPS)
		$(CXX) -c $< $(CXXFLAGS)


NoMoreLeeches:  $(EXE_OBJ_DEPS)
		$(CXX) -o $@ $(EXE_OBJ_DEPS) $(LINKFLTK)

clean: 
	rm *.o NoMoreLeeches

run: NoMoreLeeches
	./NoMoreLeeches
