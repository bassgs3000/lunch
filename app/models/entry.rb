class Entry < ActiveRecord::Base
  attr_accessible :dislikes, :likes, :user_id, :restaurant_id
  belongs_to :user
  belongs_to :restaurant

  def self.likes
    self.all.map { |entry| entry.likes }*", "
  end

  def self.dislikes
    self.all.map { |entry| entry.dislikes }*", "
  end

  def self.count
    likes = self.all.map { |entry| entry.likes }
    dislikes = self.all.map { |entry| entry.dislikes }

    # Next 2 lines are used to take the multiple arrays and format it properly.
    combo = %W[#{(likes + dislikes)*", "}]
    comboary = combo[0].split(", ")
    counts = Hash.new(0)
    comboary.each { |rest| counts[rest] += 1}
    counts.values.sum
  end

  def self.evaluate
    likes = %W[#{self.all.map { |entry| entry.likes }*", "}]
    dislikes = %W[#{self.all.map { |entry| entry.dislikes }*", "}]

    likesary = likes[0].split(", ")
    dislikesary = dislikes[0].split(", ")
    counterlike = Hash.new(0)
    counterdislike = Hash.new(0)

    likesary.each { |like| counterlike[like] += 1 }
    dislikesary.each { |dislike| counterdislike[dislike] -= 1 }

    #Merges the 2 differences, I will later evaluate only results > 0.
    results = counterlike.merge(counterdislike) { |key, old, new| old + new }

    positive = results.select{ |k,v| v > 0 }


    ary = (positive.map { |k,v| (k.gsub(' ','_') + ' ') * v }*"").split(' ')
    ary = ary.map { |entry| entry.gsub('_', ' ') }

    sample = ary.shuffle.sample
  end

end
