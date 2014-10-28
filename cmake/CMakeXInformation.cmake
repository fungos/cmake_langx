# This file sets the basic flags for the X Compiler.
# It also loads the available platform file for the 
# system-compiler if it exists.
#
# This should be included before the _INIT variables are
# used to initialize the cache.  Since the rule variables
# have if blocks on them, users can still define them here.
# But, it should still be after the platform file so changes
# can be made to those values.
include(Platform/${CMAKE_SYSTEM_NAME}-${CMAKE_BASE_NAME} OPTIONAL)

# Load compiler-specific information.
if(CMAKE_X_COMPILER_ID)
	include(Compiler/${CMAKE_SYSTEM_NAME}-${CMAKE_X_COMPILER_ID}-${CMAKE_X_VARIANT_TYPE} OPTIONAL)
endif()

if(CMAKE_USER_MAKE_RULES_OVERRIDE)
	include(${CMAKE_USER_MAKE_RULES_OVERRIDE})
endif()
	
if(CMAKE_USER_MAKE_RULES_OVERRIDE_X)
	include(${CMAKE_USER_MAKE_RULES_OVERRIDE_X})
endif()

# for most systems a module is the same as a shared library
# so unless the variable CMAKE_MODULE_EXISTS is set just
# copy the values from the LIBRARY variables
if(NOT CMAKE_MODULE_EXISTS)
	set(CMAKE_SHARED_MODULE_X_FLAGS 			${CMAKE_SHARED_LIBRARY_X_FLAGS})
	set(CMAKE_SHARED_MODULE_CREATE_X_FLAGS 	${CMAKE_SHARED_LIBRARY_CREATE_X_FLAGS})
endif()

set(CMAKE_X_FLAGS_INIT "$ENV{XFLAGS} ${CMAKE_X_FLAGS_INIT}")

# avoid just having a space as the initial value for the cache
if(CMAKE_X_FLAGS_INIT STREQUAL " ")
	set(CMAKE_X_FLAGS_INIT)
endif()
set(CMAKE_X_FLAGS "${CMAKE_X_FLAGS_INIT}" CACHE STRING "Flags used by the compiler during all build types.")
mark_as_advanced(CMAKE_X_FLAGS)

# now define the following rule variables

# CMAKE_X_CREATE_SHARED_LIBRARY
# CMAKE_X_CREATE_SHARED_MODULE
# CMAKE_X_COMPILE_OBJECT
# CMAKE_X_LINK_EXECUTABLE

# variables supplied by the generator at use time
# <TARGET>
# <TARGET_BASE> the target without the suffix
# <OBJECTS>
# <OBJECT>
# <LINK_LIBRARIES>
# <FLAGS>
# <LINK_FLAGS>

# X compiler information
# <CMAKE_X_COMPILER>
# <CMAKE_SHARED_LIBRARY_CREATE_X_FLAGS>
# <CMAKE_SHARED_MODULE_CREATE_X_FLAGS>
# <CMAKE_X_LINK_FLAGS>

# Static library tools
# <CMAKE_AR>
# <CMAKE_RANLIB>

# create a shared library
if(NOT CMAKE_X_CREATE_SHARED_LIBRARY)
	set(CMAKE_X_CREATE_SHARED_LIBRARY "<CMAKE_X_COMPILER> <CMAKE_SHARED_LIBRARY_X_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_X_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
endif()

# create a shared module just copy the shared library rule
if(NOT CMAKE_X_CREATE_SHARED_MODULE)
	set(CMAKE_X_CREATE_SHARED_MODULE ${CMAKE_X_CREATE_SHARED_LIBRARY})
endif()

# Create a static archive incrementally for large object file counts.
# If CMAKE_X_CREATE_STATIC_LIBRARY is set it will override these.
if(NOT DEFINED CMAKE_X_ARCHIVE_CREATE)
	set(CMAKE_X_ARCHIVE_CREATE "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS>")
endif()

if(NOT DEFINED CMAKE_X_ARCHIVE_APPEND)
	set(CMAKE_X_ARCHIVE_APPEND "<CMAKE_AR> r <TARGET> <LINK_FLAGS> <OBJECTS>")
endif()

if(NOT DEFINED CMAKE_X_ARCHIVE_FINISH)
	set(CMAKE_X_ARCHIVE_FINISH "<CMAKE_RANLIB> <TARGET>")
endif()

# compile a file into an object file
if(NOT CMAKE_X_COMPILE_OBJECT)
	set(CMAKE_X_COMPILE_OBJECT "<CMAKE_X_COMPILER> <DEFINES> <FLAGS> -o <OBJECT> -c <SOURCE>")
endif()

if(NOT CMAKE_X_LINK_EXECUTABLE)
	set(CMAKE_X_LINK_EXECUTABLE "<CMAKE_X_COMPILER> <FLAGS> <CMAKE_X_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
endif()


# set this variable so we can avoid loading this more than once.
set(CMAKE_X_INFORMATION_LOADED 1)