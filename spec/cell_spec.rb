require "lib/csv2hash"

describe CSV2Hash::Cell do
  describe "#primary_keys" do
    before(:each) do
      @sheet = stub("sheet")
    end
    it "primary_areaのcellsのうちどのcellのyも@yと異なるとき、空行列を返すこと" do
      @cell = CSV2Hash::Cell.new(@sheet, 0, 1, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 0, 2, '')
      @sheet.stub_chain(:primary_area, :cells).and_return([@cell2])

      @cell.primary_keys.should == []
    end

    it "primary_areaのcellsのうち一要素のyが@yと同じなら、そのcellのvalueを返すこと" do
      @cell = CSV2Hash::Cell.new(@sheet, 0, 1, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 0, 1, 'ab')
      @sheet.stub_chain(:primary_area, :cells).and_return([@cell2])

      @cell.primary_keys.should == ['ab']
    end

    it "primary_areaのcellsすべてのyが@yと同じなら、そのcellsのvalueをxでソートしたものが返ること" do
      @cell = CSV2Hash::Cell.new(@sheet, 0, 1, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 4, 1, 'a')
      @cell3 = CSV2Hash::Cell.new(@sheet, 3, 1, 'b')
      @sheet.stub_chain(:primary_area, :cells).and_return([@cell2, @cell3])

      @cell.primary_keys.should == ['b', 'a']
    end
  end

  describe "#secondary_keys" do
    it "secondary_areaのcellsのうちどのcellのxも@xと異なるとき、空行列を返すこと" do
      @cell = CSV2Hash::Cell.new(@sheet, 1, 0, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 2, 0, '')
      @sheet.stub_chain(:secondary_area, :cells).and_return([@cell2])

      @cell.secondary_keys.should == []
    end

    it "secondary_areaのcellsのうち一要素のxが@xと同じなら、そのcellのvalueを返すこと" do
      @cell = CSV2Hash::Cell.new(@sheet, 1, 0, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 1, 0, 'ab')
      @sheet.stub_chain(:secondary_area, :cells).and_return([@cell2])

      @cell.secondary_keys.should == ['ab']
    end

    it "secondary_areaのcellsすべてのxが@xと同じなら、そのcellsのvalueをyでソートしたものが返ること" do
      @cell = CSV2Hash::Cell.new(@sheet, 1, 0, '')
      @cell2 = CSV2Hash::Cell.new(@sheet, 1, 4, 'a')
      @cell3 = CSV2Hash::Cell.new(@sheet, 1, 3, 'b')
      @sheet.stub_chain(:secondary_area, :cells).and_return([@cell2, @cell3])

      @cell.secondary_keys.should == ['b', 'a']
    end
  end
end
