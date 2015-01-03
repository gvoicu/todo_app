class Order < ActiveRecord::Base
  belongs_to :table
	belongs_to :user, :class_name => 'Waiter', :foreign_key => 'waiter_id'
	belongs_to :user, :class_name => 'Chef', :foreign_key => 'chef_id'

  has_many :order_dishes
  has_many :dishes, :through => :order_dishes

  attr_accessible :closed_at, :rating, :table_id

  def calculate_total_sum
    self.dishes.sum(:price)
  end

  def pay
    OrderDish.where(:order_id => self.id, :dish_status => Constant::DS_CHECK).update_all(:dish_status => Constant::DS_PAYED)
  end

  def close
    self.update_attributes(:closed_at => Time.now)
  end

  def is_payed?
    unpaid = OrderDish.where("order_id = ? AND dish_status != ?", self.id, Constant::DS_PAYED)
    if unpaid.any?
      return false
    else
      return true
    end
  end

  def is_open?
    if self.closed_at
      return false
    else
      return true 
    end
  end
end
