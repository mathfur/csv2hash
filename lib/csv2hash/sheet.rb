require "csv"
require "csv2hash/helper"

class CSV2Hash
  class Sheet
    attr_reader :rows

    def initialize(csv_fname)
      @csv_fname = csv_fname
      @rows = CSV.foreach(csv_fname)
    end

    def width
      rows.map{|r| r.length }.max
    end

    def height
      rows.length
    end

    def blank_width
      nil if rows.length == 0
      rows.first.index{|e| e.present?}
    end

    def blank_height
      nil if rows.length == 0
      rows.index{|r| r.first != ''}
    end
  end
end
