require "csv2hash/sheet"

class CSV2Hash
  def foo
    Sheet.new(csv_fname).value_area.cells.each do |cell|
      cell.primary_keys #=> まだない
      cell.secondary_keys #=> まだない
      cell.value
    end
  end
end
