cmake_minimum_required(VERSION 3.25)

project(
  LearnCMakeRubyProject
  VERSION 0.1.0
  LANGUAGES C
)

# Standard C11
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED YES)
set(CMAKE_C_EXTENSIONS NO)

# Build dependencies
add_subdirectory(vendor)

find_package(Ruby 3.1 REQUIRED)

# learn_cmake_ruby
add_library(learn_cmake_ruby SHARED learn_cmake_ruby.c)

target_link_libraries(learn_cmake_ruby PUBLIC hello)

target_link_libraries(learn_cmake_ruby PUBLIC ${Ruby_LIBRARIES})
target_include_directories(learn_cmake_ruby PUBLIC ${Ruby_INCLUDE_DIRS})

# Remove the lib prefix, common practice in Ruby land
set_target_properties(learn_cmake_ruby PROPERTIES
  PREFIX ""
  INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/learn_cmake_ruby
)

install(
  TARGETS learn_cmake_ruby hello
  LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/learn_cmake_ruby
)
# end learn_cmake_ruby
