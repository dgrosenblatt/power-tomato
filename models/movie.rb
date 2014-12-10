class Movie < ActiveRecord::Base
  validates :rt_id, uniqueness: true
end
