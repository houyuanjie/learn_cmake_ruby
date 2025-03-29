cmake_minimum_required(VERSION 3.25)

project(LearnCMakeRubyProject
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
add_library(learn_cmake_ruby SHARED
  learn_cmake_ruby.c
)

target_link_libraries(learn_cmake_ruby
  PUBLIC hello
  PUBLIC ${Ruby_LIBRARIES}
)

target_include_directories(learn_cmake_ruby
  PUBLIC ${Ruby_INCLUDE_DIRS}
)

set(LEARN_CMAKE_RUBY_DEPENDENCIES
  hello
)

# Remove the 'lib' prefix, and add the '.so' suffix
# This is common convention for native extensions in Ruby
set_target_properties(learn_cmake_ruby
  PROPERTIES
    PREFIX ""
    SUFFIX ".so"
)

# set RPATH
if(APPLE)
  set_target_properties(learn_cmake_ruby
    PROPERTIES
      INSTALL_RPATH "@loader_path"
  )
elseif(UNIX)
  set_target_properties(learn_cmake_ruby
    PROPERTIES
      INSTALL_RPATH "\$ORIGIN"
  )
endif()

# Install the library
install(
  TARGETS learn_cmake_ruby ${LEARN_CMAKE_RUBY_DEPENDENCIES}
  LIBRARY DESTINATION learn_cmake_ruby
  RUNTIME DESTINATION learn_cmake_ruby
)
# end learn_cmake_ruby
