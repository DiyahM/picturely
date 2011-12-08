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
    k.trend
    @paged_results = k.search_twitter
    @images = @paged_results['pictures']
    @title = 'Picturely: ' + @term.titleize
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images}
      format.json { render :json => @images}
      format.atom {render :layout => false }
      format.rss {redirect_to feed_path(:format => :atom), :status => :moved_permanently }
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
