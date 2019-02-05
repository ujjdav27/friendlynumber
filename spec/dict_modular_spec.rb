require '.\spec\spec_helper'
require '.\dict_modular.rb'
describe 'dict_modular' do
  before(:each) do
    @dict_obj = HumanFriendlyNumber.new
  end
  it 'returns correct output string' do
    test_inp = '2282668687'
    expect(@dict_obj.find_string_for_number(test_inp)).to eq ["catamounts", [["act", "amounts"], ["act", "contour"], ["acta", "mounts"], ["bat", "amounts"], ["bat", "contour"], ["cat", "contour"], "catamounts"]]
  end
  it 'returns correct output string with diff input' do
    test_inp = '6686787825'
    expect(@dict_obj.find_string_for_number(test_inp)).to eq ["motortruck", [["motor", "usual"], ["noun", "struck"], ["nouns", "truck"], ["nouns", "usual"], ["onto", "struck"], "motortruck"]]
  end
end
