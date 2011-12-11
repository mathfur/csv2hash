require "lib/csv2hash"

describe CSV2Hash::Area do
  describe "#cells" do
    it "rowsが1要素でx1=x2=y1=y2=0なら[1]が返ること" do
      @sheet = stub("sheet")
      @area = CSV2Hash::Area.new(@sheet, 0, 0, 0, 0)
      @area.stub(:rows => [[1]])

      @area.cells.should have(1).items
      @area.cells.first.x.should == 0
      @area.cells.first.y.should == 0
      @area.cells.first.value.should == 1
    end

    it "rowsが1要素でx1=x2=y1=y2=0なら[1]が返ること" do
      @sheet = stub("sheet")
      @area = CSV2Hash::Area.new(@sheet, 0, 0, 1, 0)
      @area.stub(:rows => [[1, 2]])

      @area.cells.should have(2).items
      @area.cells.first.x.should == 0
      @area.cells.first.y.should == 0
      @area.cells.first.value.should == 1
      @area.cells.last.x.should == 1
      @area.cells.last.y.should == 0
      @area.cells.last.value.should == 2
    end
  end
end
