class Restaurant < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :entries
  has_many :users, through: :entries
end
