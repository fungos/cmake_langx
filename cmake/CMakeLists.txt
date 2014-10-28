#
# Start here:
# http://www.cmake.org/gitweb?p=cmake.git;a=blob;f=Modules/CMakeAddNewLanguage.txt;hb=v3.0.2
#

cmake_minimum_required(VERSION 2.8)
project(cmakex NONE)

set(LANG_SRCS
	CMakeXCompiler.cmake.in        
	CMakeXInformation.cmake        
	CMakeDetermineXCompiler.cmake 
	CMakeTestXCompiler.cmake
)

set(COMPILER_SRCS
	Compiler/Windows-XC-X.cmake
	Compiler/XC.cmake 
)

install(FILES ${LANG_SRCS} DESTINATION ${CMAKE_ROOT}/Modules)
install(FILES ${COMPILER_SRCS} DESTINATION ${CMAKE_ROOT}/Modules/Compiler)
