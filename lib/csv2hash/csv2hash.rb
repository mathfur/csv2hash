# -*- encoding: utf-8 -*-

require "csv2hash/sheet"

class CSV2Hash
  attr_reader :csv_fname

  def initialize(csv_fname)
    @csv_fname = csv_fname
  end

  def to_hash
    Sheet.new(csv_fname).value_area.cells.inject({}) do |result, cell|
      keys = cell.primary_keys + cell.secondary_keys
      CSV2Hash.accumulate_to_hash(result, keys, cell.value)
    end
  end
end
