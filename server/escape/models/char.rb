class Escape::Models::Char < ActiveRecord::Base

  validates :name, length: { in: 3..20 }, presence: true, uniqueness: true

  def self.login(name, pass)
    char = where(name: name, pass: pass).first
    char.seen!
    char
  end

  def seen!
    update_attribute(:last_seen_at, DateTime.now)
  end

  def location
    [x, y, z]
  end

  def relocate!(new_location)
    update_attributes(
      x: new_location[0],
      y: new_location[1],
      z: new_location[2])
    seen!
  end
end
