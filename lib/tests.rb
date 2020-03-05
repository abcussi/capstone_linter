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
end
