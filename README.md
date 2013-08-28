DOOGLE
======

D gui toolkit library focussed on opengl usage.

Capabilities
------------

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
