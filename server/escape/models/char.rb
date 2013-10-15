class Char < ActiveRecord::Base

  validates :name, length: { in: 3..20 }, presence: true, uniqueness: true

  def seen!
    update_attribute(:last_seen_at, DateTime.now)
  end
end
