class TweetSearcher
  include HTTParty
  base_uri 'search.twitter.com'

  def initialize term
    @term = term
  end

  def search
    options = {:query => {:q => @term, :rpp => 100, :exclude => "retweets"}}
    self.class.get('/search.json', options)
  end
end

