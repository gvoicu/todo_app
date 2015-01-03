class Booking < ActiveRecord::Base
  belongs_to :table
  attr_accessible :confirmed, :email, :end, :name, :phone, :start, :table
  attr_accessible :start, :start_date, :start_at_time
  attr_accessible :end, :end_at_time
  
  attr_accessor :start_date, :start_at_time
  attr_accessor :end_at_time
  
  after_initialize :get_datetimes # convert db format to accessors
  before_validation :set_datetimes # convert accessors back to db format
  
  validates_format_of :start_at_time, :with => /\d{1,2}:\d{2}/
  validates_format_of :end_at_time, :with => /\d{1,2}:\d{2}/
  
  validates :phone, :presence => true, :numericality => { :only_integer => true, :message => 'should contain only numbers!'}, :length => {:is => 10}
  validates :name, :presence => true, :format => {:with => /[a-zA-Z]/, :message => 'should contain only letters!'}
  validates :email, :presence => true, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => 'is not an email!'}
  
  def get_datetimes
    self.start ||= Time.now  # if the start_at time is not set, set it to now
    self.end ||= Time.now

    self.start_date ||= self.start.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
    self.start_at_time ||= "#{'%02d' % self.start.hour}:#{'%02d' % self.start.min}" # extract the time
    
    self.end_at_time ||= "#{'%02d' % self.end.hour}:#{'%02d' % self.end.min}" # extract the time
  end

  def set_datetimes
    self.start = "#{self.start_date} #{self.start_at_time}:00" # convert the two fields back to db
    
    self.end = "#{self.start_date} #{self.end_at_time}:00" # convert the two fields back to db
  end 
end
