require 'curb'

class RealurlController < ApplicationController
  respond_to :html, :xml, :json

  def resolve
    c = Curl::Easy.http_head(params[:url]) {|easy| easy.follow_location = false}

    headers = c.header_str.split(/[\r\n]+/)
    locations = headers.grep(/^Location: /)
    header = locations.first
    @realurl = header.sub(/^Location: /, "")

    respond_with @realurl
=begin
    respond_to do |format|
      format.html
      format.json
      format.xml
    end
=end
  end

end
