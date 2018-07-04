#
# build LodePNG
#
INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_LIST_DIR}/upstream
  ${CMAKE_CURRENT_LIST_DIR}/examples/opengl3_example)
ADD_LIBRARY(imgui
  upstream/imgui.cpp
  upstream/imgui_draw.cpp
  upstream/imgui_demo.cpp
  opengl3_example/imgui_impl_glfw_gl3.cpp)
TARGET_LINK_LIBRARIES(imgui ${OPENGL_LIBS})
SET(ImGUI_LIBRARIES imgui PARENT_SCOPE)
SET(ImGUI_INCLUDE_DIR
  ${CMAKE_CURRENT_LIST_DIR}/upstream
  ${CMAKE_CURRENT_LIST_DIR}/opengl3_example/
  PARENT_SCOPE)

