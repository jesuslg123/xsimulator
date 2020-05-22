# frozen_string_literal: true

require 'byebug'
require_relative 'xsimulator/input/input'

def main
  puts 'Initializing....'

  input_file_path = process_path_from_args
  puts Input.new(input_file_path).inspect
end

def process_path_from_args
  if ARGV.empty?
    raise StandardError, 'Missing input file parameter' # TODO: Custom exceptions class
  end

  ARGV.first
end

main
