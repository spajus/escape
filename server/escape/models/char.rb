class Char < ActiveRecord::Base

  validates :name, length: { minimum: 3, maximum: 20 }, presence: true, uniqueness: true

end
