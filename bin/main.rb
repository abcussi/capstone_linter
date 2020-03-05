require_relative '../lib/test.rb'
require_relative '../lib/Reader.rb'

file_path = ARGV.shift
key_o = '{'
key_c = '}'
b = Reader.new(file_path)
