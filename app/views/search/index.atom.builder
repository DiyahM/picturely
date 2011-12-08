atom_feed do |feed|
  feed.title @title
  feed.updated @images.first.created_at
  
  @images.each do |image|
    feed.entry(image) do |entry|
      entry.title 'Photo of '+ @term.titleize + " by " + image.user.titleize
      entry.content image.image_url, :type => 'image'
      entry.content image.text, :type => 'html'
      
      entry.author do |author|
        author.name image.user.titleize
      end
    end
  end
end