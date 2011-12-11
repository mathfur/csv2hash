require "csv2hash/cell"

class CSV2Hash
  class Area
    attr_reader :sheet, :x1, :y1, :x2, :y2

    def initialize(sheet, x1, y1, x2, y2)
      @sheet = sheet
      @x1 = x1
      @y1 = y1
      @x2 = x2
      @y2 = y2
    end

    def rows
      sheet.rows
    end

    def cells
      result = []
      (x1..x2).to_a.each do |x|
        (y1..y2).to_a.each do |y|
          result << Cell.new(sheet, x, y, (rows[y]||[])[x])
        end
      end
      result
    end
  end
end
