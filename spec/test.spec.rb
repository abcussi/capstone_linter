require_relative '../lib/Reader.rb'
require_relative '../lib/tests.rb'

include Test

describe Test do
  let(:key_o) { '{' }
  let(:key_c) { '}' }

  describe '#check_indent_level' do
    it 'return array with the expected level of indentation' do
      file_path = '../spec/spec/indent_test.css'
      a = Reader.new(file_path)
      expect(check_indent_level(b.content_s, key_o, key_c)).to eql([0, 1, 0])
    end
  end

end
