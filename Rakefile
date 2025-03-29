# frozen_string_literal: true

require "tmpdir"

require "bundler/gem_tasks"
require "rake/clean"
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
      next
    end

    unless File.basename(ext) == "CMakeLists.txt"
      if File.exist?(File.expand_path("../CMakeLists.txt", ext))
        puts "[INFO] Using CMakeLists.txt in parent directory for extension: #{ext}"
      else
        puts "[WARN] Skipping extension: #{ext}, no CMakeLists.txt found in parent directory."
        next
      end
    end

    ext_dir = File.dirname(ext)

    unless ext_dir.start_with?("ext/")
      puts "[WARN] Skipping extension: #{ext}, not in ext/ directory."
      next
    end

    full_ext_dir = File.expand_path(ext_dir, __dir__)
    full_lib_root = File.expand_path("lib", __dir__)

    mkdir_p(full_lib_root)

    Dir.mktmpdir do |build_dir|
      puts "[INFO] Created temporary build directory: #{build_dir} for extension: #{ext}"

      puts "[INFO] Congfiguring CMake for extension: #{ext}"
      sh(
        "cmake",
        "-S", full_ext_dir,
        "-B", build_dir,
        "-G", "Ninja",
        "-DCMAKE_BUILD_TYPE=Debug",
        "-DCMAKE_INSTALL_PREFIX=#{full_lib_root}"
      )

      puts "[INFO] Building extension: #{ext}"
      sh("cmake", "--build", build_dir)

      puts "[INFO] Installing extension: #{ext}"
      sh("cmake", "--install", build_dir)
    end
  end
end

CLEAN << FileList["lib/**/*.{so,dylib,dll}"]

task default: %i[clobber cmake standard]
