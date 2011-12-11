require "lib/csv2hash"

describe CSV2Hash do
  describe "#accumulate_to_hash" do
    it "keysが空行列なら、第一引数を返すこと" do
      CSV2Hash.accumulate_to_hash({}, [], 3).should == {}
      CSV2Hash.accumulate_to_hash({:foo => :bar}, [], 3).should == {:foo => :bar}
    end

    it "keysで格納しようとしたキーが既にある場合は例外を返すこと" do
      lambda { CSV2Hash.accumulate_to_hash({:a => 4}, [:a], 3) }.should raise_error
    end

    it do
      CSV2Hash.accumulate_to_hash({}, [:a], 3).should == {:a => 3}
      CSV2Hash.accumulate_to_hash({}, [:a, :b], 3).should == {:a => {:b => 3}}
      CSV2Hash.accumulate_to_hash({:c => 10}, [:a, :b], 3).should == {:a => {:b => 3}, :c => 10}
      CSV2Hash.accumulate_to_hash({:a => {:b => 3}}, [:a, :d], 4).should == {:a => {:b => 3, :d => 4}}
    end
  end
end
