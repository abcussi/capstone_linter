require 'strscan'

module Test
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
  def spc_check_before(lvl, cad, car)
    cad.reset
    res= cad.scan_until(Regexp.new(car))
    while cad.matched?
      res= StringScanner.new(res.reverse)
      res.skip(Regexp.new(car))
      res.scan(/\s+/)
      log_error(3, lvl, car, res.string.length - res.pos) if res.matched != ' '
      res= cad.scan_until(Regexp.new(car))
    end
  end
  def spc_check_after(lvl, cad, car)
    cad.reset
    cad.scan_until(Regexp.new(car))
    while cad.matched?
      cad.scan(/\s+/)
      log_error(2, lvl, car, cad.pos) if cad.matched != ' '
      cad.scan_until(Regexp.new(car))
    end
  end
  def check_ret_after(lvl, cad, car)
    cad.reset
    cad.scan_until(Regexp.new(car))
    while cad.matched?
      log_error(4, lvl, car, cad.pos) unless cad.eos?
      cad.scan_until(Regexp.new(car))
    end
  end

  def check_lines_bet_blocks(cont, car)
    res = false
    inc = 0
    0.upto(cont.length - 1) do |a|
      cont[a].reset
      if res && cont[a].string == ''
        inc += 1
        log_error(5, a + 1, car) if inc > 1
      elsif res && cont[a].string != ''
        log_error(5, a + 1, car) if inc.zero? && !cont[a].exist?(/}/)
        res = false
      else
        res = false
      end
      if cont[a].exist?(/}/)
        res = true
        inc = 0
      end
    end
  end
  def log_error(cases, lvl, car = nil, position = nil, lic = nil)
    line_with_test = "problem: line #{lvl}"
    line_with_test += ", column: #{position}" unless position.nil?
    case cases
    when 1
      puts "#{line_with_test} Indentation problem expected #{lic} white spaces"
    when 2
      puts "#{line_with_test} Spacing problem expected one space after #{car}"
    when 3
      puts "#{line_with_test} Spacing problem expected one space before #{car}"
    when 4
      puts "#{line_with_test} Format problem Expected line break after #{car}"
    when 5
      puts "#{line_with_test} Format problem Expected only one line after #{car}"
    else
      puts "#{line_with_test} problem"
    end
    cases
  end
end
