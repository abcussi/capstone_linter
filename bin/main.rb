#!/usr/bin/env ruby
require_relative '../lib/tests.rb'
require_relative '../lib/reader.rb'
# rubocop: disable Style/MixinUsage:
include Test
# rubocop: enable Style/MixinUsage:
file_path = ARGV.shift
key_o = '{'
key_c = '}'
a = Reader.new(file_path)

line_format_cop(a.cont)
spacing_cop(a.cont)
indent_cop(a.cont, key_o, key_c)
