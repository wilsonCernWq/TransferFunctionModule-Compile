## ======================================================================== ##
##
## Standalone Transfer Function Widget using ImGui
##
## ======================================================================== ##
cmake_minimum_required(VERSION 3.1)
project(TransferFunctionModule)

## ======================================================================== ##
option(TFN_MODULE_WIDGET
  "Build 2D transfer function widget for OSPRay Application" ON)
OPTION(TFN_MODULE_PARAVIEW_CVT
  "Build ParaView transfer function converter" OFF)
OPTION(TFN_MODULE_VISIT_CVT
  "Build VisIt transfer function converter (TODO)" OFF)

## ======================================================================== ##
include(packages.cmake)

## ======================================================================== ##
#
# core library
#
add_library(tfn_module_core 
  ${PROJECT_SOURCE_DIR}/../src/TransferFunctionModule.cpp) 
target_include_directories(tfn_module_core PUBLIC
  "$<BUILD_INTERFACE:"
  "${PROJECT_SOURCE_DIR}/../src;"
  ">")
target_link_libraries(tfn_module_core imgui glfw OpenGL)
set_target_properties(tfn_module_core
  PROPERTIES CXX_STANDARD 11)

## ======================================================================== ##
#
# Paraview Converter
#
if(OSPRAY_MODULE_PARAVIEW_TFN_CVT)
  add_executable(tfnConvertFromParaView
    ${PROJECT_SOURCE_DIR}/../src/apps/ConvertTFNParaView.cpp
    ${PROJECT_SOURCE_DIR}/../src/common/json/jsoncpp.cpp)
  target_link_libraries(tfnConvertFromParaView
    tfn_module_core imgui glfw OpenGL)
  set_target_properties(tfnConvertFromParaView
    PROPERTIES CXX_STANDARD 11)
endif()

## ======================================================================== ##
#
# TODO VisIt Converter
#
if(OSPRAY_MODULE_VISIT_TFN_CVT)
endif()

## ======================================================================== ##
#
# ImGui widget
#
if(OSPRAY_MODULE_TFN_WIDGET)
  add_library(tfn_module_core_widgets 
    ${PROJECT_SOURCE_DIR}/../src/widgets/TransferFunctionWidget.cpp) 
  target_link_libraries(tfn_module_core_widgets
    tfn_module_core imgui glfw OpenGL)
  set_target_properties(tfn_module_core_widgets
    PROPERTIES CXX_STANDARD 11)
endif()

## ======================================================================== ##
#
# test volume renderer
#
set(TFN_MODULE_ROOT ${PROJECT_SOURCE_DIR}/..)
add_subdirectory(test)