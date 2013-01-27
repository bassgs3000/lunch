class PreferencesController < ApplicationController
  # GET /preferences
  # GET /preferences.json
  def index
    @preferences = Preference.all
    @likes = []
    @dislikes = []
    @count = Preference.count
    @evaluate = Preference.evaluate

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preferences }
      format.js { render :layout=>false }
    end
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
    @preference = Preference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @preference }
    end
  end

  # GET /preferences/new
  # GET /preferences/new.json
  def new
    @preference = Preference.new

    respond_to do |format|
      if user_signed_in?
        format.html # new.html.erb
        format.json { render json: @preference }
      else
        format.html { redirect_to new_user_session_path, notice: 'Please sign in to create an preference' }
        format.json { render :layout=>false }
      end
    end
  end

  # GET /preferences/1/edit
  # GET /preferences/1/edit.json
  def edit
    @preference = Preference.find(params[:id])

    respond_to do |format|
      if user_signed_in?
        format.html # new.html.erb
        format.json { render json: @preference }
      else
        format.html { redirect_to new_user_session_path, notice: 'Please sign in to edit an preference' }
        format.json { render :layout=>false }
      end
    end
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = Preference.new(params[:preference])

    respond_to do |format|
      if @preference.save
        format.html { redirect_to preferences_path, notice: 'Preference was successfully created.' }
        format.json { render json: preferences_path, status: :created, location: @preference }
      else
        format.html { render action: "new" }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /preferences/1
  # PUT /preferences/1.json
  def update
    @preference = Preference.find(params[:id])

    respond_to do |format|
      if @preference.update_attributes(params[:preference])
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  def destroy
    @preference = Preference.find(params[:id])
    @preference.destroy

    respond_to do |format|
      format.html { redirect_to preference_url }
      format.json { head :no_content }
    end
  end
end
