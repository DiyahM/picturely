class PagesController < ApplicationController
  
  
  
  def home
    @title = "Picture.ly Home"
    
   @term = ' '
   @picture = Picture.last
    
    
    
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About Picture.ly"
    @term = ''
  end

end
