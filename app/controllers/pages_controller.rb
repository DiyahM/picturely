class PagesController < ApplicationController
  
  
  
  def home
    
    if Keyword.count < 1
      Keyword.create('san francisco')
    end
   
    trending_keyword = Keyword.find(:first, :order => 'frequency DESC')
    trending_keyword.frequency = trending_keyword.frequency - 1
    trending_keyword.save
 

    redirect_to search_path(:q=>trending_keyword.term)
    
    
    
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About Picture.ly"
  end

end
