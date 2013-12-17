require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinatra Application" do
  it "should allow accessing the home page" do
    get '/'
    last_response.should be_ok
  end

  it "should get masinhvien" do 
  	get '/1112401400'
  	temp = JSON.parse(last_response.body)
  	temp[0]["name"].should_not be_nil
  end
end