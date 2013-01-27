require "spec_helper"

describe PreferencesController do
  before(:all) do
    @pref = Preference.create
    @user = User.create
  end

  # GET /preferences
  describe "GET index" do
    it "assigns @preferences" do
      get :index
      assigns(:preferences).should include(@pref)
    end

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end
  end


  # GET /preferences/1
  describe "GET show" do
    it "assigns @preference" do
      get :show, id: @pref
      assigns(:preference).should == @pref
    end

    it "renders the show template" do
      get :show, id: @pref
      response.should render_template(:show)
    end
  end


  # GET /preferences/new
  describe "GET new" do
    context "when a user is signed in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        subject.sign_in @user
      end

      it "assigns @preference" do
        get :new
        assigns(:preference).should be_a(Preference)
      end

      it "renders the new template" do
        get :new
        response.should render_template(:new)
      end
    end

    context "when a user is not signed in" do
      describe "GET new" do
        it "redirects to new_user_session_path" do
          get :new
          response.should redirect_to(new_user_session_path)
        end
      end
    end
  end


  # GET /preferences/1/edit
  describe "GET edit" do
    context "when a user is signed in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        subject.sign_in @user
      end

      it "assigns @preference" do
        get :edit, id: @pref
        assigns(:preference).should be_a(Preference)
      end

      it "renders the edit template" do
        get :edit, id: @pref
        response.should render_template(:edit)
      end
    end

    context "when a user is not signed in" do
      describe "GET edit" do
        it "redirects to new_user_session_path" do
          get :edit, id: @pref
          response.should redirect_to(new_user_session_path)
        end
      end
    end
  end


  # POST /preferences
  describe "POST create" do
    it "assigns @preference" do
      post :create
      assigns(:preference).should be_a(Preference)
    end

    it "redirects to preferences_path" do
      post :create
      response.should redirect_to(preferences_path)
    end
  end


  # PUT /preferences/1
  describe "PUT update" do
    it "assigns @preference" do
      put :update, id: @pref
      assigns(:preference).should == @pref
    end

    it "redirects to preference_path" do
      put :update, id: @pref
      response.should redirect_to(preference_path(@pref))
    end
  end


  # DELETE /preferences/1
  describe "DELETE destroy" do
    before(:each) do
      @tmp_pref = Preference.create
    end

    it "assigns @preference" do
      delete :destroy, id: @tmp_pref
      assigns(:preference).should == @tmp_pref
    end

    it "deletes @preference" do
      expect {
        delete :destroy, id: @tmp_pref
      }.to change(Preference, :count).by(-1)
    end

    it "redirects to preference_url" do
      delete :destroy, id: @tmp_pref
      response.should redirect_to(preference_url)
    end
  end
end
