class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
      format.js { render :layout=>false }
    end
  end


  def show
    @restaurant = Restaurant.find(params[:id])
    # @user= User.find(@restaurant.user_id)  # BROKEN

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      if user_signed_in?
        format.html # new.html.erb
        format.json { render json: @restaurant }
      else
        format.html { redirect_to new_user_session_path, notice: 'Please sign in to create a restaurant' }
        format.json { render :layout=>false }
      end
    end
  end


  def edit
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if user_signed_in?
        format.html # new.html.erb
        format.json { render json: @restaurant }
      else
        format.html { redirect_to new_user_session_path, notice: 'Please sign in to edit a restaurant' }
        format.json { render :layout=>false }
      end
    end
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurants_path, notice: 'Restaurant was successfully created.' }
        format.json { render json: restaurants_path, status: :created, location: @restaurant }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    restaurant = Restaurant.find(params[:id])
    preference = Preference.new do |p|
      p.restaurant = restaurant
      p.user = current_user
    end

    preference.like = true

    respond_to do |format|
      if preference.save
        format.html { redirect_to restaurants_path, notice: 'Preference was successfully created.' }
        format.json { render json: restaurants_path, status: :created, location: preference }
      else
        format.html { redirect_to restaurants_path, notice: 'Something went wrong'}
        format.json { render json: preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def dislike
    restaurant = Restaurant.find(params[:id])
    preference = Preference.new do |p|
      p.restaurant = restaurant
      p.user = current_user
    end

    preference.like = false

    respond_to do |format|
      if preference.save
        format.html { redirect_to restaurants_path, notice: 'Preference was successfully created.' }
        format.json { render json: restaurants_path, status: :created, location: preference }
      else
        format.html { redirect_to restaurants_path, notice: 'Something went wrong'}
        format.json { render json: preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_path }
      format.json { head :no_content }
    end
  end
end
