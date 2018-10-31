class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.boats
    Boat.arel_table
  end

  def self.first_five
    limit(5)
  end

  def self.longest
    order(length: :desc).first
  end

  def self.dinghy
    where(boats[:length].lt(20))
  end

  def self.ship
    where(boats[:length].gteq(20))
  end

  def self.last_three_alphabetically
    order(boats[:name].desc).limit(3)
  end

  def self.without_a_captain
    where(boats[:captain_id].eq(nil))
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat'} )
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

end
