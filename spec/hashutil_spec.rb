require 'hashutil'

require 'json'
require 'spec_helper'

describe HashUtil do

  describe '.multi_level_sort_keys' do
    before do
      @hash = {:c => {:zz => 3, :ww => 5, :aa => 17}, :b => 5, :asdf => { :d => 7, :a => 100 }}
    end

    it 'JSON keys should come in the same order as specified' do
      JSON.generate(@hash).should == '{"c":{"zz":3,"ww":5,"aa":17},"b":5,"asdf":{"d":7,"a":100}}'
    end

    it 'should sort keys at every level' do
      new_hash = @hash
      JSON.generate(HashUtil.multi_level_sort_keys(new_hash)).should ==
        '{"asdf":{"a":100,"d":7},"b":5,"c":{"aa":17,"ww":5,"zz":3}}'
      # There should be no side effects on the hash being sorted.
      new_hash.should == @hash
    end
  end

  describe '.multi_level_merge' do
    before do
      @h1 = {:a => 1, :b => { :c => 3, :q => 5 }, 'x' => 15}
      @h2 = {:z => 2, :b => { 'c' => 4, :f => 'foo' }, :x => 'bar'}
    end

    it 'should work' do
      # Not converting keys to strings.
      expect(
        HashUtil.multi_level_merge(@h1, @h2)
      ).to eq({
        :a => 1, :b=>{ :c => 3, 'c' => 4, :q => 5, :f => 'foo'}, 'x' => 15, :x => 'bar', :z =>2
      })

      # Converting keys to strings.
      expected_result =
      expect(
        HashUtil.multi_level_merge(@h1, @h2, :keys_to_strings => true)
      ).to eq({
        'a' => 1, 'b' => { 'c' => 4, 'f' => 'foo', 'q' => 5 }, 'x' => 'bar', 'z' => 2
      })
    end
  end

  describe '.make_proper_hash' do
    # nothing yes
  end

end
