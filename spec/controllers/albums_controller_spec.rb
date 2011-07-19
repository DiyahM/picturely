require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AlbumsController do

  # This should return the minimal set of attributes required to create a valid
  # Album. As you add validations to Album, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :user_id => 1
    }
  end

  describe "GET index" do
    it "assigns all albums as @albums" do
      album = Album.create! valid_attributes
      get :index
      assigns(:albums).should eq([album])
    end
  end

  describe "GET show" do
    it "assigns the requested album as @album" do
      album = Album.create! valid_attributes
      get :show, :id => album.id.to_s
      assigns(:album).should eq(album)
    end
  end

  describe "GET new" do
    it "assigns a new album as @album" do
      get :new
      assigns(:album).should be_a_new(Album)
    end
  end

  describe "GET edit" do
    it "assigns the requested album as @album" do
      album = Album.create! valid_attributes
      get :edit, :id => album.id.to_s
      assigns(:album).should eq(album)
    end
  end

  describe "GET add_tweet" do
    before :each do
      @alb = Album.create! valid_attributes
    end

    it "assigns the requested album as @album" do
      get(:add_tweet, :id => @alb.id.to_s, :format => 'json',
          :identifier           => "222333444",
          :text                 => "Hello World",
          :from_user_identifier => "555666")
      assigns(:album).should eq(@alb)
    end

    it "should create a Tweet" do
      expect {
        get(:add_tweet, :id => @alb.id.to_s, :format => 'json',
            :identifier           => "333444555666",
            :text                 => "Goodbye, cruel world!",
            :from_user_identifier => "777888")
      }.to change(Tweet, :count).by(1)
    end

  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Album" do
        expect {
          post :create, :album => valid_attributes
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, :album => valid_attributes
        assigns(:album).should be_a(Album)
        assigns(:album).should be_persisted
      end

      it "redirects to the created album" do
        post :create, :album => valid_attributes
        response.should redirect_to(Album.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, :album => {}
        assigns(:album).should be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, :album => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested album" do
        album = Album.create! valid_attributes
        # Assuming there are no other albums in the database, this
        # specifies that the Album created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Album.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => album.id, :album => {'these' => 'params'}
      end

      it "assigns the requested album as @album" do
        album = Album.create! valid_attributes
        put :update, :id => album.id, :album => valid_attributes
        assigns(:album).should eq(album)
      end

      it "redirects to the album" do
        album = Album.create! valid_attributes
        put :update, :id => album.id, :album => valid_attributes
        response.should redirect_to(album)
      end
    end

    describe "with invalid params" do
      it "assigns the album as @album" do
        album = Album.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, :id => album.id.to_s, :album => {}
        assigns(:album).should eq(album)
      end

      it "re-renders the 'edit' template" do
        album = Album.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        put :update, :id => album.id.to_s, :album => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested album" do
      album = Album.create! valid_attributes
      expect {
        delete :destroy, :id => album.id.to_s
      }.to change(Album, :count).by(-1)
    end

    it "redirects to the albums list" do
      album = Album.create! valid_attributes
      delete :destroy, :id => album.id.to_s
      response.should redirect_to(albums_url)
    end
  end

end
