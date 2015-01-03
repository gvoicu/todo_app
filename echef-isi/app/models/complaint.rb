class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Complaint < ActiveRecord::Base
  attr_accessible :body, :email, :name, :phone
  validates :name, :format => {:with => /[a-zA-Z]/, :message => 'should contain only letters!'}
  validates :phone, :numericality => { :only_integer => true, :message => 'should contain only numbers!'}, :length => {:is => 10}
  validates :body, :presence => true
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => 'is not an email!'}
end
