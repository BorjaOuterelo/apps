include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)

set(CMAKE_SYSROOT /root/nuttx)
set(CMAKE_CXX_FLAGS "-isystem /root/nuttx/include")
set(CMAKE_C_FLAGS "-isystem /root/nuttx/include")

# compiler tools
foreach(tool objcopy nm ld)
	string(TOUPPER ${tool} TOOL)
	find_program(${TOOL} arm-none-eabi-${tool})
	if(NOT ${TOOL})
		message(FATAL_ERROR "could not find ${tool}")
	endif()
endforeach()

# specify the cross compiler
find_program(C_COMPILER arm-none-eabi-gcc)
if(NOT C_COMPILER)
	message(FATAL_ERROR "could not find arm-none-eabi-gcc compiler")
endif()
cmake_force_c_compiler(${C_COMPILER} GNU)

find_program(CXX_COMPILER arm-none-eabi-g++)
if(NOT CXX_COMPILER)
	message(FATAL_ERROR "could not find arm-none-eabi-g++ compiler")
endif()
cmake_force_cxx_compiler(${CXX_COMPILER} GNU)

# optional compiler tools
foreach(tool gdb gdbtui)
	string(TOUPPER ${tool} TOOL)
	find_program(${TOOL} arm-none-eabi-${tool})
	if(NOT ${TOOL})
		message(STATUS "could not find ${tool}")
	endif()
endforeach()

set(CMAKE_FIND_ROOT_PATH root/nuttx)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_SYSROOT /root/nuttx)

set(__BIG_ENDIAN__ 0)
