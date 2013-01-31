require "spec_helper"

describe RestaurantsController do
  before(:all) do
    @rst = Restaurant.create
    @user = User.create
  end

  # GET /restaurants
  describe "GET index" do
    it "assigns @restaurants" do
      get :index
      assigns(:restaurants).should include(@rst)
    end

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end
  end


  # GET /restaurants/1
  describe "GET show" do
    it "assigns @restaurant" do
      get :show, id: @rst
      assigns(:restaurant).should == @rst
    end

    it "renders the show template" do
      get :show, id: @rst
      response.should render_template(:show)
    end
  end


  # GET /restaurants/new
  describe "GET new" do
    context "when a user is signed in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        subject.sign_in @user
      end

      it "assigns @restaurant" do
        get :new
        assigns(:restaurant).should be_a(Restaurant)
      end

      it "renders the new template" do
        get :new
        response.should render_template(:new)
      end
    end

    context "when a user is not signed in" do
      it "redirects_to new_user_session_path" do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end
  end


  # GET /restaurants/1/edit
  describe "GET edit" do
    context "when a user is signed in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        subject.sign_in @user
      end

      it "assigns @restaurant" do
        get :edit, id: @rst
        assigns(:restaurant).should be_a(Restaurant)
      end

      it "renders the edit template" do
        get :edit, id: @rst
        response.should render_template(:edit)
      end
    end

    context "when a user is not signed in" do
      describe "GET edit" do
        it "redirects to new_user_session_path" do
          get :edit, id: @rst
          response.should redirect_to(new_user_session_path)
        end
      end
    end
  end


  # POST /restaurants
  describe "POST create" do
    it "assigns @restaurant" do
      post :create
      assigns(:restaurant).should be_a(Restaurant)
    end

    it "redirects to restaurants_path" do
      post :create
      response.should redirect_to(restaurants_path)
    end
  end


  # POST /restaurants/1/like
  describe "POST like" do
    it "creates a new, associated, 'like' Preference" do
      expect {
        post :like, id: @rst
      }.to change(Preference, :count).by(1)
    end

    it "redirects_to restaurants_path" do
      post :like, id: @rst
      response.should redirect_to(restaurants_path)
    end
  end


  # POST /restaurants/1/like
  describe "POST dislike" do
    it "creates a new, associated, 'dislike' Preference" do
      expect {
        post :dislike, id: @rst
      }.to change(Preference, :count).by(1)
    end

    it "redirects_to restaurants_path" do
      post :dislike, id: @rst
      response.should redirect_to(restaurants_path)
    end
  end


  # PUT /restaurants/1
  describe "PUT update" do
    it "assigns @restaurant" do
      put :update, id: @rst
      assigns(:restaurant).should == @rst
    end

    it "redirects to restaurant_path" do
      put :update, id: @rst
      response.should redirect_to(restaurant_path(@rst))
    end
  end


  # DELETE /restaurants/1
  describe "DELETE destroy" do
    before(:each) do
      @tmp_rst = Restaurant.create
    end

    it "assigns @restaurant" do
      delete :destroy, id: @tmp_rst
      assigns(:restaurant).should == @tmp_rst
    end

    it "deletes @restaurant" do
      expect {
        delete :destroy, id: @tmp_rst
      }.to change(Restaurant, :count).by(-1)
    end

    it "redirects to restaurant_url" do
      delete :destroy, id: @tmp_rst
      response.should redirect_to(restaurants_path)
    end
  end
end
