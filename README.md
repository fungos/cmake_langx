= cmake_langx =

This is a sample, almost complete, of a language definition for CMake.

Here I defined a language "X" capable to interoperate with C/C++ via libraries as an example on how to achieve specific functionalities and testing CMake limitations.

This project is composed of 5 sub projects:

- cmake: contains all files for language X definition, you can generate a project and do an install for these files to add them to your cmake instalation.
- xtoolset: an set of bash scripts to emulate a language toolset for language X (most echoes but with a ranlib that build a c library to be able to test the development flow).
- libc: just generate a c library.
- libx: an example using the language X to generate a X library.
- app: to build an executable that uses both libs.

TODO:

- Correctly implement compiler identification and test

