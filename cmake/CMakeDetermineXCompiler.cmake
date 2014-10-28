# determine the compiler to use for X programs
# NOTE, a generator may set CMAKE_X_COMPILER before
# loading this file to force a compiler.
# use environment variable X first if defined by user, next use
# the cmake variable CMAKE_GENERATOR_X which can be defined by a
# generator as a default compiler

if(NOT CMAKE_X_COMPILER)
	# prefer the environment variable X
	if($ENV{XC} MATCHES ".+")
		get_filename_component(CMAKE_X_COMPILER_INIT $ENV{XC} PROGRAM PROGRAM_ARGS CMAKE_X_FLAGS_ENV_INIT)
		if(CMAKE_X_FLAGS_ENV_INIT)
			set(CMAKE_X_COMPILER_ARG1 "${CMAKE_X_FLAGS_ENV_INIT}" CACHE STRING "First argument to X compiler")
		endif()
		if(EXISTS ${CMAKE_X_COMPILER_INIT})
		else()
			message(FATAL_ERROR "Could not find compiler set in environment variable XC:\n$ENV{XC}.")
		endif()
	endif()

	# next try prefer the compiler specified by the generator
	if(CMAKE_GENERATOR_X)
		if(NOT CMAKE_X_COMPILER_INIT)
		  set(CMAKE_X_COMPILER_INIT ${CMAKE_GENERATOR_X})
		endif()
	endif()

	# finally list compilers executable names to try
	if(CMAKE_X_COMPILER_INIT)
		set(CMAKE_X_COMPILER_LIST ${CMAKE_X_COMPILER_INIT})
	else()
		set(CMAKE_X_COMPILER_LIST xc xcp) # a list with all possible compiler versions
	endif()

	# Set the compiler search paths
	set(X_BIN_PATH
		"[HKEY_LOCAL_MACHINE\\SOFTWARE\\X Publisher\\X Compiler\\1.0;XCompilerPath]/bin"
		c:/path/to/your/xtoolset
		/path/to/your/xtoolset
		$ENV{X_HOME}/bin
		$ENV{X_HOME}
		/usr/bin
	)

	# Find the compiler executable
	find_program(CMAKE_X_COMPILER 
		NAMES	${CMAKE_X_COMPILER_LIST}
		PATHS 	${X_BIN_PATH}
		DOC 	"X compiler" 
	)

	if(CMAKE_X_COMPILER_INIT AND NOT CMAKE_X_COMPILER)
		set(CMAKE_X_COMPILER "${CMAKE_X_COMPILER_INIT}" CACHE FILEPATH "X compiler" FORCE)
	endif()
endif()
mark_as_advanced(CMAKE_X_COMPILER)

set(CMAKE_X_COMPILER_ENV_VAR "XC")
get_filename_component(COMPILER_LOCATION "${CMAKE_X_COMPILER}" PATH)
list(APPEND X_BIN_PATH ${COMPILER_LOCATION})

# Find archiver
#set(CMAKE_AR ${COMPILER_LOCATION}/xar)
if(CMAKE_AR_INIT)
	set(CMAKE_AR_LIST ${CMAKE_AR_INIT})
else()
	set(CMAKE_AR_LIST xar) # a list with all possible compiler versions
endif()
find_program(CMAKE_AR 
	NAMES 	${CMAKE_AR_LIST}
	HINTS 	${COMPILER_LOCATION}
	PATHS   ${X_BIN_PATH}
	DOC		"X archiver"
)
mark_as_advanced(CMAKE_AR)
message(${CMAKE_AR})

# Find ranlib
#set(CMAKE_RANLIB ${COMPILER_LOCATION}/xranlib)
if(CMAKE_RANLIB_INIT)
	set(CMAKE_RANLIB_LIST ${CMAKE_RANLIB_INIT})
else()
	set(CMAKE_RANLIB_LIST xranlib) # a list with all possible compiler versions
endif()
find_program(CMAKE_RANLIB 
	NAMES 	${CMAKE_RANLIB_LIST}
	HINTS 	${COMPILER_LOCATION}
	PATHS   ${X_BIN_PATH}
	DOC		"X ranlib"
)
mark_as_advanced(CMAKE_RANLIB)

# Find linker
#set(CMAKE_LINKER ${COMPILER_LOCATION}/xld)
if(CMAKE_LINKER_INIT)
	set(CMAKE_LINKER_LIST ${CMAKE_LINKER_INIT})
else()
	set(CMAKE_LINKER_LIST xld) # a list with all possible linker versions
endif()
find_program(CMAKE_LINKER 
	NAMES	${CMAKE_LINKER_LIST} 
	HINTS	${COMPILER_LOCATION}
	PATHS	${X_BIN_PATH}
	DOC		"X linker"
)
mark_as_advanced(CMAKE_LINKER)

# TODO: Build a X sample program to identify the compiler
set(CMAKE_X_COMPILER_ID "xid")

# TODO: Detect the compiler variant type if there is one
set(CMAKE_X_VARIANT_TYPE "X")

# configure variables set in this file for fast reload later on
configure_file(
	${CMAKE_ROOT}/Modules/CMakeXCompiler.cmake.in 
	${CMAKE_PLATFORM_INFO_DIR}/CMakeXCompiler.cmake
	@ONLY
)
