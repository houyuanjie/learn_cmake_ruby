# frozen_string_literal: true

require_relative "learn_cmake_ruby/version"

begin
  require_relative "learn_cmake_ruby/learn_cmake_ruby"
rescue LoadError
  require "learn_cmake_ruby/learn_cmake_ruby"
end

module LearnCmakeRuby
  class Error < StandardError; end
  # Your code goes here...
end
