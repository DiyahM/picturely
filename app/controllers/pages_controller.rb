class PagesController < ApplicationController
  
  
  
  def home
    @title = "Picture.ly Home"
    
   @term = ' '  
    
  end
  
  def searchplus
    @title = "Picture.ly"
    @term = ''
  end

  def contact
    @title = "Contact"
    @term = ' '
  end

  def about
    @title = "About Picture.ly"
    @term = ''
  end

end
