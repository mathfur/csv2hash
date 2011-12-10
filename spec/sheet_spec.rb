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
end
