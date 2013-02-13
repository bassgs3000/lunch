class Preference < ActiveRecord::Base
  attr_accessible :like, :dislikes, :user_id, :restaurant_id
  belongs_to :user
  belongs_to :restaurant
  validates :restaurant_id, uniqueness: { scope: :user_id }

  scope :likes, where(like: true)
  scope :dislikes, where(like: false)

  
  def self.evaluate(input = [])
    
    restlist = Restaurant.all.map { |ent| ent.id }
    oldrestlist = Array.new(restlist) #for debugging, not useful
    likelist = []
    dislikelist = []
    
    return "" if input.blank?
    input.map do |userid|
      id = userid.to_i
      Preference.find_all_by_user_id(id).map do |entry|
        if entry.like
          likelist << entry.restaurant_id
        else
          dislikelist << entry.restaurant_id
        end
      end
    end

    likelist.each do |like|
      restlist << like.to_i
    end
    dislikelist.each do |dislike|
      restlist.delete_at(restlist.index(dislike.to_i) || restlist.length)
    end

    return "" if restlist.blank?

    Restaurant.find_by_id(restlist.shuffle.sample.to_i).name

    #p "Result: #{Restaurant.find_by_id(restlist.shuffle.sample.to_i).name} 
    #    Unmodified Rest List #{oldrestlist} Adjusted Rest List #{restlist}, Sample users #{input}
    #    Liked restaurant_id #{likelist} Disliked restaurant_id #{dislikelist}"

  end
end
