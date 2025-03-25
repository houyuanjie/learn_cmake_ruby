# frozen_string_literal: true

require "rake"
require_relative "lib/learn_cmake_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "learn_cmake_ruby"
  spec.version = LearnCmakeRuby::VERSION
  spec.authors = ["Hou Yuanjie"]
  spec.email = ["houyuanjie555@qq.com"]

  spec.summary = "Ruby bindings for Learn CMake Project."
  # spec.description = "TODO: Write a longer description or delete this line."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "http://localhost:9292"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
  #   end
  # end

  spec.files = FileList[
    "lib/**/*.rb",
    "ext/learn_cmake_ruby/*.{c,cpp,h}",
    "ext/learn_cmake_ruby/**/CMakeLists.txt",
    "ext/learn_cmake_ruby/vendor/**/*"
  ]

  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/learn_cmake_ruby/Rakefile"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
