class Reader
  attr_writer :line_read, :direction
  attr_accessor :cont
  def initialize(direction)
    self.direction = direction
    self.cont = get_file_content(direction)
    self.line_read = cont.length
  end

  private

  # rubocop: disable Lint/UselessAssignment
  def get_file_content(direction)
    cont = ''
    File.open(direction, 'r') { |f| cont = f.readlines.map(&:chomp) }
    contcan = cont.map { |v| v = StringScanner.new(v) }
    contcan
  end
  # rubocop: enable Lint/UselessAssignment
end
