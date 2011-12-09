
module ApplicationHelper
  
  def isLive?(url)
    if url
      uri = URI.parse(url)
      response = nil
      begin
        response = Net::HTTP.get_response(uri)
        rescue
          return false
        else
          if response.code >= "200" && response.code < "400" 
            return true
          end
        end
    end  
    return false
  end
  
  
  
end
