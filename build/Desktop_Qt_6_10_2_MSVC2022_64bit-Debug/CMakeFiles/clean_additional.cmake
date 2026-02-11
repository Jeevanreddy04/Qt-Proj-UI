# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appMartinGCS_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appMartinGCS_autogen.dir\\ParseCache.txt"
  "appMartinGCS_autogen"
  )
endif()
