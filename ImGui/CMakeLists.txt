#
# build LodePNG
#
include_directories(
  ${CMAKE_CURRENT_LIST_DIR}/upstream
  ${CMAKE_CURRENT_LIST_DIR}/examples/opengl3_example)
add_library(imgui
  upstream/imgui.cpp
  upstream/imgui_draw.cpp
  upstream/imgui_demo.cpp
  opengl3_example/imgui_impl_glfw_gl3.cpp)
target_link_libraries(imgui ${OPENGL_LIBS})
set(ImGUI_LIBRARIES imgui PARENT_SCOPE)
set(ImGUI_INCLUDE_DIR
  ${CMAKE_CURRENT_LIST_DIR}/upstream
  ${CMAKE_CURRENT_LIST_DIR}/opengl3_example/
  PARENT_SCOPE)

