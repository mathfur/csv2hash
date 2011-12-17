# -*- encoding: utf-8 -*-

require "csv"
require "csv2hash/helper"
require "csv2hash/area"

class CSV2Hash
  class Sheet
    attr_reader :rows

    def initialize(csv_fname)
      @csv_fname = csv_fname
      @rows = CSV.read(csv_fname)
      while (1 <= @rows.length) && @rows.last.all?{|elem| elem.blank?}
        @rows.pop
      end
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
      rows.index{|r| r.first.present?}
    end

    def primary_area
      Area.new(self, 0, blank_height, blank_width-1, height-1)
    end

    def secondary_area
      Area.new(self, blank_width, 0, width-1, blank_height-1)
    end

    def value_area
      Area.new(self, blank_width, blank_height, width-1, height-1)
    end
  end
end
