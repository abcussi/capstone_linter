require_relative 'Reader.rb'

file_path = ARGV.shift
k_open = '{'
k_close = '}'
b = Reader.new(file_path)
