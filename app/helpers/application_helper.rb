
module ApplicationHelper
  
  def isLive?(url)
    if url
      uri = URI.parse(url)
      response = nil
      response = Net::HTTP.get_response(uri)
      if response.code >= "200" && response.code < "400" 
        return true
      end
    end  
    return false
  end
  
end
