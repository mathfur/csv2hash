class CSV2Hash
  class Cell
    attr_reader :sheet, :x, :y, :value
    def initialize(sheet, x, y, value)
      @sheet = sheet
      @x = x
      @y = y
      @value = value
    end

    def primary_keys
      sheet.primary_area.cells.select{|c| c.y == y }.sort_by{|c| c.x}.map{|c| c.value}
    end

    def secondary_keys
      sheet.secondary_area.cells.select{|c| c.x == x }.sort_by{|c| c.y}.map{|c| c.value}
    end
  end
end

