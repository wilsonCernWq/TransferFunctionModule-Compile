## ======================================================================== ##
if (NOT TARGET OpenGL)
  find_package(OpenGL REQUIRED)
  add_library(OpenGL INTERFACE IMPORTED)
  set_target_properties(OpenGL PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${OPENGL_INCLUDE_DIR}"
    INTERFACE_LINK_LIBRARIES "${OPENGL_LIBRARIES}")
endif ()
## ======================================================================== ##
if (NOT TARGET glfw)
  if (EXISTS ${PROJECT_SOURCE_DIR}/external/glfw/upstream/CMakeLists.txt)
    # glfw
    set(GLFW_BUILD_DOCS     OFF)
    set(GLFW_BUILD_EXAMPLES OFF)
    set(GLFW_BUILD_TESTS    OFF)
    set(GLFW_INSTALL        OFF)
    add_subdirectory(${PROJECT_SOURCE_DIR}/external/glfw/upstream)
    set_target_properties(glfw PROPERTIES
      INTERFACE_COMPILE_DEFINITIONS USE_GLFW=1)
    target_include_directories(glfw INTERFACE
      "$<BUILD_INTERFACE:"
      "${PROJECT_SOURCE_DIR}/external/glfw/deps;"
      "${PROJECT_SOURCE_DIR}/external/glfw/upstream;"
      "${PROJECT_SOURCE_DIR}/external/glfw/upstream/include;"
      ">")
    # glad
    if (NOT TARGET glad)
      add_library(glad
        ${PROJECT_SOURCE_DIR}/external/glfw/deps/glad.c)
      target_include_directories(glad PUBLIC
        "$<BUILD_INTERFACE:"
        "${PROJECT_SOURCE_DIR}/external/glfw/deps;"
        "${PROJECT_SOURCE_DIR}/external/glfw/upstream;"
        "${PROJECT_SOURCE_DIR}/external/glfw/upstream/include;"
        ">")
    endif ()
  else ()
    message(FATAL_ERROR "cannot find glfw")
  endif ()
endif ()
## ======================================================================== ##
if (NOT TARGET imgui)
  if (EXISTS ${PROJECT_SOURCE_DIR}/external/imgui/upstream/imgui.h)
    add_subdirectory(${PROJECT_SOURCE_DIR}/external/imgui)
  else ()
    messate(FATAL_ERROR "cannot find imgui")
  endif ()
endif ()
## ======================================================================== ##