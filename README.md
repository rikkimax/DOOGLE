DOOGLE
======

D gui toolkit library focussed on opengl usage.

Capabilities
------------

Building:
* Can be built with DUB (not in repo yet).

Windows:
* Window creation
* OpenGL context creation

Posix:
** Not implemented yet **

Requires:
* On Windows requires WindowsAPI bindings (submodule). Builds as a seperate lib. Then linked in.
* On Posix requires libX11 bindings (submodule). Built as part of lib.

Planned:
* Full support for Windows, Mac OSX and Linux under x86 32 and 64 bit.
* Opengl OOP wrapper.
* Wrapping of Opengl with e.g. D arrays and enums to make it more intuitive.
* Full Opengl 4.2+ wrappers.
* Currently most of 2.0 has been made at the lowest level. With enums and D arrays.
* Supporting controls to be made an expanded upon the window creation and eventing system.
* Full manipulation of a GUI using a socket connection (optional).

Aims:
* Be able to make majority of applications with it.
* Produce an IDE using the standard controls.
* Completely written in D. Only bindings are acceptable to system libraries (no ones not installed by default).
* Will not add any more dependencies e.g. a font rasterizer.
  This is meant to be a minimal lib without the controls.

Note:
On Windows you can only build using 64bit. This is an issue and related to import libraries for WindowsAPI.
Posix hasn't been added yet but should be both 32 and 64bit.
There is three configurations main(builds as a library), libtest(builds as an executable with -main) and test(executable with test script added).

Requires git to be on PATH before execution. This is because of hack to grab WindowAPI and libX11 as git submodules.

Does not include a math library. gl3n is a dependency which does provide this however. Switched over because previous was not complete enough.