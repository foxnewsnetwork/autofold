require 'spec_helper'

describe Autofold::Commander::CoreBuilder do
  let(:api) { Autofold::Commander::CoreBuilder }
  let(:builder) { api.from_absolute_path @path }
  before(:each) { Dir.chdir RSpec::Root }

  describe "#build" do
    before :each do
      @project_name = "hate_my_work"
      Autofold::Commander::BaseBuilder.from_project_name(@project_name).call
      @path = File.join(RSpec::Root, @project_name)
      @parent = "parent"
      @child = "child"
      builder.call @parent, @child
    end
    after :each do
      FileUtils.rm_r File.join(RSpec::Root, @project_name)
    end
    it "should create a folder called parent" do
      Dir.exist?(File.join(@path, "parent")).should be_true
    end
  end
end  