if(__COMPILER_XC)
  return()
endif()
set(__COMPILER_XC 1)

macro(__compiler_xc lang)
	set(CMAKE_${lang}_COMPILE_OPTIONS 		"")
	set(CMAKE_INCLUDE_SYSTEM_FLAG_${lang} 	"")
endmacro()
