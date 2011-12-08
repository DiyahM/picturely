xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:media" => 'http://search.yahoo.com/mrss/', "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title @title
    xml.link "http://picture.ly"
    xml.description "Your Picture.ly view of the social web"
    xml.atom(:link, :href => request.url, :rel => "self", :type => "application/rss+xml")
    
    @images.each do |image|
      xml.item do
        xml.title 'Photo of '+ @term.titleize + " by " + image.user.titleize
        xml.pubDate image.created_at.to_s(:rfc822)
        xml.link picture_url(:id => image.id)
        xml.guid picture_url(:id => image.id)
        xml.description image.text
        xml.media(:content, :url => image.image_url, :type => 'image/jpeg')
      end
    end
  end
end
        
        
      
      
