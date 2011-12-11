require "csv2hash/sheet"

class CSV2Hash
  def foo
    Sheet.new(csv_fname).value_area.cells.inject({}) do |result, cell|
      keys = cell.primary_keys + cell.secondary_keys
      accumulate_to_hash(result, keys, cell.value)
    end
  end
end
