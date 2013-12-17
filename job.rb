#encoding: utf-8
require 'savon'
#require 'celluloid/autostart'

class Job
  #include Celluloid

  def initialize        
   # @chuahoc = '#FF0000' 
   # @danghoc = '#0033FF'
   # @daqua, '#006666'  
   # @no, '#CCCC00'
   # @duocdangky, '#9900FF'
    @status = {'#FF0000' => 1, '#CCCC00' => 2, '#0033FF' => 3, '#006666' => 4, '#9900FF' => 5}
    @client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")    
  end 
  def load_sv(ma_khoa_hoc, ma_he_dao_tao, ma_nganh)    
    response = @client.call(:sinh_vien_khoa_he_nganh) do 
      message(makhoahoc: ma_khoa_hoc, mahedaotao: ma_he_dao_tao, manganh: ma_nganh)
    end
    res_hash = response.body.to_hash
    result = res_hash[:sinh_vien_khoa_he_nganh_response][:sinh_vien_khoa_he_nganh_result][:diffgram][:document_element][:sinh_vien_khoa_he_nganh]
    return result.map {|k| k[:ma_sinh_vien] and k[:ma_sinh_vien].strip}
  end
  
  def transform(res)
    res.group_by {|t| [t["group"], t["mamon"]]}.map {|k,v| {:key => k, :count => v.count, :value => v}}
  end

  def process(ma_khoa_hoc, ma_he_dao_tao, ma_nganh)
    keys = ["name","group","color","ma_sinh_vien","mamon","status"]
    svs = load_sv(ma_khoa_hoc, ma_he_dao_tao, ma_nganh)
    return nil if svs.count == 0
    @result = []
    svs.each do |sv|
      tmp = RestClient.get "http://localhost:9495/127.0.0.1/#{sv}"
      @result += JSON.parse(tmp)["nodes"]  
      @result.map {|t| t["ma_sinh_vien"] = sv ; t["status"] = @status[t["color"]];t}            
    end        
    x = @result.map {|t| t.reject { |key,_| !keys.include? key }  }
    transform(x)
  end
end