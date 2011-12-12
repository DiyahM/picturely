require 'open-uri'

class Keyword < ActiveRecord::Base
  has_many :categorizations
  has_many :pictures, :through => :categorizations
  
  validates :term, :presence => true
  validates :term, :uniqueness => true
  
  def initialize(term)
    super(:term => term, :frequency => 0)
  end
  
  def search_twitter_client
    results = Twitter.images(term)
    if !results.empty?
      results.each do |result|
        p = Picture.new(result)
        p.user = result.user.screen_name
        saved = p.save
        if saved
          c = Categorization.create(:picture_id => p.id, :keyword_id => self.id)
        end
      end
    end     
  end
  
  def search_twitter(options = {'term' => '', 'user'=> '', 'location'=>'', 'rpp' => '50'})
    safe_term = CGI.escape(options['term'])
    if options['rpp'] == nil
      options['rpp'] = '50'
    end
    #url = 'http://search.twitter.com/search.json?callback=?&q='+safe_term+'%20instagr%2C%20OR%20twitpic%2C%20OR%20yfrog%2C%20OR%20lockerz%2C%20OR%20twimg%2C%20ORpic.twitter.com&nots=RT&from='+options['user']+'&rpp='+options['rpp']+'&geocode='+options['location']+'&include_entities=1'
    url = 'http://search.twitter.com/search.json?q='+safe_term+'%20pic.twitter.com%20OR%20yfrog%20OR%20instagr.am%20OR%20twitpic%20OR%20lockerz%20OR%20instagram.com&from='+options['user']+'&nots=RT&rpp='+options['rpp']+'&geocode='+options['location']+'&include_entities=1'
    get_search_results(url)
  end
  
  def get_search_results(url)
    temp = get_json_results(url)
    results = temp['results']
    pictures = []
    if !results.empty?
      pictures = save_pictures(results)
    end
    paged_results = {"pictures" => pictures, "next_page" => temp['next_page'], "previous_page" => temp['previous_page'], "page" => temp['page'], "refresh_url" => temp['refresh_url'], "query" => temp['query']}
    return paged_results
  end
  
  
  
  def cached_pictures
    Rails.cache.fetch('self.pictures', :expires_in => 1.minute) {self.pictures.find(:all, :order => 'created_at Desc')}
  end
  
  
  
  def save_pictures(results)
    pictures = []
    results.each do |result|
      if result['entities']['media']
        result['entities']['media'].each do |media|
          image_url = media['expanded_url']
          media_url = media['media_url']
          p = save_picture(result,image_url,media_url)
          if p
            pictures.push(p)
          end
        end
      end
      if result['entities']['urls']
        result['entities']['urls'].each do |url|
          image_url = url['expanded_url']
          p = save_picture(result,image_url)
          if p
            pictures.push(p)
          end
        end
      end
    end
    return pictures
  end
  
  def save_picture(result, image_url, media_url = nil)
    if result['geo']
      location = result['geo']['coordinates'][0].to_s + "," + result['geo']['coordinates'][1].to_s
    end
    p = Picture.new(:created_at => result['created_at'],
    :id_str => result['id_str'], :geo => location, :user => result['from_user'], :text => result['text'], :url => image_url)
    if media_url
      p.image_url = media_url
    end
    saved = p.save
    if saved
      if result['entities']['hashtags']
        result['entities']['hashtags'].each do |hash|
          if hash['text'] != self.term
            add_tags(p, hash['text'])
          end
        end
      end
      c = Categorization.create(:picture_id=>p.id, :keyword_id=>self.id)
      return p
    else
      puts p.errors
      if p.errors[:url].first == "has already been taken"
        record = Picture.find_by_url(image_url) 
        return record
      end
    end
    #return nil
  end
  
  def resolve_url(temp_url)
    begin
      resp = open(URI.parse(temp_url))
    rescue URI::InvalidURIError
      return nil
    rescue OpenURI::HTTPError
      return nil
    rescue
      return nil  
    else  
      return resp.base_uri.to_s
    end
  end
  
  def add_tags(picture, hash)
    k = Keyword.find_by_term(hash)
    if k == nil
      k = Keyword.create(hash)
    end
    if hash != term
      Categorization.create(:picture_id=>picture.id, :keyword_id=> k.id)
    end
  end
    
  
  def extract_link(text)
    words = text.split(" ")
    words.each do |word|
      if word.include? 'http'
        if word.include? ' " '
          temp = word.split('"')
          word = temp[0]
        end
        return word
      end
    end
  end
  
  def get_json_results(url)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    temp = JSON.parse(data)
  end
  
  def trend
    self.frequency += 1
    self.save
  end
  
  def search_topsy
    safe_term = CGI.escape(term)
    url = 'http://otter.topsy.com/search.json?q='+safe_term+'&window=dynamic&type=image&perpage=100'
    results = get_json_results(url)
    images = results['response']['list']
    if !images.empty?  
      images.each do |image|
        p = Picture.new(:url => image['url'], :text =>image['content'], :user =>image['trackback_author_nick'], :medium_thumbnail => image['medium_thumbnail'],
                        :small_thumbnail => image['small_thumbnail'])
        saved = p.save
        if saved
         c = Categorization.create(:picture_id=>p.id, :keyword_id=>self.id)
        end
      end
    end
  end
  
end
