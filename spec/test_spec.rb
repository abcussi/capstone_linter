require_relative '../lib/tests.rb'
require_relative '../lib/Reader.rb'
include Test

describe Test do
  let(:key_o) { '{' }
  let(:key_c) { '}' }
  
  describe '#check_indent_level' do
    it 'return array with the expected level of indentation' do
      file_path = 'spec/spec/indent_test.css'
      a = Reader.new(file_path)
      expect(check_indent_level(a.cont, key_o, key_c)).to eql([0, 1, 0])
    end
  end

  describe '#log_error' do
    it 'return an error with the parameters' do
      expect do
        log_error(1, 10, nil, nil, 2)
      end.to output("problem: line 10 Indentation problem expected 2 white spaces\n").to_stdout
    end
  end

  describe '#indent_cop' do
    it 'return a problem line 1 indentation' do
      file_path = 'spec\spec\indent_test.css'
      a = Reader.new(file_path)
      expect do
        indent_cop(a.cont, key_o, key_c)
      end.to output("problem: line 1 Indentation problem expected 0 white spaces\n").to_stdout
    end
  end

  describe '#spc_check_before' do
    it 'return a problem line 1 spacing' do
      file_path = 'spec\spec\spacing_test.css'
      a = Reader.new(file_path)
      expect do
        spc_check_before(1, a.cont[0], '{')
      end.to output("problem: line 1, column: 5 Spacing problem expected one space before {\n").to_stdout
    end
  end

  describe '#spc_check_after' do
    it 'return a problem line 3 spacing' do
      file_path = 'spec\spec\spacing_test.css'
      a = Reader.new(file_path)
      expect do
        spc_check_after(3, a.cont[2], ':')
      end.to output("problem: line 3, column: 7 Spacing problem expected one space after :\n").to_stdout
    end
  end

  describe '#check_ret_after' do
    it 'return a problem line 2 line format' do
      expect do
        file_path = 'spec\spec\line_form_test.css'
        a = Reader.new(file_path)
        check_ret_after(2, a.cont[1], ';')
      end.to output("problem: line 2, column: 17 Format problem Expected line break after ;\n").to_stdout
    end
  end

  describe '#check_ret_after' do
    it 'return a problem line 5 line format' do
      expect do
        file_path = 'spec\spec\line_form_test.css'
        a = Reader.new(file_path)
        check_lines_bet_blocks(a.cont, '}')
      end.to output("problem: line 5 Format problem Expected only one line after }\n").to_stdout
    end
  end
end
