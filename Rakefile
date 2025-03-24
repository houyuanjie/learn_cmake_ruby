# frozen_string_literal: true

require "fileutils"
require "tmpdir"

require "bundler/gem_tasks"
require "standard/rake"

task build: :cmake

gemspec = Gem::Specification.load("learn_cmake_ruby.gemspec")

desc "Compile CMake extensions in ext/ directory and install to lib/"
task :cmake do
  extensions = gemspec.extensions

  if extensions.empty?
    puts "[INFO] No extensions to compile."
    next
  end

  extensions.each do |ext|
    puts "[INFO] Compiling extension: #{ext}"

    unless File.exist?(ext)
      puts "[WARN] Skipping extension: #{ext}, file does not exist."
    end

    unless File.basename(ext) == "CMakeLists.txt"
      puts "[WARN] Skipping extension: #{ext}, not a CMakeLists.txt file."
      next
    end

    ext_dir = File.dirname(ext)

    unless ext_dir.start_with?("ext/")
      puts "[WARN] Skipping extension: #{ext}, not in ext/ directory."
      next
    end

    full_ext_dir = File.expand_path(ext_dir, __dir__)
    full_lib_dir = File.expand_path("lib", __dir__)
    FileUtils.mkdir_p(full_lib_dir)

    Dir.mktmpdir do |build_dir|
      puts "[INFO] Created temporary build directory: #{build_dir} for extension: #{ext}"

      puts "[INFO] Congfiguring CMake for extension: #{ext}"
      sh(
        "cmake",
        "-S", full_ext_dir,
        "-B", build_dir,
        "-G", "Ninja",
        "-DCMAKE_BUILD_TYPE=Release",
        "-DCMAKE_INSTALL_PREFIX=#{full_lib_dir}"
      )

      puts "[INFO] Building extension: #{ext}"
      sh("cmake", "--build", build_dir)

      puts "[INFO] Installing extension: #{ext}"
      sh("cmake", "--install", build_dir)
    end
  end
end
