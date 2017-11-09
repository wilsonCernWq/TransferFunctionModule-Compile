## ======================================================================== ##
##
## Standalone Transfer Function Widget using ImGui
##
## ======================================================================== ##
cmake_minimum_required(VERSION 3.1)
project(TransferFunctionModule)
## ======================================================================== ##
option(OSPRAY_MODULE_TFN_WIDGET
  "Build 2D transfer function widget for OSPRay Application" ON)
OPTION(OSPRAY_MODULE_PARAVIEW_TFN_CVT
  "Build ParaView transfer function converter" OFF)
OPTION(OSPRAY_MODULE_VISIT_TFN_CVT
  "Build VisIt transfer function converter" OFF)
## ======================================================================== ##
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_MODULE_PATH 
  ${CMAKE_MODULE_PATH} 
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
## ======================================================================== ##
find_package(OpenGL REQUIRED)
set(GLFW_BUILD_DOCS     OFF)
set(GLFW_BUILD_EXAMPLES OFF)
set(GLFW_BUILD_TESTS    OFF)
set(GLFW_BUILD_INSTALL  OFF)
include_directories(glfw/include)
include_directories(glfw/deps)
add_subdirectory(glfw)
add_library(glfw_glad
  ${GLFW_SOURCE_DIR}/deps/glad/glad.h
  ${GLFW_SOURCE_DIR}/deps/glad.c)
set(GLFW_LIBRARIES glfw glfw_glad)
add_subdirectory(ImGui)
## ======================================================================== ##
include_directories(../src glfw/include glfw/deps ${ImGUI_INCLUDE_DIR})
## ======================================================================== ##
add_library(tfn_module_core ../src/TransferFunctionModule.cpp) 
target_link_libraries(tfn_module_core 
  ${OPENGL_LIBRARIES}
  ${GLFW_LIBRARIES}
  ${ImGUI_LIBRARIES})

# Paraview Converter
if(OSPRAY_MODULE_PARAVIEW_TFN_CVT)
  add_executable(tfnConvertFromParaView
    ../src/apps/ConvertTFNParaView.cpp
    ../src/common/jsoncpp.cpp)
  target_link_libraries(tfnConvertFromParaView
    tfn_module_core
    ${OPENGL_LIBRARIES}
    ${GLFW_LIBRARIES}
    ${ImGUI_LIBRARIES})
endif()

# TODO VisIt Converter
if(OSPRAY_MODULE_VISIT_TFN_CVT)
endif()

# ImGui widget
if(OSPRAY_MODULE_TFN_WIDGET)
  add_library(tfn_module_core_widgets 
    ../src/widgets/TransferFunctionWidget.cpp) 
  target_link_libraries(tfn_module_core_widgets
    tfn_module_core
    ${OPENGL_LIBRARIES}
    ${GLFW_LIBRARIES}
    ${ImGUI_LIBRARIES})  
endif()
