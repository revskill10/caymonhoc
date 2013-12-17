require 'rack/test'

#encoding: utf-8
require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinatra Application" do
  it "should allow accessing the home page" do
    job = Job.new
    temp = job.load_sv("16", "12", "101")
    temp.should_not be_nil
    temp[0]["ma_sinh_vien"].strip.should == '1212101001'
  end
end