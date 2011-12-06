require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe CSV2Hash::Translator do
  describe "#initialize" do
    before(:each) do
      @filename = stub("filename")
    end

    it "指定されたファイルが存在しない場合は例外を返すこと" do
      File.stub(:exist?).with(@filename).and_return(false)
      lambda { CSV2Hash::Translator.new(@filename) }.should raise_error(/存在しない/)
    end

    it "指定されたcsvファイルが開けない場合は例外を投げること" do
      CSV.should_receive(:foreach).and_raise(Errno::ENOENT)
      lambda { CSV2Hash::Translator.new(@filename) }.should raise_error
    end
  end
end

describe Sheet do
  before(:each) do
    @sheet1 = Sheet.new([[]])
    @sheet2 = Sheet.new([[1]])
    @sheet3 = Sheet.new([[1, 2], [3]])
  end
  describe "#top_row" do
    it "セルが無ければnilとなること" do
      @sheet1.top_row.should be_nil
    end
    it "先頭の行が取得できること" do
      @sheet2.top_row.should == [1]
    end
  end
  describe "#left_column" do
    it "セルが無ければnilとなること" do
      @sheet1.left_column.should be_nil
    end
    it "先頭の列が取得できること" do
      @sheet2.left_column.should == [1]
    end
  end

  describe "#max_x" do
    it "セルが無ければ0となること" do
      @sheet1.max_x.should == 0
    end
    it "一番長い行の長さが取得できること" do
      @sheet2.max_x.should == 1
      @sheet3.max_x.should == 2
    end
  end

  describe "#max_x" do
    it "セルが無ければ0となること" do
      @sheet1.max_y.should == 0
    end
    it "一番長い列の長さが取得できること" do
      @sheet2.max_y.should == 1
      @sheet3.max_y.should == 2
    end
  end

  describe "#min_y" do
    it "left_columnが空ならnilを返すこと" do
      @sheet1.stub(:left_column => [])
      @sheet1.min_y.should be_nil
    end
    it "left_columnが空白を持っていないなら0が返ること" do
      @sheet1.stub(:left_column => %w{a b c})
      @sheet1.min_y.should == 0
    end
    it "left_columnが空白を1個持っているなら1を返すこと" do
      @sheet1.stub(:left_column => [' ', 'a'])
      @sheet1.min_y.should == 1
    end
  end

  describe "#min_x" do
    it "top_rowが空ならnilを返すこと" do
      @sheet1.stub(:top_row => [])
      @sheet1.min_x.should be_nil
    end
    it "top_rowが空白を持っていないなら0が返ること" do
      @sheet1.stub(:top_row => %w{a b c})
      @sheet1.min_x.should == 0
    end
    it "top_rowが空白を1個持っているなら1を返すこと" do
      @sheet1.stub(:top_row => [' ', 'a'])
      @sheet1.min_x.should == 1
    end
  end

  TODO 2011-12-06 Sheet#valuesという変数名は実態と合っていないので変更する

    TODO 2011-12-05 続き書く(残り: Sheet後半、Translatorのテスト)
end

describe CSV2Hash::Range2D do
  describe "#initialize" do
    it "0, 0から生成された場合、cellsは[[0.0]]となること" do
      Range2D.new(0, 0).cells.should == [0, 0]
    end

    it "第一引数が(1..2)で第二引数が(3..4)で生成された場合、cellsの[[1, 3], [1, 4], [2, 3], [2, 4]]となること" do
      Range2D.new((1..2), (3..4)).cells.sort.should == [[1, 3], [1, 4], [2, 3], [2, 4]].sort
    end

    it "第一・第二引数が(1..0)ならcellsは[]となること" do
      Range2D.new((1..0), (1..0)).cells.should == []
    end

    it "第一引数に[[1, 2], [3, 4]]を与えるとcellsは[[1, 2], [3, 4]]となること" do
      @arr = [[1, 2], [3, 4]]
      Range2D.new(@arr).cells.should == @arr
    end
  end

  describe "#+" do
    it "Range.new(1, 2)とRange(3, 4)を足し合わせた結果はRange2Dで、そのcellsは[[1, 2], [3, 4]]となること" do
      @result = (Range.new(1, 2) + Range.new(3, 4))
      @result.should be_kind_of(Range2D)
      @result.cells.sort.should == [[1, 2], [3, 4]].sort
    end
  end

  describe "#values" do
    it do
      Range2D.new(0, 0).values([[3]])).should == [3]
    end

    it do
      Range2D.new((1..0), 0).values([[3]]).should == []
    end
  end

  describe "#valid?" do
    it '空白のセルがあればfalseとなること' do
      Range2D.new(0, 0).valid?([['']])).should be_false
    end

    it '空白のセルがなければtrueとなること' do
      Range2D.new(0, 0).valid?([['aa']])).should be_true
    end
  end
end
