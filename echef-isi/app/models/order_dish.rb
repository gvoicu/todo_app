class OrderDish < ActiveRecord::Base
  belongs_to :order
  belongs_to :dish
  attr_accessible :dish_status, :note, :time, :dish_id, :order_id
  #default_scope :order => "dish_status ASC"

  DS_PENDING   = 1
  DS_PREPARING = 2
  DS_READY     = 3
  DS_DELIVERED = 4
  DS_CHECK     = 5
  DS_PAYED     = 6

  def is_pending?
    self.dish_status == Constant::DS_PENDING || self.dish_status.nil?
  end

  def is_preparing?
    self.dish_status == Constant::DS_PREPARING
  end

  def is_ready?
    self.dish_status == Constant::DS_READY
  end

  def is_delivered?
    self.dish_status == Constant::DS_DELIVERED
  end
  
  def is_check?
    self.dish_status == Constant::DS_CHECK
  end
  
  def is_payed?
    self.dish_status == Constant::DS_PAYED
  end
end
