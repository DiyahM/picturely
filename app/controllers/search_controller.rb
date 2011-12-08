class SearchController < ApplicationController
  
  
  
  def index
    if (params[:q].class == Array)
      @term = params[:q].first
    else
      @term = params[:q]
    end
    k = Keyword.find_by_term(@term)
    if k == nil
      k = Keyword.create(@term)
    end
    #k.trend
    @paged_results = k.search_twitter
    @images = @paged_results['pictures']
    @title = 'Picturely: ' + @term.titleize
    
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
    @paged_results = k.get_search_results("http://search.twitter.com/search.json" + params[:url])
    @images = @paged_results['pictures']
    @title = 'Picturely: ' + @term.titleize
    
    render :index
    
  end
  
  def prev
    @term = params[:q]
    k = Keyword.find_by_term(@term)
    @paged_results = k.get_search_results("http://search.twitter.com/search.json" + params[:url])
    @images = @paged_results['pictures']
    @title = 'Picturely: ' + @term.titleize

    render :index
  end  
  
end
