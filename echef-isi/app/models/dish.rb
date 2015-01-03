class Dish < ActiveRecord::Base
  belongs_to :dish_type
  attr_accessible :grams, :ingredients, :price, :time, :photo, :dish_type_id, :name
  
  has_attached_file :photo, :styles => { :small => "220x130>" },
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                  :default_url => "/assets/noimage.jpg"
                  
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  validates :name, :presence => true
  validates :ingredients, :presence => true
  validates :grams, :presence => true
  validates :price, :presence => true
  validates :time, :presence => true
  validates :dish_type, :presence => true

  has_many :order_dishes
  has_many :orders, :through => "order_dishes"
end
