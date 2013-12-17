#encoding: utf-8
require 'sinatra'
require 'rest_client'
require 'yajl/json_gem'
require 'json'
require 'thin'
require 'celluloid/autostart'
require_relative './job'


before do
    content_type 'application/json'
end

configure do
  set :server, %w[thin]
  set :bind, '0.0.0.0'
  set :port, 9494
  set :chuahoc, '#FF0000'
  set :danghoc, '#0033FF'
  set :daqua, '#006666'  
  set :no, '#CCCC00'
  set :duocdangky, '#9900FF'
end


get '/' do 
  return {:result => :OK}.to_json
end
get '/:makhoa/:mahe/:manganh' do
  j = Job.new
  res = j.process(params[:makhoa], params[:mahe], params[:manganh])  
  #result.to_s.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'})  
  return res.to_json
end