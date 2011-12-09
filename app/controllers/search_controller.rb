
class SearchController < ApplicationController
  
  
  
  def index
    #put location in one string
    temp = nil
    if params[:city] && params[:city] != ""
      temp = params[:city]
    end
    if params[:state] && params[:state] != ""
      if temp == nil
        temp = params[:state]
      else
        temp = temp + "," + params[:state]
      end
    end
    if params[:country] && params[:country] != ""
      if temp == nil
        temp = params[:country]
      else
        temp = temp + "," + params[:country]
      end
    end
   #get geo code loaction
  
    if temp
      safe_temp = CGI.escape(temp)
      url = 'http://maps.googleapis.com/maps/api/geocode/json?address='+safe_temp+'&sensor=false'
      data = get_json_results(url)
      geo = data['results'][0]['geometry']['location']['lat'].to_s + ',' + data['results'][0]['geometry']['location']['lng'].to_s + ',50mi'
    else
      geo = ''
    end
    
    #check for username
    if params[:user] && params[:user] != ""
      user = CGI.escape(params[:user])
    else 
      user = ''
    end
    
        if (params[:q].class == Array)
          @term = params[:q].first
        else
          @term = params[:q]
        end
        k = Keyword.find_by_term(@term)
        if k == nil
          k = Keyword.create(@term)
        end
        
    
    
      options = {'term'=> @term,'user'=> user, 'location'=>geo}
      #k.trend
      @paged_results = k.search_twitter(options)
      @images = @paged_results['pictures']
      @title = 'Picturely Search: ' + @term.titleize
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images}
      format.json { render :json => @images}
      format.rss {render :layout => false }
      
    end
  end
  
  def qsearch
    if (params[:q].class == Array)
      @term = params[:q].first
    else
      @term = params[:q]
    end
    k = Keyword.find_by_term(@term)
    if k == nil
      k = Keyword.create(@term)
    end
    
    safe_term = CGI.escape(@term)
    @results = k.get_json_results('http://search.twitter.com/search.json?callback=?&q='+safe_term+'%20instagr%2C%20OR%20twitpic%2C%20OR%20yfrog%2C%20OR%20lockerz%2C%20OR%20twimg&nots=RT&filter=links&rpp=100&include_entities=1')
    respond_to do |format|
      format.html 
      format.json { render :json => @results} 
    end
  end
  
  def next
    @term = params[:q]
    k = Keyword.find_by_term(@term)
    if k == nil
      k = Keyword.create(@term)
    end
    if params[:url]
      @paged_results = k.get_search_results("http://search.twitter.com/search.json" + params[:url])
      @images = @paged_results['pictures']
      @title = 'Picturely: ' + @term.titleize
    else
      @images = []
      @title = ''
    end
    
    render :index
    
  end
  
  def prev
    @term = params[:q]
    k = Keyword.find_by_term(@term)
    if k == nil
      k = Keyword.create(@term)
    end
    if params[:url]
      @paged_results = k.get_search_results("http://search.twitter.com/search.json" + params[:url])
      @images = @paged_results['pictures']
      @title = 'Picturely: ' + @term.titleize
    else
      @images = []
      @title = ''
    end

    render :index
  end  
  
  def get_json_results(url)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    temp = JSON.parse(data)
  end
  
end
