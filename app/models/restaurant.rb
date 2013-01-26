class Restaurant < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :preferences
  has_many :users, through: :preferences
end
