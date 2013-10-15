class Cell < ActiveRecord::Base

  validate :desc, length: { maximum: 140 }
  belongs_to :creator, class_name: 'Char'

  def self.exists_at?(location)
    where(x: location[0], y: location[1], z: location[2]).any?
  end

  def self.describe(options)
    location = options.delete(:location)
    options = options.merge(parse_location(location))
    new(options)
  end

  def self.parse_location(location)
    { x: location[0],
      y: location[1],
      z: location[2] }
  end

end
