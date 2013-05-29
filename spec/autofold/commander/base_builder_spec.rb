require 'spec_helper'

describe Autofold::Commander::BaseBuilder do
  let(:api) { Autofold::Commander::BaseBuilder }
  let(:builder) { api.from_project_name @project_name }
  before(:each) { Dir.chdir RSpec::Root }
  describe "#build" do
    before :each do
      @project_name = "hate_my_life"
      @parent = "bat"
      @child = "hat"
      builder.call
    end
    after :each do
      FileUtils.rm_r File.join(RSpec::Root, @project_name) if File.exist?(File.join RSpec::Root, @project_name)
    end
    it "should have built the test project with its recursive data structure" do
      Dir.exist?(@project_name).should be_true
      ["README.markdown", "routetie.rb"].each do |content|
        Dir[File.join(RSpec::Root, @project_name, "*")].map { |f| f.split("/").last }.should include content
      end
    end

  end
end