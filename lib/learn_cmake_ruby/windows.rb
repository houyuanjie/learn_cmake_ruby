begin
  require "ruby_installer/runtime"

  RubyInstaller::Runtime.add_dll_directory(__dir__)

  gemspec = Gem::Specification.find_by_name("learn_cmake_ruby", version: LearnCmakeRuby::VERSION)
  full_ext_root = File.expand_path(gemspec.extension_dir)

  RubyInstaller::Runtime.add_dll_directory(File.join(full_ext_root, "learn_cmake_ruby"))
rescue => e
  warn "Failed to add DLL directory: #{e.message}"
  raise e
end
