class DishType < ActiveRecord::Base
  has_many :dishes
  attr_accessible :name
end
