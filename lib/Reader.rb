class Reader
  attr_accessor :direction, :line_read, :cont
  def initialize(direction)
    self.direction = direction
    self.cont = get_file_content(direction)
    self.line_read = cont.length
  end

    private

  def get_file_content(direction)
    cont = ''
    File.open(direction, 'r') { |f| cont = f.readlines.map(&:chomp) }
    contcan = cont.map { |v| v = StringScanner.new(v) }
    contcan
  end
  end
