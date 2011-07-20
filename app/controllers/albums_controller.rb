class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # GET /albums/1/add_tweet.json
  def add_tweet
    @album = Album.find(params[:id])

    @album.add_tweet(params[:identifier], params[:text],
                     params[:from_user_identifier],
                     :created_at        => params[:created_at],
                     :from_user         => params[:from_user],
                     :profile_image_url => params[:profile_image_url],
                     :source            => params[:source],
                     :geo               => params[:geo],
                     :provider_name     => params[:provider_name],
                     :oembed_type       => params[:oembed_type],
                     :url               => params[:url]
                     )

  end

  # GET /albums/1/tweets.json
  #     All tweets for this album oldest to youngest
  def tweets
    alb = Album.find(params[:id])

    @search_results = alb.search_results.
      includes(:tweet => :tweeter).             # optimize away N + 1
      order("tweets.tweet_created_at ASC")      # oldest tweets first
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        #format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
        #format.xml  { head :ok }
        format.html { render :action => "edit" }
        format.xml  { render :xml => "edit"}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
end
