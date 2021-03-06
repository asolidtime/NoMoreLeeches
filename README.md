# NoMoreLeeches
TLDR: it's [LeechBlock NG](https://addons.mozilla.org/en-US/firefox/addon/leechblock-ng/), but for desktop apps. Check out the tutorial [here.](https://github.com/asolidtime/NoMoreLeeches/blob/main/TUTORIAL.md)  

Long explanation:  
NoMoreLeeches is a relatively simple tool to help improve your productivity by blocking apps and webpages you probably don't want to be using anyway. I originally made it as a tool to help with my own executive dysfunction, taking the 'make the user wait' idea from [this XKCD comic's alt-text](https://m.xkcd.com/862/).  
I'm open-sourcing and maintaining it under the GPLv3 in the hopes that others will find it useful too. NML is built with C++ and FLTK and works on Windows and Linux. (on Linux, Wayland has a few problems. See [Wayland notes](#notes-on-wayland-support) for more details)  

## Screenshots
![Screenshot_20220314_222020](https://user-images.githubusercontent.com/75963592/158299544-4fa8f560-8aee-4856-b6d2-b9b8b236ea99.png)
![Screenshot_20220314_222258](https://user-images.githubusercontent.com/75963592/158299833-b5c0372b-bddd-459c-9fb6-73ef56423eb8.png)
![Screenshot_20220314_222600](https://user-images.githubusercontent.com/75963592/158300219-38aedf73-cbd3-4d23-9ffa-207f7b08fb6b.png)

## Features
- 'Lockdown mode' that prevents the user from changing block settings and ignores window close events
- Color themes!
- Delay blocking (keep this window focused for XX seconds to see this window)
- Regular blocking (keep this window focused if you like staring at the 'Application Blocked' window)
- Very small footprint (uses under 4MB of memory and under 2MB of disk space)

## Building
On Linux, you'll need xlib/libx11, fltk, libxmu, and their respective development libraries installed. (todo: list packages on debian, arch, and mingw)  
On Windows, you'll need the MSYS2 MINGW64 shell. Install `mingw-w64-fltk` and GCC.  
```
git clone https://github.com/asolidtime/nomoreleeches.git
cd nomoreleeches
make
```
The resulting binary, `NoMoreLeeches` or `NoMoreLeeches.exe`, will be in the current directory.

## Tutorial
See [TUTORIAL.md](https://github.com/asolidtime/NoMoreLeeches/blob/main/TUTORIAL.md)

## TODOs
- multiple block lists
- ~~explicitly steal~~ port widget theming/scheming code from [fltk-theme](https://github.com/fltk-rs/fltk-theme)
- MacOS support
- consistently use a casing scheme (probably stick with camelCase)
- accessibility support
- clean up makefile, use makedepends or GCC for autodetecting dependencies rather than doing it manually, add `install` command for easier packaging

## Notes on Wayland support
Wayland doesn't support normal desktop apps getting info on other active apps for security reasons, and I doubt that'll change any time soon, so apps running natively on Wayland won't be detected. You'll have to force said apps to run on XWayland for them to be detected by NML. This can be done through environment variables for most toolkits (`GDK_BACKEND=x11` on GTK, `QT_QPA_PLATFORM=xcb` on Qt).
