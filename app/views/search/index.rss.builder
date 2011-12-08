xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:media" => 'http://search.yahoo.com/mrss/' do
  xml.channel do
    xml.title @title
    xml.link "http://picture.ly"
    xml.description "Your Picture.ly view of the social web"
    
    @images.each do |image|
      xml.item do
        xml.title 'Photo of '+ @term.titleize + " by " + image.user.titleize
        xml.pubDate image.created_at
        xml.link picture_path(:id => image.id)
        xml.description image.text
        xml.media(:content, :url => image.image_url, :type => 'image/jpeg')
      end
    end
  end
end
        
        
      
      
