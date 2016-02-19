class Person < ActiveRecord::Base
  belongs_to :household
  has_many :bowls
end
