# frozen_string_literal: true

require_relative "learn_cmake_ruby/version"

begin
  # You load extensions go here at devtime.
  require_relative "learn_cmake_ruby/learn_cmake_ruby"
rescue LoadError
  # User loads extensions go here at runtime.
  require "learn_cmake_ruby/learn_cmake_ruby"
end

module LearnCmakeRuby
  class Error < StandardError; end
  # Your code goes here...
end
