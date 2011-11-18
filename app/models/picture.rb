require 'flickr'
require 'net/http'
require 'uri'

# == Schema Information
# Schema version: 20110715101503
#
# Table name: pictures
#
#  id         :integer(4)      not null, primary key
#  image_host :string(255)
#  image_url  :string(255)
#  owner      :string(255)
#  tweet      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Picture < ActiveRecord::Base
  has_many :categorizations
  has_many :keywords, :through => :categorizations
  validates :url, :uniqueness => true
  validates :url, :presence => true
  
  def initialize(params)
    super(params)
    if url
      set_image_host 
      set_image_url
    end
  end
  
  def set_image_host
    if url.include? 'flickr'
      self.image_host = 'flickr'
    elsif url.include? 'twitpic'
      self.image_host = 'twitpic'
    elsif url.include? 'yfrog'
      self.image_host = 'yfrog'
    elsif url.include? 'twimg'
      self.image_host = 'twitter'
    elsif url.include? 'instagr'
      self.image_host = 'instagram'
    elsif url.include? 'lockerz'
      self.image_host = 'lockerz'
    else
      self.image_host = 'unknown'
      return
    end
    self.save
  end
  
  def set_image_url
    if url.include? 'flickr'
      #client = Flickr.new(api_key='78e1ac033aac162b1b8499feb8543682')
      self.image_url = nil
    elsif url.include? 'twitpic'
      t = url.split('twitpic.com/')
      self.image_url = "http://twitpic.com/show/large/" + t.last
    elsif url.include? 'yfrog'
      self.image_url = url + ':medium'
    elsif url.include? 'twimg'
      self.image_url = self.url
    elsif url.include? 'instagr'
      self.image_url = url + '/media/?size=l'
      if self.image_url.include? '//media'
        self.image_url = url + 'media/?size=l'
      end
    elsif url.include? 'lockerz'
      self.image_url= 'http://api.plixi.com/api/tpapi.svc/imagefromurl?url='+url+'&size=big'
    else
      self.image_url = nil
      return
    end
    self.save 
  end
  
  
  
  
end
