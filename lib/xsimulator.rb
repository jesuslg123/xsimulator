# frozen_string_literal: true

require 'byebug'

def main
  puts 'Initializing....'

  input_file_path = process_path_from_args
  puts input_file_path
end

def process_path_from_args
  if ARGV.empty?
    raise StandardError, 'Missing input file parameter' # TODO: Custom exceptions class
  end

  ARGV.first
end

main
