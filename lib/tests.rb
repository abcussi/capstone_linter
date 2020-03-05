require 'strscan'

module Cops
  def indent_cop(cont, key_o, key_c)
    lev = check_indent_level(cont, key_o, key_c)
    cont.each_with_index do |x, a|
      x.reset
      x.scan(/\s+/)
      sp = if x.matched?
             x.matched.length
           else
             0
           end
      log_error(1, a + 1, nil, nil, lev[a] * 2) unless sp == lev[a] * 2
    end
  end
  def line_format_cop(cont)
    cont.each_with_index do |x, a|
      check_ret_after(a + 1, x, '{')
      check_ret_after(a + 1, x, ';')
      check_ret_after(a + 1, x, '}')
    end
    check_lines_bet_blocks(cont, '}')
  end
  def check_indent_level(cont, key_o, key_c)
    line = 0
    lines = []
    cont.each_with_index do |x, a|
      x.reset
      lines << line
      line += 1 if x.exist?(Regexp.new(key_o))
      next unless x.exist?(Regexp.new(key_c))

      line -= 1
      lines[a] = line
    end
    lines
  end
  def spacing_cop(cont)
    cont.each_with_index do |x, a|
      spc_check_before(a + 1, x, '{')
      spc_check_after(a + 1, x, '\)')
      spc_check_before(a + 1, x, '\(')
      spc_check_after(a + 1, x, ':')
      spc_check_after(a + 1, x, ',')
    end
  end
end
