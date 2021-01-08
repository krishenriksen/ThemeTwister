# ThemeTwister
ThemeTwister GUI for TwisterOS.

## Building, Testing, and Installation

```
$ sudo apt install meson ninja-build libgee-0.8-dev libgnome-menu-3-dev cdbs valac libvala-*-dev libglib2.0-dev libwnck-3-dev libgtk-3-dev python3 python3-wheel python3-setuptools
```

Run `meson build` to configure the build environment:

    meson --prefix=/usr/local -Dbuildtype=release build
    
This command creates a `build` directory. For all following commands, change to
the build directory before running them.

To build themetwister, use `ninja`:

    ninja

To install, use `ninja install`

    ninja install

## Support the project

<a href="https://www.paypal.me/krishenriksendk" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
