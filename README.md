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
* Supporting controls to be made an expanded upon the window creation and enventing system.
* Full manipulation of a GUI using a socket connection (optional).
