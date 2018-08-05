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
  ${PROJECT_SOURCE_DIR}/source/src/TransferFunctionModule.h 
  ${PROJECT_SOURCE_DIR}/source/src/TransferFunctionModule.cpp) 
target_include_directories(tfn_module_core PUBLIC
  "$<BUILD_INTERFACE:"
  "${PROJECT_SOURCE_DIR}/source/src;"
  ">")
set_target_properties(tfn_module_core
  PROPERTIES CXX_STANDARD 14)

## ======================================================================== ##
#
# ImGui widget
#
add_library(tfn_module_core_widgets 
  ${PROJECT_SOURCE_DIR}/source/src/widgets/DefaultTransferFunctionMaps.h
  ${PROJECT_SOURCE_DIR}/source/src/widgets/HelperFunctions.h
  ${PROJECT_SOURCE_DIR}/source/src/widgets/TransferFunctionWidget.h
  ${PROJECT_SOURCE_DIR}/source/src/widgets/TransferFunctionWidget.cpp) 
target_link_libraries(tfn_module_core_widgets
  tfn_module_core imgui glfw glad OpenGL)
set_target_properties(tfn_module_core_widgets
  PROPERTIES CXX_STANDARD 14)

## ======================================================================== ##
#
# Paraview Converter
#
if(OSPRAY_MODULE_PARAVIEW_TFN_CVT)
  add_executable(tfnConvertFromParaView
    ${PROJECT_SOURCE_DIR}/source/src/apps/ConvertTFNParaView.h
    ${PROJECT_SOURCE_DIR}/source/src/apps/ConvertTFNParaView.cpp
    ${PROJECT_SOURCE_DIR}/source/src/common/json/json-forwards.h
    ${PROJECT_SOURCE_DIR}/source/src/common/json/json.h
    ${PROJECT_SOURCE_DIR}/source/src/common/json/jsoncpp.cpp)
  target_link_libraries(tfnConvertFromParaView tfn_module_core)
  set_target_properties(tfnConvertFromParaView
    PROPERTIES CXX_STANDARD 14)
endif()

## ======================================================================== ##
#
# TODO VisIt Converter
#
if(OSPRAY_MODULE_VISIT_TFN_CVT)
endif()

## ======================================================================== ##
#
# test volume renderer
#
set(TFN_MODULE_ROOT ${PROJECT_SOURCE_DIR}/source)
add_subdirectory(test)
