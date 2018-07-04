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
  if (EXISTS ${PROJECT_SOURCE_DIR}/glfw)
    set(GLFW_BUILD_DOCS     OFF)
    set(GLFW_BUILD_EXAMPLES OFF)
    set(GLFW_BUILD_TESTS    OFF)
    set(GLFW_INSTALL        OFF)
    add_subdirectory(${PROJECT_SOURCE_DIR}/glfw)
    if (NOT TARGET glad)
      add_library(glad
        ${GLFW_SOURCE_DIR}/deps/glad/glad.h
        ${GLFW_SOURCE_DIR}/deps/glad.c)
      target_include_directories(glad PUBLIC
        "$<BUILD_INTERFACE:"
        "${PROJECT_SOURCE_DIR}/glfw;"
        "${PROJECT_SOURCE_DIR}/glfw/include;"
        "${PROJECT_SOURCE_DIR}/glfw/deps;"
        ">")
    endif ()
    target_include_directories(glfw INTERFACE
      "$<BUILD_INTERFACE:"
      "${PROJECT_SOURCE_DIR}/glfw;"
      "${PROJECT_SOURCE_DIR}/glfw/include;"
      "${PROJECT_SOURCE_DIR}/glfw/deps;"
      ">")
    set_target_properties(glfw PROPERTIES
      INTERFACE_COMPILE_DEFINITIONS USE_GLFW=1)
  else ()
    messate(FATAL_ERROR "cannot find glfw")
  endif ()
endif ()
## ======================================================================== ##
if (NOT TARGET imgui)
  if(EXISTS ${PROJECT_SOURCE_DIR}/ImGui)
    add_subdirectory(${PROJECT_SOURCE_DIR}/ImGui)
  else ()
    messate(FATAL_ERROR "cannot find imgui")
  endif ()
endif ()
## ======================================================================== ##