require "lib/csv2hash"

TESTDATA_PATH = File.expand_path( File.dirname(__FILE__) + "/testdata" )

describe CSV2Hash do
  describe "#to_hash" do
    it do
      CSV2Hash.new("#{TESTDATA_PATH}/1.csv").to_hash.should == {'2' => {'1' => '3'}}
    end

    it do
      CSV2Hash.new("#{TESTDATA_PATH}/2.csv").to_hash.should ==
        {'3' => {'4' => {'1' => '5', '2' => '6'}}}
    end
  end
end
