DOOGLE
======

D gui toolkit library focussed on opengl usage.

Capabilities
------------

General:
* Storage manager
* Texture binding

Building:
* Built using dub.

Windows:
* Window creation
* OpenGL context creation
* Windows API bindings generated using Mingw x64 and cygwin.

Posix:
** Not implemented yet **

Requires:
* On Posix requires libX11 bindings (submodule). Built as part of lib. Need to move this into a dub module.

Planned:
* Full support for Windows, Mac OSX and Linux under x86 32 and 64 bit.
* Opengl OOP wrapper.
* Wrapping of Opengl with e.g. D arrays and enums to make it more intuitive.
* Full Opengl 4.2+ wrappers.
* Currently most of 2.0 has been made at the lowest level. With enums and D arrays.
* Supporting controls to be made an expanded upon the window creation and eventing system.
* Full manipulation of a GUI using a socket connection (optional).
* Font rasterizer wrapper.
* Storage manager including packaging support.

Aims:
* Be able to make majority of applications with it.
* Produce an IDE using the standard controls.
* Completely written in D. Only bindings are acceptable to system libraries (no ones not installed by default).
* Will not add any more dependencies e.g. a font rasterizer.
  This is meant to be a minimal lib without the controls.

Note:
Posix hasn't been added yet but should be both 32 and 64bit.
There is three configurations main(builds as a library), libtest(builds as an executable with -main) and test(executable with test script added).

Does not include a math library. gl3n is a dependency which does provide this however. Switched over because previous was not complete enough.

Working with files
-------------------
This is less about how to work with files in general however there is a few things needed to be known.

First off compiling in **will** be supported. To compile in generate a source file by [Bin2D](https://github.com/rikkimax/Bin2D).

Second there is a storage manager. This manager will support the above method.

Using it you can load up from predetermined locations (hard coded). However you can recall with more.
This provides high overidability for moding.
In future packaging *should* be possible.

Package dependencies
------------------------
Okay I need to say this now.
This is becoming very important for future usage and reference.

Doogle:
* Window management
* Standard platform window
* Standard controls
* Util
* 
Note Doogle is the root package.

Window management:
* Util

OpenGL:
* Derelict-GL3
* Gl3n
* Util

Standard platform window:
* window management

Standard controls:
* Window management
* OpenGL
* Derelict-FT
* Util

Util:

*None*

In theory what this means is you are able to use doogle:opengl and doogle:util independently of the entire library.
If you wish you can implement your own context's and controls. The standard control sub package is not required if your only wanting the OpenGL context.
