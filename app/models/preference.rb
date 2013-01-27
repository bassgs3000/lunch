class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  def self.evaluate
    # stuff
  end
end
