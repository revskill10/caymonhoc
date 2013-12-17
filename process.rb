#encoding: utf-8
require 'sinatra'
require 'rest_client'
require 'yajl/json_gem'
require 'json'
require 'thin'

before do
    content_type 'application/json'
end

set :server, %w[thin]
set :bind, '0.0.0.0'
set :port, 9494

disable = '#FF0000'
mdanghoc = '#0033FF'
#dadangky = '#009900'
#outside = '#FF9900'
#outside_fail = '#FF99FF'
pass = '#006666'  
fail = '#CCCC00'
enable = '#9900FF'
get '/' do 
  return {:result => :OK}.to_json
end
get '/:id' do
  result = RestClient.get "http://localhost:9495/127.0.0.1/#{params[:id]}"
  t = JSON.parse(result)["nodes"]
  temp = t.map {|k| {:name => k["name"], :group => k["group"], :color => k["color"]}}

  #result.to_s.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'})
  return temp.to_json
end