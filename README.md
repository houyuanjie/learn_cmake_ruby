# LearnCmakeRuby - 使用 CMake 构建 Ruby 扩展

本项目展示了如何使用 CMake 构建 Ruby 的 C 扩展，并打包为 Gem

## 项目结构

```
.
├── ext/
│  └─── learn_cmake_ruby/       # C 扩展
│      ├── learn_cmake_ruby.c   # C 扩展入口
│      ├── CMakeLists.txt       # CMake 配置文件
│      └── vendor/              # CMake 子项目依赖
├── lib/                        # Ruby 代码
├── Rakefile                    # 构建任务
├── learn_cmake_ruby.gemspec    # Gem 配置
└── Gemfile                     # 依赖管理
```

## 核心配置

### 1. gemspec

```ruby
# 包含 Ruby 代码和 C 扩展代码
spec.files = FileList[
  "lib/**/*.rb",
  "ext/learn_cmake_ruby/*.{c,cpp,h}",
  "ext/learn_cmake_ruby/vendor/**/*",
  # 如果 C 扩展有多层目录，需要包含所有的 CMakeLists.txt
  # "ext/learn_cmake_ruby/**/CMakeLists.txt",
]

# 指定扩展构建文件，Bundler 支持 CMakeLists.txt
# 这个文件会被自动加到 spec.files 中，如果 C 扩展只有一层目录，可以在 spec.files 中省略
spec.extensions = ["ext/learn_cmake_ruby/CMakeLists.txt"]
```

### 2. CMake 配置

```cmake
# 查找 Ruby 环境
find_package(Ruby 3.1 REQUIRED)

# 将 C 扩展构建为共享库
add_library(learn_cmake_ruby SHARED learn_cmake_ruby.c)

# 链接 C 扩展依赖的库
target_link_libraries(learn_cmake_ruby PUBLIC hello)

# 链接 Ruby 库
target_link_libraries(learn_cmake_ruby PUBLIC ${Ruby_LIBRARIES})
target_include_directories(learn_cmake_ruby PUBLIC ${Ruby_INCLUDE_DIRS})

# 省略 lib 前缀
# 将其依赖安装到相同的目录下
set_target_properties(learn_cmake_ruby PROPERTIES
  PREFIX ""
  INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/learn_cmake_ruby
)

# 安装 C 扩展和它的依赖
# 安装到该扩展特定的目录下
install(
  TARGETS learn_cmake_ruby hello
  LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/learn_cmake_ruby
)
```

### 3. Rake 任务

```ruby
# 加载 Bundler 任务
require "bundler/gem_tasks"

# 在 Bundler 构建前进行 CMake 构建
task build: :cmake

task :cmake do
  sh "cmake -S #{ext_dir} -B #{build_dir} -DCMAKE_INSTALL_PREFIX=#{lib_dir}"
  sh "cmake --build #{build_dir}"
  sh "cmake --install #{build_dir}"
end
```

> 注意：这个 rake cmake 构建任务只会在开发时使用，用户安装时，Bundler 会自动使用 spec.extensions 来构建 C 扩展

## 构建

```bash
bundle
rake build
```

## 交互测试

```bash
irb -I lib -r learn_cmake_ruby
```

或者

```bash
bin/console
```

## 安装

```bash
gem install pkg/learn_cmake_ruby-0.1.0.gem
```
