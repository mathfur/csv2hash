require "lib/csv2hash"

describe CSV2Hash::Sheet do
  before(:each) do
    @csv_fname = stub("csv_fname")
    CSV.stub(:foreach).with(@csv_fname).and_return([])
    @sheet = CSV2Hash::Sheet.new(@csv_fname)
  end

  describe "#width" do
    it "@rowsがブランクのときはnilが返ること" do
      @sheet.stub(:rows => [])
      @sheet.width.should be_nil
    end

    it do
      @sheet.stub(:rows => [['aa']])
      @sheet.width.should == 1
    end
  end

  describe "#height" do
    it "@rowsが0行なら0が返ること" do
      @sheet.stub(:rows => [])
      @sheet.height.should == 0
    end

    it "@rowsが1行なら1が返ること" do
      @sheet.stub(:rows => [['aa']])
      @sheet.height.should == 1
    end
  end

  describe "#blank_width" do
    it "ブランクが無い場合は0を返すこと" do
      @sheet.stub(:rows => [%w{aa bb}, %w{cc dd}])
      @sheet.blank_width.should == 0
    end

    it "ブランクが左端に一個ある場合は1を返すこと" do
      @sheet.stub(:rows => [['', 'bb'], %w{cc dd}])
      @sheet.blank_width.should == 1
    end
  end

  describe "#blank_height" do
    it "ブランクが無い場合は0を返すこと" do
      @sheet.stub(:rows => [%w{aa bb}, %w{cc dd}])
      @sheet.blank_height.should == 0
    end

    it "ブランクが左端に一個ある場合は1を返すこと" do
      @sheet.stub(:rows => [['', 'bb'], %w{cc dd}])
      @sheet.blank_height.should == 1
    end
  end

  describe "#primary_area" do
    it "@rowsが4マスで左上のみブランクの場合、左側の1セルのみがprimary_areaとなること" do
      @sheet.stub(:rows => [['', 'bb'], %w{cc dd}])
      result = @sheet.primary_area.cells
      @sheet.primary_area.x1.should == 0
      @sheet.primary_area.y1.should == 1
      @sheet.primary_area.x2.should == 0
      @sheet.primary_area.y2.should == 1
      result.should have(1).items
      result.first.value.should == 'cc'
    end
  end

  describe "#secondary_area" do
    it "@rowsが4マスで左上のみブランクの場合、右上の1セルのみがsecondary_areaとなること" do
      @sheet.stub(:rows => [['', 'bb'], %w{cc dd}])
      result = @sheet.secondary_area.cells
      @sheet.secondary_area.x1.should == 1
      @sheet.secondary_area.y1.should == 0
      @sheet.secondary_area.x2.should == 1
      @sheet.secondary_area.y2.should == 0
      result.should have(1).items
      result.first.value.should == 'bb'
    end
  end

  describe "#value_area" do
    it "@rowsが4マスで左上のみブランクの場合、右下の1セルのみがvalue_areaとなること" do
      @sheet.stub(:rows => [['', 'bb'], %w{cc dd}])
      result = @sheet.value_area.cells
      @sheet.value_area.x1.should == 1
      @sheet.value_area.y1.should == 1
      @sheet.value_area.x2.should == 1
      @sheet.value_area.y2.should == 1
      result.should have(1).items
      result.first.value.should == 'dd'
    end
  end
end
