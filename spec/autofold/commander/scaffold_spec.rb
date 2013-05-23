require 'spec_helper'

describe Autofold::Commander::Scaffold do
  let(:api) { Autofold::Commander::Scaffold }
  let(:action) { lambda { |input, expected| api.send(@action, input).should eq expected } }
  describe "#parse_to_simple_array" do
    before(:each) { @action = "parse_to_simple_array" }
    it "should take a fairly complicated input argument and smear it out to its parts" do
      input = "dog:cat:(bat+nig)+hay:(jew:mew+rat):(gay+man)"
      ex = []
      ex.push "dog:cat:bat"
      ex.push "dog:cat:nig"
      ex.push "hay:jew:mew:gay"
      ex.push "hay:jew:mew:man"
      ex.push "hay:rat:gay"
      ex.push "hay:rat:man"
      expected = ex.map { |e| e.split(":") }
      action.call input, expected 
    end
    it "should take a given input and produce out an array of arrays that are all simplified" do
      input = "dog:(bat:cat+snail):racoon"
      expected = ["dog:bat:cat:racoon".split(":"), "dog:snail:racoon".split(":")]
      action.call input, expected
    end
  end
  describe "#_break_to_chunks" do
    before :each do
      @action = "_break_to_chunks"
    end
    it "should trivially equal to just breaking on colons" do
      input = "dog:bat:cat:snail:racoon"
      expected = ["dog:bat:cat:snail:racoon".split(":")]
      action.call input, expected
    end
    it "should trivially equal to just breaking on colons" do
      input = "dog:(bat:cat+snail):racoon"
      expected = [["dog", "(bat:cat+snail)", "racoon"]]
      action.call input, expected
    end
  end
  describe "#_simplify_split" do
    before :each do
      @action = "_simplify_split"
    end
    it "should nominally just return a null double array" do
      input = []
      expected = [input]
      action.call input, expected
    end
    it "should take a slightly complexed row and split it to two" do
      input = ["cat+bat"]
      expected = [["cat"],["bat"]]
      action.call input, expected
    end
    it "should leave alone rows that are already simple" do
      input = ["dog", "cat+snail", "bat"]
      expected = ["dog:cat:bat".split(":"), "dog:snail:bat".split(":")]
      action.call input, expected
    end
    it "should be able to handle arbitrarily complicated expressions" do
      input = ["dog", "(bat:cat+snail)", "racoon"]
      expected = ["dog:bat:cat:racoon".split(":"), "dog:snail:racoon".split(":")]
      action.call input, expected
    end
  end
  describe "#_break_on_colon" do
    before :each do
      @action = "_break_on_colon"
    end
    it "should correctly split up the input string" do
      input = "dog:(bat:cat+snail):racoon"
      expected = ["dog","(bat:cat+snail)","racoon"]
      action.call input, expected
    end
    it "should properly handle the simple case" do
      input = "dog"
      expected = ["dog"]
      action.call input, expected
    end
    it "should a complex beginning case" do
      input = "(dog+cat:bat:hat):racoon:(snail+slug)"
      expected = ["(dog+cat:bat:hat)", "racoon", "(snail+slug)"]
      action.call input, expected
    end
  end
  describe "#_break_on_plus" do
    before :each do
      @action = "_break_on_plus"
    end
    it "should correctly split up the input string" do
      input = "dog:(bat:cat+snail):racoon"
      expected = ["dog:(bat:cat+snail):racoon"]
      action.call input, expected
    end
    it "should properly handle the simple case" do
      input = "dog"
      expected = ["dog"]
      action.call input, expected
    end
    it "should properly handle the simple case" do
      input = "dog:cat:snail"
      expected = ["dog:cat:snail"]
      action.call input, expected
    end
    it "should a complex beginning case" do
      input = "dog+cat:bat:hat:racoon:(snail+slug)"
      expected = ["dog","cat:bat:hat:racoon:(snail+slug)"]
      action.call input, expected
    end
  end
  describe "#_malformed_input" do
    it "should have tests!"
  end
end