# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

def test_tweet_attribs
  {
    :identifier => 89975912136835073,
    :text => "Krisna #bali #iphoneography #iphonesia #iphonesian   @ Krisna Oleh-Oleh Khas Bali http://instagr.am/p/HWT-R/",
    :created_at => Time.parse("Sun, 10 Jul 2011 08:35:03 +0000"),
    :from_user_identifier => 9399124,
    :from_user => "karinarizal",
    :profile_image_url => "http://a3.twimg.com/profile_images/1423609813/mqcnE_normal.jpg",
    :source => "&lt;a href=&quot;http://instagr.am&quot; rel=&quot;nofollow&quot;&gt;instagram&lt;/a&gt;",
    :geo => "point(-4.1234, 101.3546)",
    :provider_name => "Instagram",
    :oembed_type => "photo",
    :url => "http://images.instagram.com/media/2011/07/10/ec3ca2718934472597b377fe10c5394b_7.jpg"
  }
end

RSpec.configure do |config|
  
  def test_sign_in(user)
    controller.sign_in(user)
  end

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end
