class Notification < ActiveRecord::Base
  belongs_to :table
  attr_accessible :note, :status, :table_id
end
