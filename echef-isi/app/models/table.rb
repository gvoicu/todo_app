class Table < ActiveRecord::Base
  has_many :orders
  has_many :notifications

  attr_accessible :number, :persons, :qr_code
  
  validates :number, :presence => true, :uniqueness => true
  validates :persons, :presence => true
  
  default_scope :order => "id ASC"

  def get_active_orders
    self.orders.find_all{ |o| o.is_open? }
  end

  def has_notification?
    Notification.where(:table_id => self.id, :status => [false, nil]).present?
  end
end
