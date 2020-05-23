# frozen_string_literal: true

require_relative 'lib/xsimulator'

def main
  path = process_path_from_args
  XSimulator.new(path).run
end

def process_path_from_args
  raise StandardError, 'Missing input file parameter' if ARGV.empty?

  ARGV.first
end

main
